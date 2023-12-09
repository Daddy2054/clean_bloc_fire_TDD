import 'package:fpdart/fpdart.dart';
import '../../../common/data/data_sources/remote_data_source.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final RemoteDataSource remoteDataSource;

  const PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, Post>> getPost({required String postId}) async {
    try {
      final postModel = await remoteDataSource.getDocument(
        collectionPath: 'posts',
        documentId: postId,
        objectMapper: PostModel.fromCloudFirestore,
      );
      final postEntity = postModel == null ? Post.empty : postModel.toEntity();
      return Right(postEntity);
    } catch (error) {
      return Left(Exception(error.toString()));
    }
  }

//   @override
//   Future<Post> getPost({required String postId}) async {
//     final postModel = await remoteDataSource.getDocument(
//       collectionPath: 'posts',
//       documentId: postId,
//       objectMapper: PostModel.fromCloudFirestore,
//       // objectMapper: PostModel.fromFakeDataSource,
//     );
//     return postModel == null ? Post.empty : postModel.toEntity();
//   }

  @override
  Future<Either<Exception, List<Post>>> getPosts() async {
    try {
      final postModels = await remoteDataSource.getCollection(
        collectionPath: 'posts',
        objectMapper: PostModel.fromCloudFirestore,
      );

      final postEntities =
          postModels.map((postModel) => postModel.toEntity()).toList();

      return Right(postEntities);
    } catch (error) {
      return Left(Exception(error.toString()));
    }
  }

//   @override
//   Future<List<Post>> getPosts() async {
//     final postModels = await remoteDataSource.getCollection(
//       collectionPath: 'posts',
//       objectMapper: PostModel.fromCloudFirestore,
//       // objectMapper: PostModel.fromFakeDataSource,
//     );
//     return postModels.map((postModel) => postModel.toEntity()).toList();
//   }
}
