import 'package:chat/components/message_bubble.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Menssages extends StatelessWidget {
  const Menssages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return StreamBuilder(
      stream: ChatService().messageStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('Sem dados, andiemos a falare'),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, i) => Container(
              child: MessageBubble(
                key: ValueKey(msgs[i].id),
                message: msgs[i],
                belongsToCurrentUser: currentUser?.id == msgs[i].userId,
              ),
            ),
          );
        }
      },
    );
  }
}
