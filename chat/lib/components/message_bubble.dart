import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../core/models/chat_massage.dart';

class MessageBubble extends StatelessWidget {
  static const _defaultImage = '../chat/lib/assets/images/avatar.png';
  final ChatMessage message;
  final bool belongsToCurrentUser;
  const MessageBubble({
    super.key,
    required this.message,
    required this.belongsToCurrentUser,
  });

  Widget _showUserImage(String imageUrl) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);

    if (uri.path.contains(_defaultImage)) {
      provider = AssetImage(_defaultImage);
    }
    if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment: belongsToCurrentUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: belongsToCurrentUser
                  ? Colors.grey.shade300
                  : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: belongsToCurrentUser
                    ? Radius.circular(12)
                    : Radius.circular(0),
                bottomRight: belongsToCurrentUser
                    ? Radius.circular(0)
                    : Radius.circular(12),
              ),
            ),
            width: 180,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            margin: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: belongsToCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: belongsToCurrentUser ? Colors.black : Colors.white,
                  ),
                ),
                Text(
                  message.text,
                  textAlign:
                      belongsToCurrentUser ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    color: belongsToCurrentUser ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Positioned(
        top: 0,
        left: belongsToCurrentUser ? null : 165,
        right: belongsToCurrentUser ? 165 : null,
        child: _showUserImage(message.userImageUrl),
      ),
    ]);
  }
}
