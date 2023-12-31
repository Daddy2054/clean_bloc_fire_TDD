// import 'package:clean_bloc_firebase/src/features/common/data/data_sources/remote_data_source.dart';
// import 'package:clean_bloc_firebase/src/features/feed/data/models/post_model.dart';
// import 'package:clean_bloc_firebase/src/features/feed/data/repositories/post_repository_impl.dart';
// import 'package:clean_bloc_firebase/src/features/feed/domain/entities/post.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'post_repository_impl_test.mocks.dart';

// @GenerateMocks([
//   RemoteDataSource,
// ])
// void main() {
//   late MockRemoteDataSource mockRemoteDataSource;
//   late PostRepositoryImpl postRepository;

//   setUp(() {
//     mockRemoteDataSource = MockRemoteDataSource();
//     postRepository = PostRepositoryImpl(
//       remoteDataSource: mockRemoteDataSource,
//     );
//   });

//   const tPostId = '1';
//   const tPostModel = PostModel(
//     id: 'id',
//     caption: 'caption',
//     imageUrl: 'imageUrl',
//   );

//   group('getPost', () {
//     test('return Post.empty when remoteDataSource.getPost return null',
//         () async {
//       const postId = 'invalid';

//       // Arrange
//       when(mockRemoteDataSource.getDocument(
//         collectionPath: 'posts',
//         documentId: postId,
//         objectMapper: anyNamed('objectMapper'),
//       )).thenAnswer((_) async => null);

//       // Act
//       final result = await postRepository.getPost(postId: postId);

//       // Assert
//       // expect(result, Post.empty);
//       expect(result, const Right(Post.empty));

//       verify(mockRemoteDataSource.getDocument(
//         collectionPath: 'posts',
//         documentId: postId,
//         objectMapper: PostModel.fromCloudFirestore,
//       )).called(1);
//     });

//     test(
//         'return a Post entity when remoteDataSource.getPost return a PostModel',
//         () async {
//       // Arrange
//       when(mockRemoteDataSource.getDocument(
//         collectionPath: 'posts',
//         documentId: anyNamed('documentId'),
//         objectMapper: anyNamed('objectMapper'),
//       )).thenAnswer((_) async => tPostModel);

//       // Act
//       final result = await postRepository.getPost(postId: tPostId);

//       // Assert
//       expect(result, equals(Right(tPostModel.toEntity())));
//       // expect(result, tPostModel.toEntity());

//       verify(mockRemoteDataSource.getDocument(
//         collectionPath: 'posts',
//         documentId: tPostId,
//         objectMapper: PostModel.fromCloudFirestore,
//       )).called(1);
//     });
//   });
//   group('getPosts', () {
//     test(
//         'return an empty list when remoteDataSource.getPosts does not return any post model',
//         () async {
//       // Arrange
//       when(mockRemoteDataSource.getCollection(
//         collectionPath: 'posts',
//         objectMapper: anyNamed('objectMapper'),
//       )).thenAnswer((_) async => <PostModel>[]);

//       // Act
//       final result = await postRepository.getPosts();

//       // Assert
//       // expect(result, []);
//       expect(result.isRight(), true); // Check if it's Right
//       expect(result.getOrElse((_) => []), []);

//       verify(mockRemoteDataSource.getCollection(
//         collectionPath: 'posts',
//         objectMapper: PostModel.fromCloudFirestore,
//       )).called(1);
//     });

//     test(
//         'return an list of post entities when remoteDataSource.getPosts return one or more post models',
//         () async {
//       // Arrange
//       when(mockRemoteDataSource.getCollection(
//         collectionPath: 'posts',
//         objectMapper: anyNamed('objectMapper'),
//       )).thenAnswer((_) async => <PostModel>[tPostModel]);

//       // Act
//       final result = await postRepository.getPosts();

//       // Assert
//       // expect(result, [tPostModel.toEntity()]);
//       expect(result.isRight(), true); // Check if it's Right
//       expect(result.getOrElse((_) => []), [tPostModel.toEntity()]);

//       verify(mockRemoteDataSource.getCollection(
//         collectionPath: 'posts',
//         objectMapper: PostModel.fromCloudFirestore,
//       )).called(1);
//     });
//   });
// }
