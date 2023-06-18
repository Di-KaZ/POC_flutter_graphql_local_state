import 'package:graphql/client.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/__generated/local_states.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/fragments/__generated/chat_message.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/fragments/__generated/fragments.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/extensions.dart';
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
        fetchPolicy: FetchPolicy.cacheAndNetwork,
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
        // here we can use cache frist since in the real app we will use a stream to update messages
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        variables: Variables$Query$GetConversation(id: id),
      ),
    );
    return convObserver!.stream;
  }

  /// small example of how to update local state of a cached message
  /// every time we update cache via writeXXX every watchQuery will be updated if query already contain a ref to the updated object
  void updateChatMessageCache(Fragment$ChatMessage message) {
    _client.writeFragment$ChatMessage(data: message, idFields: {});
  }

  Function(GraphQLDataProxy, QueryResult<Mutation$sendMessage>?)?
      _updateQueryConversationCache(
    String conversationId,
    Fragment$ChatMessage newMessage,
  ) {
    return (cache, result) {
      Fragment$ChatMessage? retrivedMessage = result?.parsedData?.createMessage;

      if (retrivedMessage == null) {
        /// if result that mean mutation has failed mark cached message has failed for later use
        /// you can test this by disabling wifi on device
        retrivedMessage = newMessage.withStatus(Enum$MessageStatus.FAILED);
      } else if (result!.isConcrete) {
        // if result is concrete that mean the server has responded with the new server side saved message
        retrivedMessage = retrivedMessage.withStatus(Enum$MessageStatus.SENT);
      } else {
        // if result is not concrete that mean mutation is in progress (optimistic result)
        retrivedMessage =
            retrivedMessage.withStatus(Enum$MessageStatus.SENDING);
      }

      // here we get the latest result from the cache for the query of this conversation
      // we can also use [_client.readQuery$GetConversation]
      final lastetConversationQueryResult = convObserver!.latestResult!;

      // we write directly to the cache the query result with the new message
      // cause a query cant automaticly know that a new message has been added to a specific conversation (1-n)
      // the [convObserver] will automaticly trigger an update from the cache
      // we can apply a similar logic for a messages only stream that fetch new messages from the server the listener can write to the cache
      _client.writeQuery$GetConversation(
        data: lastetConversationQueryResult.parsedData!.addMessage(
          retrivedMessage,
        ),
        // cached query ids is based on the query variables
        variables: Variables$Query$GetConversation(id: conversationId),
      );
    };
  }

  /// This funcion send a message to the server via a mutation
  /// I also add a optimistic result to the mutation to have a snappy ui and a local sate of sending
  /// Since the newly created message is not in the cache yet, the observer will not be updated
  /// So we need to update the query cache manually, internally is add the message to the cache
  /// and then add a reference to it in the conversation query
  void sendMessage(
    Fragment$ChatMessage newMessage,
    String conversationId,
  ) {
    if (convObserver == null) {
      throw Exception('Conversation observer is not initialized');
    }

    _client.mutate$sendMessage(
      Options$Mutation$sendMessage(
        // optimistic result for snappy ui
        typedOptimisticResult: Mutation$sendMessage(createMessage: newMessage),
        update: _updateQueryConversationCache(conversationId, newMessage),
        // mutation variables
        variables: Variables$Mutation$sendMessage(
          member_id: newMessage.Member!.id,
          event_id: conversationId,
          message: newMessage.message,
          date: newMessage.date,
        ),
      ),
    );
  }
}
