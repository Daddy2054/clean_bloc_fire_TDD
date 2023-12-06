import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/app/blocs/app/app_bloc.dart';
import '../../../../shared/utils/date_time_extentions.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/use_cases/stream_chats_use_case.dart';
import '../blocs/chat_list/chat_list_bloc.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AppBloc>().state.authUser.id;

    return BlocProvider(
      create: (context) => ChatListBloc(
        streamChatsUseCase: StreamChatsUseCase(
          chatRepository: context.read<ChatRepository>(),
        ),
      )..add(ChatListGetChats(userId: userId)),
      child: const ChatListView(),
    );
  }
}

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List'),
        centerTitle: true,
      ),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          if (state.status == ChatListStatus.loading ||
              state.status == ChatListStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ChatListStatus.loaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.chats.length,
                itemBuilder: (context, index) {
                  final chat = state.chats[index];

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(chat.userIds[0]),
                    subtitle: Text(chat.lastMessage?.text ?? ''),
                    trailing: Text(
                      (chat.lastMessage?.createdAt ??
                              chat.createdAt ??
                              DateTime.now())
                          .toFormattedString(),
                    ),
                    onTap: () {
                      context.go(
                        context.namedLocation(
                          'chat',
                          pathParameters: {'chatId': chat.id},
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}
