import 'package:graphql/client.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/fragments/__generated/chat_message.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/fragments/__generated/fragments.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/fragments/extensions.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/mutations/__generated/send_message.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/queries/__generated/get_conversation.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/queries/__generated/get_event_user.graphql.dart';

class Service {
  final GraphQLClient _client;
  ObservableQuery<Query$GetConversation>? convObserver;
  Service(this._client);

  Future<List<Fragment$EventIdentity>> getUserEvents(String id) async {
    final res = await _client.query$GetEventUser(
      Options$Query$GetEventUser(
        variables: Variables$Query$GetEventUser(id: id),
      ),
    );
    if (res.parsedData == null) {
      return [];
    }

    return res.parsedData!.User!.Members!.map((e) => e!.Event!).toList();
  }

  void _resetConveObserver() {
    convObserver?.close();
    convObserver = null;
  }

  Stream<QueryResult<Query$GetConversation>> watchConversation(String id) {
    _resetConveObserver();
    convObserver = _client.watchQuery$GetConversation(
      WatchOptions$Query$GetConversation(
        fetchResults: true,
        cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: FetchPolicy.cacheFirst,
        variables: Variables$Query$GetConversation(id: id),
      ),
    );
    return convObserver!.stream;
  }

  void updateChatMessageCache(Fragment$ChatMessage message) {
    _client.writeFragment$ChatMessage(data: message, idFields: {});
    convObserver?.fetchResults(fetchPolicy: FetchPolicy.cacheOnly);
  }

  void sendMessage(
    Fragment$ChatMessage newMessage,
    String eventId,
  ) {
    if (convObserver == null) {
      throw Exception('Conversation observer is not initialized');
    }

    _client.mutate$sendMessage(
      Options$Mutation$sendMessage(
        // optimistic result for snappy ui
        typedOptimisticResult: Mutation$sendMessage(createMessage: newMessage),
        update: (cache, result) {
          Fragment$ChatMessage? retrivedMessage =
              result?.parsedData?.createMessage;

          if (retrivedMessage == null) {
            /// if result that mean mutation has failed
            retrivedMessage = newMessage.withStatus(Enum$MessageStatus.FAILED);
          } else if (result!.isConcrete) {
            // if result is concrete that mean mutation has succeed
            retrivedMessage =
                retrivedMessage.withStatus(Enum$MessageStatus.SENT);
          } else {
            // if result is not concrete that mean mutation is in progress (optimistic result)
            retrivedMessage =
                retrivedMessage.withStatus(Enum$MessageStatus.SENDING);
          }

          // here we get the latest result from the cache for the query of this conversation
          final lastetConversationQueryResult = convObserver!.latestResult!;

          // we write directly to the cache the query result with the new message
          // cause a query cant automaticly know that a new message has been added to a specific conversation (1-n)
          // the observer will automaticly trigger an update from the cache
          // There might be way to simplify this logic by using a subscription (not available with the graphql mock server ATM)
          _client.writeQuery$GetConversation(
            data: lastetConversationQueryResult.parsedData!.addMessage(
              retrivedMessage,
            ),
            variables: Variables$Query$GetConversation(id: eventId),
          );
        },
        variables: Variables$Mutation$sendMessage(
          member_id: newMessage.Member!.id,
          event_id: eventId,
          message: newMessage.message,
          date: newMessage.date,
        ),
      ),
    );
  }
}
