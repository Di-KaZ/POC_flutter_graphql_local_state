import 'package:flutter/material.dart';
import 'package:poc_graphql_cache_local_state_management/controller.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/fragments/__generated/chat_message.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/fragments/__generated/fragments.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/extensions.dart';
import 'package:provider/provider.dart';

class Conversation extends StatelessWidget {
  final String id;

  const Conversation({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<Controller>();

    return Scaffold(
      body: SafeArea(
        child: StreamProvider<Fragment$Conversation>.value(
          value: controller.watchConversation(id),
          initialData: Fragment$Conversation$Utils.loader(id),
          child: const Column(
            children: [
              ConversationHeader(),
              Expanded(child: MessageList()),
              MessageInput(),
            ],
          ),
        ),
      ),
    );
  }
}

class ConversationHeader extends StatelessWidget {
  const ConversationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final conversation = context.watch<Fragment$Conversation>();
    return Text(conversation.title);
  }
}

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<Controller>();
    final conversation = context.watch<Fragment$Conversation>();
    final orderedMessages = conversation.Messages!
      ..sort((a, b) => b!.date.compareTo(a!.date));
    return ListView.builder(
      controller: controller.messagesScrollController,
      reverse: true,
      itemCount: orderedMessages.length,
      itemBuilder: (context, index) {
        final message = orderedMessages[index]!;
        return ListTile(
          onTap: () => controller.updateChatMessageCache(message.copyWith(
            local__counter: (message.local__counter ?? 0) + 1,
          )),
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${message.Member!.User!.name}  ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextSpan(text: message.message)
              ],
            ),
          ),
          subtitle: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'status ${message.local__status?.name ?? ''}'),
                TextSpan(text: 'counter ${message.local__counter ?? 0}')
              ],
            ),
          ),
        );
      },
    );
  }
}

class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<Controller>();
    final conversation = context.watch<Fragment$Conversation>();
    final TextEditingController messageContentController =
        TextEditingController();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextField(
            controller: messageContentController,
            decoration: const InputDecoration(
              hintText: 'Type a message',
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            controller.sendMessage(
              Fragment$ChatMessage(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                date: DateTime.now().toIso8601String(),
                message: messageContentController.text,
                Member: conversation.Members!.firstWhere(
                    (element) => element!.User!.id == controller.userId)!,
              ),
              conversation.id,
            );
            messageContentController.clear();
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
