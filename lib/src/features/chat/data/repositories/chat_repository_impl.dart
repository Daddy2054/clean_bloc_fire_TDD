import '../../../common/data/data_sources/remote_data_source.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final RemoteDataSource remoteDataSource;

  const ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addMessageToChat({
    required String chatId,
    required Message message,
  }) async {
    await remoteDataSource.updateDocumentList(
      collectionPath: 'chats',
      documentId: chatId,
      field: 'messages',
      value: MessageModel.fromEntity(message).toJson(),
    );
  }

  @override
  Stream<Chat> streamChat({required String chatId}) {
    final chatModelStream = remoteDataSource.streamDocument(
      collectionPath: 'chats',
      documentId: chatId,
      objectMapper: ChatModel.fromCloudFirestore,
    );

    return chatModelStream.map((chatModel) {
      if (chatModel == null) {
        return Chat.empty;
      }
      return chatModel.toEntity();
    });
  }

  @override
  Stream<List<Chat>> streamChats({required String userId}) {
    final chatModelsStream = remoteDataSource.streamCollection(
      collectionPath: 'chats',
      field: 'userIds',
      arrayContainsValue: userId,
      objectMapper: ChatModel.fromCloudFirestore,
    );

    return chatModelsStream.map((chatModels) {
      return chatModels.map((chatModel) {
        return chatModel.toEntity();
      }).toList();
    });
  }

  // @override
  // Future<void> createChat({
  //   required List<String> userIds,
  // }) async {
  //   await remoteDataSource.addDocument(
  //     collectionPath: 'chats',
  //     data: {'userIds': userIds},
  //   );
  // }
}
