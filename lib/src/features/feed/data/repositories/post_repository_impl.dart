import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../common/data/data_sources/local_data_source.dart';
import '../../../common/data/data_sources/remote_data_source.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource<PostModel> localDataSource;
  StreamSubscription? _postsSubscription;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  }) {
    _syncLocalWithRemoteDataSource();
  }

  // This method initializes the syncing mechanism
  void _syncLocalWithRemoteDataSource() {
    _postsSubscription = remoteDataSource
        .streamCollection(
      collectionPath: 'posts',
      objectMapper: PostModel.fromCloudFirestore,
    )
        .listen((newPostModels) {
      // Save the new data to Hive
      print('Add new posts to local data source');
      localDataSource.addAll(newPostModels, (postModel) => postModel.id);
    });
  }

  @override
  Future<Either<Exception, Post>> getPost({required String postId}) async {
    try {
      // Try to get data from the local data source first
      PostModel? postModel = await localDataSource.getOne(postId);

      // If there's no data in local, fetch from remote and save to local
      if (postModel == null) {
        print('Fetching from remote');
        postModel = await remoteDataSource.getDocument(
          collectionPath: 'posts',
          documentId: postId,
          objectMapper: PostModel.fromCloudFirestore,
        );
        if (postModel != null) {
          await localDataSource.addOne(postModel, (postModel) => postModel.id);
        } else {
          return const Right(Post.empty);
        }
      }

      print('Fetching from local');
      return Right(postModel.toEntity());
    } catch (error) {
      return Left(Exception(error.toString()));
    }
  }

  @override
  Future<Either<Exception, List<Post>>> getPosts() async {
    try {
      // Get data from the local data source
      List<PostModel> postModels = await localDataSource.getAll();

      // If there's no data in local, fetch from remote and save to local
      if (postModels.isEmpty) {
        print('Fetching from remote');
        postModels = await remoteDataSource.getCollection(
          collectionPath: 'posts',
          objectMapper: PostModel.fromCloudFirestore,
        );
        if (postModels.isNotEmpty) {
          await localDataSource.addAll(postModels, (postModel) => postModel.id);
        } else {
          return const Right(<Post>[]);
        }
      }

      print('Fetching from local');
      return Right(
        postModels.map((postModel) => postModel.toEntity()).toList(),
      );
    } catch (error) {
      return Left(Exception(error.toString()));
    }
  }

  // Call this method to clean up resources when they're no longer needed
  void dispose() {
    _postsSubscription?.cancel();
  }
}

// class PostRepositoryImpl implements PostRepository {
//   final RemoteDataSource remoteDataSource;

//   const PostRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<Exception, Post>> getPost({required String postId}) async {
//     try {
//       final postModel = await remoteDataSource.getDocument(
//         collectionPath: 'posts',
//         documentId: postId,
//         objectMapper: PostModel.fromCloudFirestore,
//       );
//       final postEntity = postModel == null ? Post.empty : postModel.toEntity();
//       return Right(postEntity);
//     } catch (error) {
//       return Left(Exception(error.toString()));
//     }
//   }

// //   @override
// //   Future<Post> getPost({required String postId}) async {
// //     final postModel = await remoteDataSource.getDocument(
// //       collectionPath: 'posts',
// //       documentId: postId,
// //       objectMapper: PostModel.fromCloudFirestore,
// //       // objectMapper: PostModel.fromFakeDataSource,
// //     );
// //     return postModel == null ? Post.empty : postModel.toEntity();
// //   }

//   @override
//   Future<Either<Exception, List<Post>>> getPosts() async {
//     try {
//       final postModels = await remoteDataSource.getCollection(
//         collectionPath: 'posts',
//         objectMapper: PostModel.fromCloudFirestore,
//       );

//       final postEntities =
//           postModels.map((postModel) => postModel.toEntity()).toList();

//       return Right(postEntities);
//     } catch (error) {
//       return Left(Exception(error.toString()));
//     }
//   }

// //   @override
// //   Future<List<Post>> getPosts() async {
// //     final postModels = await remoteDataSource.getCollection(
// //       collectionPath: 'posts',
// //       objectMapper: PostModel.fromCloudFirestore,
// //       // objectMapper: PostModel.fromFakeDataSource,
// //     );
// //     return postModels.map((postModel) => postModel.toEntity()).toList();
// //   }
// }
