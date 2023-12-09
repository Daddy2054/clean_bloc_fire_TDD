import 'package:fpdart/fpdart.dart';

import '../../../feed/domain/entities/post.dart';

abstract class PostRepository {
  Future<Either<Exception, Post>> getPost({required String postId});
  Future<Either<Exception, List<Post>>> getPosts();
//   Future<Post> getPost({required String postId});
//   Future<List<Post>> getPosts();
}
