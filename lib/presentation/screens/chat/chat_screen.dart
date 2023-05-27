import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://styles.redditmedia.com/t5_3jytxb/styles/communityIcon_rxz66xlf05s91.jpg'),
          ),
        ),
        title: const Text('My Love'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messagesLists.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messagesLists[index];
                return (message.fromWho == FromWho.hers)
                    ? HerMessageBubble(
                        message: message,
                      )
                    : MyMessageBubble(message: message);
                //   return (index % 2 == 0)
                //       ? const HerMessageBubble()
                //       : const MyMessageBubble();
              },
            ),
          ),
          MessageFieldBox(
            onValue: (value) => chatProvider.sendMessage(value),
          )
        ]),
      ),
    );
  }
}
