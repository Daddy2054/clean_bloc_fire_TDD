import '../../../feed/domain/entities/post.dart';
import '../repositories/post_repository.dart';

class GetPostUseCase {
  final PostRepository postRepository;

  GetPostUseCase({required this.postRepository});

  Future<Post> call(GetPostParams params) async {
    try {
      return await postRepository.getPost(postId: params.postId);
    } catch (error) {
      throw Exception(error);
    }
  }
}

class GetPostParams {
  final String postId;

  GetPostParams({required this.postId});
}
