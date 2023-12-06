import 'package:clean_bloc_firebase/src/features/chat/data/models/chat_model.dart';
import 'package:clean_bloc_firebase/src/features/chat/data/models/message_model.dart';
import 'package:clean_bloc_firebase/src/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart';
import 'package:clean_bloc_firebase/src/features/common/data/data_sources/remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_repository_impl_test.mocks.dart';

@GenerateMocks([
  RemoteDataSource,
])
void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late ChatRepositoryImpl chatRepository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    chatRepository = ChatRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  final createdAt = DateTime.now();
  const tUserIds = ['user_1', 'user_2'];
  const tChatId = 'chat_id_1';

  final tChatModel = ChatModel(
    id: tChatId,
    userIds: tUserIds,
    messages: const [],
    lastMessage: null,
    createdAt: createdAt,
  );

  final tMessage = Message(
    id: 'message_id_1',
    senderId: tUserIds[0],
    receiverId: tUserIds[1],
    text: 'text',
    createdAt: createdAt,
  );

  group('streamChat', () {
    test(
        'return an empty instance of the chat entity when remoteDataSource.streamChat'
        'does not return any chat model', () async {
      // Arrange
      when(mockRemoteDataSource.streamDocument(
        collectionPath: 'chats',
        documentId: tChatId,
        objectMapper: anyNamed('objectMapper'),
      )).thenAnswer((_) => Stream<ChatModel?>.value(null));

      // Act
      final result = await chatRepository.streamChat(chatId: tChatId).first;

      // Assert
      expect(result, Chat.empty);

      verify(
        mockRemoteDataSource.streamDocument(
            collectionPath: 'chats',
            documentId: tChatId,
            objectMapper: ChatModel.fromCloudFirestore),
      ).called(1);
    });

    test(
        'return an instance of the chat entity when remoteDataSource.streamChat'
        'return a valid chat model', () async {
      // Arrange
      when(mockRemoteDataSource.streamDocument(
        collectionPath: 'chats',
        documentId: tChatId,
        objectMapper: anyNamed('objectMapper'),
      )).thenAnswer((_) => Stream<ChatModel?>.value(tChatModel));

      // Act
      final result = await chatRepository.streamChat(chatId: tChatId).first;

      // Assert
      expect(result, tChatModel.toEntity());

      verify(
        mockRemoteDataSource.streamDocument(
            collectionPath: 'chats',
            documentId: tChatId,
            objectMapper: ChatModel.fromCloudFirestore),
      ).called(1);
    });
  });
  group('streamChats', () {
    test(
        'return an empty list when remoteDataSource.streamChats'
        'does not return any chat model', () async {
      // Arrange
      when(mockRemoteDataSource.streamCollection(
        collectionPath: 'chats',
        field: 'userIds',
        arrayContainsValue: anyNamed('arrayContainsValue'),
        objectMapper: anyNamed('objectMapper'),
      )).thenAnswer((_) => Stream<List<ChatModel>>.value([]));

      // Act
      final result =
          await chatRepository.streamChats(userId: tUserIds[0]).first;

      // Assert
      expect(result, []);

      verify(
        mockRemoteDataSource.streamCollection(
            collectionPath: 'chats',
            field: 'userIds',
            arrayContainsValue: tUserIds[0],
            objectMapper: ChatModel.fromCloudFirestore),
      ).called(1);
    });

    test(
        'return a valid list of chat entities when remoteDataSource.streamChats'
        'return one or more chat models', () async {
      // Arrange
      when(mockRemoteDataSource.streamCollection(
        collectionPath: 'chats',
        field: 'userIds',
        arrayContainsValue: anyNamed('arrayContainsValue'),
        objectMapper: anyNamed('objectMapper'),
      )).thenAnswer((_) => Stream<List<ChatModel>>.value(
            [tChatModel, tChatModel],
          ));

      // Act
      final result =
          await chatRepository.streamChats(userId: tUserIds[0]).first;

      // Assert
      expect(result, [tChatModel.toEntity(), tChatModel.toEntity()]);

      verify(
        mockRemoteDataSource.streamCollection(
          collectionPath: 'chats',
          field: 'userIds',
          arrayContainsValue: tUserIds[0],
          objectMapper: ChatModel.fromCloudFirestore,
        ),
      ).called(1);
    });
  });
  group('addMessageToChat', () {
    test(
        'should call updateDocumentList on the remoteDataSource with correct parameters',
        () async {
      // Arrange
      when(mockRemoteDataSource.updateDocumentList(
        collectionPath: 'chats',
        documentId: tChatId,
        field: 'messages',
        value: MessageModel.fromEntity(tMessage).toJson(),
      )).thenAnswer((_) async {});

      // Act
      await chatRepository.addMessageToChat(chatId: tChatId, message: tMessage);

      // Assert
      verify(mockRemoteDataSource.updateDocumentList(
        collectionPath: 'chats',
        documentId: tChatId,
        field: 'messages',
        value: MessageModel.fromEntity(tMessage).toJson(),
      )).called(1);
    });
  });
}
