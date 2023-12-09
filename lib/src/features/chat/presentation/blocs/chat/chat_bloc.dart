import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/use_cases/send_message_use_case.dart';
import '../../../domain/use_cases/stream_chat_use_case.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final StreamChatUseCase _streamChatUseCase;
  final SendMessageUseCase _sendMessageUseCase;

  ChatBloc({
    required StreamChatUseCase streamChatUseCase,
    required SendMessageUseCase sendMessageUseCase,
  })  : _streamChatUseCase = streamChatUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        super(const ChatState()) {
    on<ChatGetChat>(_onGetChat);
    on<ChatWriteMessage>(_onWriteMessage);
    on<ChatSendMessage>(_onSendMessage);
  }

  void _onGetChat(
    ChatGetChat event,
    Emitter<ChatState> emit,
  ) async {
    await emit.forEach(
      _streamChatUseCase(StreamChatParams(chatId: event.chatId)),
      onData: (eitherChat) {
        return eitherChat.fold(
          (exception) {
            return state.copyWith(status: ChatStatus.error);
          },
          (chat) {
            return state.copyWith(
              status: ChatStatus.loaded,
              chat: chat,
            );
          },
        );
      },
    );
  }
  // void _onGetChat(
  //   ChatGetChat event,
  //   Emitter<ChatState> emit,
  // ) async {
  //   try {
  //     await emit.forEach(
  //       _streamChatUseCase(StreamChatParams(chatId: event.chatId)),
  //       onData: (chat) {
  //         return state.copyWith(
  //           status: ChatStatus.loaded,
  //           chat: chat,
  //         );
  //       },
  //     );
  //   } catch (error) {
  //     emit(state.copyWith(status: ChatStatus.error));
  //   }
  // }

  void _onWriteMessage(
    ChatWriteMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ChatStatus.loaded, text: event.text));
    } catch (error) {
      emit(state.copyWith(status: ChatStatus.error));
    }
  }

  void _onSendMessage(
    ChatSendMessage event,
    Emitter<ChatState> emit,
  ) async {
    final text = state.text;
    emit(state.copyWith(text: ''));
    try {
      final receiverId =
          state.chat.userIds.firstWhere((userId) => userId != event.senderId);

      await _sendMessageUseCase(
        SendMessageParams(
          chatId: state.chat.id,
          senderId: event.senderId,
          receiverId: receiverId,
          text: text ?? '',
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChatStatus.error));
    }
  }
}
