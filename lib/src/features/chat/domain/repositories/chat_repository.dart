import '../entities/chat.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  // Future<void> createChat({required List<String> userIds});
  Stream<List<Chat>> streamChats({required String userId});
  Stream<Chat> streamChat({required String chatId});
  Future<void> addMessageToChat({
    required String chatId,
    required Message message,
  });
}
