import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../common/data/data_sources/local_data_source.dart';
import '../../../common/data/data_sources/remote_data_source.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource<ChatModel> localDataSource;
  StreamSubscription? _chatsSubscription;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  void _syncLocalWithRemoteDataSource(String userId) {
    _chatsSubscription = remoteDataSource
        .streamCollection(
      collectionPath: 'chats',
      field: 'userIds',
      arrayContainsValue: userId,
      objectMapper: ChatModel.fromCloudFirestore,
    )
        .listen(
      (newChatModels) {
        try {
          print(
            'Adding the new message fetched from the server to the local data source',
          );
          localDataSource.addAll(newChatModels, (chatModel) => chatModel.id);
        } catch (e) {
          // Optionally, log the error or handle it in another way
        }
      },
      onError: (error) {
        // Handle or log the stream error here
        // Optionally, you can propagate the error further if needed
      },
    );
  }

  @override
  Stream<Either<Exception, List<Chat>>> streamChats({required String userId}) {
    if (_chatsSubscription == null) {
      _syncLocalWithRemoteDataSource(userId);
    }

    return localDataSource.streamAll().map((chatModels) {
      try {
        return Right(
            chatModels.map((chatModel) => chatModel.toEntity()).toList());
      } catch (error) {
        return Left(Exception(error.toString()));
      }
    });
  }

  @override
  Stream<Either<Exception, Chat>> streamChat({required String chatId}) {
    return localDataSource.streamOne(chatId).map((chatModel) {
      try {
        if (chatModel == null) {
          return const Right(Chat.empty);
        }
        return Right(chatModel.toEntity());
      } catch (error) {
        return Left(Exception(error.toString()));
      }
    });
  }

  @override
  Future<Either<Exception, void>> addMessageToChat({
    required String chatId,
    required Message message,
  }) async {
    try {
      await remoteDataSource.updateDocumentList(
        collectionPath: 'chats',
        documentId: chatId,
        field: 'messages',
        value: MessageModel.fromEntity(message).toJson(),
      );

      ChatModel? chatModel = await localDataSource.getOne(chatId);
      if (chatModel != null) {
        chatModel.messages.add(MessageModel.fromEntity(message));
        await localDataSource.addOne(chatModel, (chatModel) => chatModel.id);
      }

      return const Right(null);
    } catch (error) {
      return Left(Exception(error.toString()));
    }
  }

  void dispose() {
    _chatsSubscription?.cancel();
  }
}

// class ChatRepositoryImpl implements ChatRepository {
//   final RemoteDataSource remoteDataSource;

//   const ChatRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<Exception, void>> addMessageToChat({
//     required String chatId,
//     required Message message,
//   }) async {
//     try {
//       await remoteDataSource.updateDocumentList(
//         collectionPath: 'chats',
//         documentId: chatId,
//         field: 'messages',
//         value: MessageModel.fromEntity(message).toJson(),
//       );
//       return const Right(null);
//     } catch (error) {
//       return Left(Exception(error.toString()));
//     }
//   }

//   // @override
//   // Future<void> addMessageToChat({
//   //   required String chatId,
//   //   required Message message,
//   // }) async {
//   //   await remoteDataSource.updateDocumentList(
//   //     collectionPath: 'chats',
//   //     documentId: chatId,
//   //     field: 'messages',
//   //     value: MessageModel.fromEntity(message).toJson(),
//   //   );
//   // }
//   @override
//   Stream<Either<Exception, Chat>> streamChat({required String chatId}) {
//     return remoteDataSource
//         .streamDocument(
//       collectionPath: 'chats',
//       documentId: chatId,
//       objectMapper: ChatModel.fromCloudFirestore,
//     )
//         .asyncMap((chatModel) async {
//       try {
//         if (chatModel == null) {
//           return const Right(Chat.empty);
//         } else {
//           return Right(chatModel.toEntity());
//         }
//       } catch (error) {
//         return Left(Exception(error.toString()));
//       }
//     });
//   }

//   // @override
//   // Stream<Chat> streamChat({required String chatId}) {
//   //   final chatModelStream = remoteDataSource.streamDocument(
//   //     collectionPath: 'chats',
//   //     documentId: chatId,
//   //     objectMapper: ChatModel.fromCloudFirestore,
//   //   );

//   //   return chatModelStream.map((chatModel) {
//   //     if (chatModel == null) {
//   //       return Chat.empty;
//   //     }
//   //     return chatModel.toEntity();
//   //   });
//   // }

//   @override
//   Stream<Either<Exception, List<Chat>>> streamChats({required String userId}) {
//     return remoteDataSource
//         .streamCollection(
//       collectionPath: 'chats',
//       field: 'userIds',
//       arrayContainsValue: userId,
//       objectMapper: ChatModel.fromCloudFirestore,
//     )
//         .map((chatModels) {
//       try {
//         return Right(chatModels.map((chatModel) {
//           return chatModel.toEntity();
//         }).toList());
//       } catch (error) {
//         return Left(Exception(error.toString()));
//       }
//     });
//   }

//   // @override
//   // Stream<List<Chat>> streamChats({required String userId}) {
//   //   final chatModelsStream = remoteDataSource.streamCollection(
//   //     collectionPath: 'chats',
//   //     field: 'userIds',
//   //     arrayContainsValue: userId,
//   //     objectMapper: ChatModel.fromCloudFirestore,
//   //   );

//   //   return chatModelsStream.map((chatModels) {
//   //     return chatModels.map((chatModel) {
//   //       return chatModel.toEntity();
//   //     }).toList();
//   //   });
//   // }
// }



