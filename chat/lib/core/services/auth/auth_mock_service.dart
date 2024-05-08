import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static final _defaultUser = ChatUser(
      id: '456',
      name: 'Suzana',
      email: 'email@gmail.com',
      imageUrl: '../chat/lib/assets/images/avatar.png');
  static Map<String, ChatUser> _user = {
    _defaultUser.email: _defaultUser,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
    String nome,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: nome,
      email: email,
      imageUrl: image?.path ?? '../chat/lib/assets/images/avatar.png',
    );

    _user.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    _updateUser(_user[email]);
  }

  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
