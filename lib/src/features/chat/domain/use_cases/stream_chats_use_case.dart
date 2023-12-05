import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

class StreamChatsUseCase {
  final ChatRepository chatRepository;

  StreamChatsUseCase({required this.chatRepository});

  Stream<List<Chat>> call(StreamChatsParams params) {
    try {
      return chatRepository.streamChats(userId: params.userId);
    } catch (error) {
      throw Exception(error);
    }
  }
}

class StreamChatsParams {
  final String userId;

  StreamChatsParams({required this.userId});
}
