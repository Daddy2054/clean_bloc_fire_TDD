import '../entities/post.dart';

abstract class PostRepository {
  Future<Post> getPost({required String postId});
  Future<List<Post>> getPosts();
}
