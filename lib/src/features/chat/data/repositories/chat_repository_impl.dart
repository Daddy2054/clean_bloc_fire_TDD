import 'dart:async';

import 'package:fpdart/fpdart.dart';

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
      return const Right(null);
    } catch (error) {
      return Left(Exception(error.toString()));
    }
  }

  // @override
  // Future<void> addMessageToChat({
  //   required String chatId,
  //   required Message message,
  // }) async {
  //   await remoteDataSource.updateDocumentList(
  //     collectionPath: 'chats',
  //     documentId: chatId,
  //     field: 'messages',
  //     value: MessageModel.fromEntity(message).toJson(),
  //   );
  // }
  @override
  Stream<Either<Exception, Chat>> streamChat({required String chatId}) {
    return remoteDataSource
        .streamDocument(
      collectionPath: 'chats',
      documentId: chatId,
      objectMapper: ChatModel.fromCloudFirestore,
    )
        .asyncMap((chatModel) async {
      try {
        if (chatModel == null) {
          return const Right(Chat.empty);
        } else {
          return Right(chatModel.toEntity());
        }
      } catch (error) {
        return Left(Exception(error.toString()));
      }
    });
  }

  // @override
  // Stream<Chat> streamChat({required String chatId}) {
  //   final chatModelStream = remoteDataSource.streamDocument(
  //     collectionPath: 'chats',
  //     documentId: chatId,
  //     objectMapper: ChatModel.fromCloudFirestore,
  //   );

  //   return chatModelStream.map((chatModel) {
  //     if (chatModel == null) {
  //       return Chat.empty;
  //     }
  //     return chatModel.toEntity();
  //   });
  // }

  @override
  Stream<Either<Exception, List<Chat>>> streamChats({required String userId}) {
    return remoteDataSource
        .streamCollection(
      collectionPath: 'chats',
      field: 'userIds',
      arrayContainsValue: userId,
      objectMapper: ChatModel.fromCloudFirestore,
    )
        .map((chatModels) {
      try {
        return Right(chatModels.map((chatModel) {
          return chatModel.toEntity();
        }).toList());
      } catch (error) {
        return Left(Exception(error.toString()));
      }
    });
  }

  // @override
  // Stream<List<Chat>> streamChats({required String userId}) {
  //   final chatModelsStream = remoteDataSource.streamCollection(
  //     collectionPath: 'chats',
  //     field: 'userIds',
  //     arrayContainsValue: userId,
  //     objectMapper: ChatModel.fromCloudFirestore,
  //   );

  //   return chatModelsStream.map((chatModels) {
  //     return chatModels.map((chatModel) {
  //       return chatModel.toEntity();
  //     }).toList();
  //   });
  // }
}
