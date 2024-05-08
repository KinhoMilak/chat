import 'package:chat/core/models/chat_massage.dart';
import 'package:chat/core/services/chat/chat_mock_service.dart';

import '../../models/chat_user.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messageStream();
  Future<ChatMessage> save(String text, ChatUser user);

  factory ChatService() {
    return ChatMockService();
  }
}
