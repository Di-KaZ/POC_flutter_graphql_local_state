import 'package:normalize/normalize.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/__generated/local_states.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/fragments/__generated/chat_message.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/fragments/__generated/fragments.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/queries/__generated/get_conversation.graphql.dart';

extension Fragment$ChatMessage$Utils on Fragment$ChatMessage {
  // helper function to update the status of a message
  Fragment$ChatMessage withStatus(Enum$MessageStatus status) {
    return copyWith(
      local__status: status,
    );
  }

  /// here we define the local state policy for the chat message
  /// its still stored in the same cache as the rest of the data
  /// but we can define custom fields and policies for it
  /// I just add a default value for the status field in not existing or incoming is found
  static TypePolicy localStatePolicy = TypePolicy(
    fields: {
      'local__status': FieldPolicy<String?, String?, String?>(
        read: (existing, options) {
          return existing ?? Enum$MessageStatus.FAILED.name;
        },
        merge: (existing, incoming, options) {
          return incoming ?? existing ?? Enum$MessageStatus.FAILED.name;
        },
      ),
      'local__counter': FieldPolicy<int?, int?, int?>(
        read: (existing, options) {
          return existing ?? 0;
        },
        merge: (existing, incoming, options) {
          return incoming ?? existing ?? 0;
        },
      ),
    },
  );
}

extension Fragment$Conversation$Utils on Fragment$Conversation {
  /// create a fake conversation for the loading state
  static loader(String id) {
    return Fragment$Conversation(
      id: id,
      title: 'loading...',
      description: 'loading...',
      Members: [],
      Messages: [],
    );
  }
}

extension Query$GetConversation$Utils on Query$GetConversation {
  // helper function to add a message to the conversation
  Query$GetConversation addMessage(Fragment$ChatMessage message) {
    return copyWith(
      Event: Event?.copyWith(
        Messages: [
          ...Event!.Messages ?? [],
          message,
        ],
      ),
    );
  }

  // helper function to add messages to the conversation
  Query$GetConversation addMessages(List<Fragment$ChatMessage> messages) {
    return copyWith(
      Event: Event?.copyWith(
        Messages: [
          ...Event!.Messages ?? [],
          ...messages,
        ],
      ),
    );
  }
}
