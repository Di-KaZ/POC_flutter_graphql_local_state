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
        // stream provider is pretty neat, 😎
        child: StreamProvider<Fragment$Conversation>.value(
          value: controller.watchConversation(id),
          catchError: (context, error) {
            // we can catch error and return the last safe value
            // here i just return a loader
            debugPrint('ERROR : ${error.toString()}');
            return Fragment$Conversation$Utils.loader(id);
          },
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
    return Container(
      color: Colors.cyan,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              '${conversation.title} | ${conversation.Messages?.length} msg',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              conversation.description,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<Controller>();
    final conversation = context.watch<Fragment$Conversation>();
    // order message by date converting iso string to date
    final orderedMessages = [...conversation.Messages!];
    orderedMessages.sort(
        (a, b) => DateTime.parse(b!.date).compareTo(DateTime.parse(a!.date)));
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
          subtitle: Text(
            'status = ${message.local__status?.name} | tap_count = ${message.local__counter}',
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: messageContentController,
              decoration: const InputDecoration(
                hintText: 'Type a message',
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            controller.sendMessage(
              Fragment$ChatMessage(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                date: DateTime.now().toString(),
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
