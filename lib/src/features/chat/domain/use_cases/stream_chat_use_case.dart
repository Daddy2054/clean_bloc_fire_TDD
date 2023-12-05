import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

class StreamChatUseCase {
  final ChatRepository chatRepository;

  StreamChatUseCase({required this.chatRepository});

  Stream<Chat> call(StreamChatParams params) {
    try {
      return chatRepository.streamChat(chatId: params.chatId);
    } catch (error) {
      throw Exception(error);
    }
  }
}

class StreamChatParams {
  final String chatId;

  StreamChatParams({required this.chatId});
}
