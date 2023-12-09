import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/app/blocs/app/app_bloc.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/use_cases/send_message_use_case.dart';
import '../../domain/use_cases/stream_chat_use_case.dart';
import '../blocs/chat/chat_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.chatId});

  final String chatId;

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AppBloc>().state.authUser.id;

    return BlocProvider(
      create: (context) => ChatBloc(
        streamChatUseCase: StreamChatUseCase(
          chatRepository: context.read<ChatRepository>(),
        ),
        sendMessageUseCase: SendMessageUseCase(
          chatRepository: context.read<ChatRepository>(),
        ),
      )..add(ChatGetChat(chatId: chatId)),
      child: ChatView(userId: userId),
    );
  }
}

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: SafeArea(
        top: false,
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state.status == ChatStatus.initial ||
                state.status == ChatStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ChatStatus.loaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.chat.messages.length,
                        itemBuilder: (context, index) {
                          final message = state.chat.messages[index];
                          return _ChatMessage(
                            userId: userId,
                            message: message,
                          );
                        },
                      ),
                    ),
                    const _ChatNewMessage(),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Something went wrong.'));
            }
          },
        ),
      ),
    );
  }
}

class _ChatMessage extends StatelessWidget {
  const _ChatMessage({
    required this.userId,
    required this.message,
  });

  final String userId;
  final Message message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Alignment alignment = (message.senderId == userId)
        ? Alignment.centerLeft
        : Alignment.centerRight;

    Color color = (message.senderId == userId)
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    Color fontColor = (message.senderId == userId)
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: size.width * 0.66),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(message.text, style: TextStyle(color: fontColor)),
      ),
    );
  }
}

class _ChatNewMessage extends StatefulWidget {
  const _ChatNewMessage();

  @override
  State<_ChatNewMessage> createState() => _ChatNewMessageState();
}

class _ChatNewMessageState extends State<_ChatNewMessage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AppBloc>().state.authUser.id;

    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) {
        return previous.text != current.text;
      },
      builder: (context, state) {
        controller.text = state.text ?? '';
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );

        final primaryContainerColor =
            Theme.of(context).colorScheme.primaryContainer;
        final onPrimaryContainerColor =
            Theme.of(context).colorScheme.onPrimaryContainer;

        return TextFormField(
          controller: controller,
          onChanged: (value) =>
              context.read<ChatBloc>().add(ChatWriteMessage(text: value)),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: onPrimaryContainerColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: primaryContainerColor,
            hintText: 'Type here...',
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: onPrimaryContainerColor),
            contentPadding: const EdgeInsets.all(16.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.0),
            ),
            suffixIcon: IconButton(
              color: onPrimaryContainerColor,
              icon: const Icon(Icons.send),
              onPressed: () {
                context.read<ChatBloc>().add(ChatSendMessage(senderId: userId));
              },
            ),
          ),
        );
      },
    );
  }
}
