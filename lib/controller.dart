import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/extensions.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/fragments/__generated/chat_message.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/fragments/__generated/fragments.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/service.dart';

class Controller extends ChangeNotifier {
  Controller(this._service) {
    userIdController.addListener(notifyListeners);
  }

  @override
  void dispose() {
    userIdController.removeListener(notifyListeners);
    userIdController.dispose();
    super.dispose();
  }

  final Service _service;
  final userIdController = TextEditingController();
  final ScrollController messagesScrollController = ScrollController();
  String get userId => userIdController.text;

  Future<List<Fragment$EventIdentity>> getUserEvents() async {
    if (userId.isEmpty) {
      return [];
    }
    return await _service.getUserEvents(userId);
  }

  /// returns a stream of [Fragment$Conversation] from graphql watchQuery
  ///  only watching for cache changes
  Stream<Fragment$Conversation> watchConversation(String id) {
    // first event does not contain data maybe add a optimistic result for for now this will fix it
    return _service.watchConversation(id).map((event) =>
        event.parsedData?.Event ?? Fragment$Conversation$Utils.loader(id));
  }

  void updateChatMessageCache(Fragment$ChatMessage message) {
    _service.updateChatMessageCache(message);
  }

  void sendMessage(
    Fragment$ChatMessage newMessage,
    String eventId,
  ) {
    messagesScrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    _service.sendMessage(
      newMessage,
      eventId,
    );
  }
}
