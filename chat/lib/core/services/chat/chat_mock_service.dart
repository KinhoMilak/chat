import 'dart:async';
import 'dart:math';

import 'package:chat/core/models/chat_massage.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    // ChatMessage(
    //   id: '1',
    //   text: 'Buenos dias',
    //   createdAt: DateTime.now(),
    //   userId: '123',
    //   userName: 'Marciel',
    //   userImageUrl: '../chat/lib/assets/images/avatar.png',
    // ),
    // ChatMessage(
    //   id: '2',
    //   text: 'hola muchachos',
    //   createdAt: DateTime.now(),
    //   userId: '456',
    //   userName: 'Suzana',
    //   userImageUrl: '../chat/lib/assets/images/avatar.png',
    // ),
    // ChatMessage(
    //   id: '3',
    //   text: 'Agora virou espanhol aqui?',
    //   createdAt: DateTime.now(),
    //   userId: '789',
    //   userName: 'Jorge',
    //   userImageUrl: '../chat/lib/assets/images/avatar.png',
    // ),
    // ChatMessage(
    //   id: '4',
    //   text: 'No!!  XD',
    //   createdAt: DateTime.now(),
    //   userId: '123',
    //   userName: 'Marciel',
    //   userImageUrl: '../chat/lib/assets/images/avatar.png',
    // ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  Stream<List<ChatMessage>> messageStream() {
    return _msgsStream;
  }

  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );
    _msgs.add(newMessage);
    _controller?.add(_msgs.reversed.toList());
    return newMessage;
  }
}
