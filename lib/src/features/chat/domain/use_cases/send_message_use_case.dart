import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository chatRepository;

  SendMessageUseCase({required this.chatRepository});

  Future<Either<Exception, void>> call(SendMessageParams params) async {
    try {
      final message = Message(
        id: const Uuid().v4(),
        receiverId: params.receiverId,
        senderId: params.senderId,
        text: params.text,
        createdAt: DateTime.now(),
      );

      await chatRepository.addMessageToChat(
        chatId: params.chatId,
        message: message,
      );
      return const Right(null);
    } catch (error) {
      return Left(Exception(error.toString()));
    }
  }
}

// class SendMessageUseCase {
//   final ChatRepository chatRepository;

//   SendMessageUseCase({required this.chatRepository});

//   Future<void> call(SendMessageParams params) async {
//     try {
//       final message = Message(
//         id: const Uuid().v4(),
//         receiverId: params.receiverId,
//         senderId: params.senderId,
//         text: params.text,
//         createdAt: DateTime.now(),
//       );

//       return await chatRepository.addMessageToChat(
//         chatId: params.chatId,
//         message: message,
//       );
//     } catch (error) {
//       throw Exception(error);
//     }
//   }
// }

class SendMessageParams {
  final String chatId;
  final String senderId;
  final String receiverId;
  final String text;

  SendMessageParams({
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.text,
  });
}
