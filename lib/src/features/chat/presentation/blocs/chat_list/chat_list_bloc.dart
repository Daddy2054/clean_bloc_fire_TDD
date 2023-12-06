import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/use_cases/stream_chats_use_case.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final StreamChatsUseCase _streamChatsUseCase;

  ChatListBloc({required StreamChatsUseCase streamChatsUseCase})
      : _streamChatsUseCase = streamChatsUseCase,
        super(const ChatListState()) {
    on<ChatListGetChats>(_onGetChats);
  }

  void _onGetChats(
    ChatListGetChats event,
    Emitter<ChatListState> emit,
  ) async {
    try {
      await emit.forEach(
        _streamChatsUseCase(StreamChatsParams(userId: event.userId)),
        onData: (chats) {
          chats.sort((a, b) {
            final aDate = a.lastMessage?.createdAt ?? a.createdAt;
            final bDate = b.lastMessage?.createdAt ?? b.createdAt;
            return bDate!.compareTo(aDate!);
          });

          return state.copyWith(
            status: ChatListStatus.loaded,
            chats: chats,
          );
        },
      );
    } catch (error) {
      emit(state.copyWith(status: ChatListStatus.error));
    }
  }
}
