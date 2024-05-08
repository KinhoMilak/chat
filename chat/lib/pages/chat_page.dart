import 'package:chat/components/messagens.dart';
import 'package:chat/components/new_messages.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/notification/push_notification_service.dart';
import 'package:chat/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemCount = Provider.of<ChatNotificationService>(context).itemsCount;
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black87,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Sair')
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Stack(children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => NotificationPage()));
              },
              icon: Icon(
                Icons.notifications,
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                maxRadius: 10,
                backgroundColor: Colors.red.shade800,
                child: Text(
                  '${itemCount < 10 ? itemCount : '+9'}',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            )
          ])
        ],
        title: Text('Coder chat'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Menssages()),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Provider.of<ChatNotificationService>(
      //       context,
      //       listen: false,
      //     ).add(ChatNotification(
      //       body: Random().nextDouble().toString(),
      //       title: 'Mais uma notificação',
      //     ));
      //   },
      // ),
    );
  }
}
