import 'package:fpdart/fpdart.dart';

import '../../../feed/domain/entities/post.dart';
import '../repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository postRepository;

  GetPostsUseCase({required this.postRepository});

  Future<Either<Exception, List<Post>>> call() async {
    return await postRepository.getPosts();
  }
}

// class GetPostsUseCase {
//   final PostRepository postRepository;

//   GetPostsUseCase({required this.postRepository});

//   Future<List<Post>> call() async {
//     try {
//       return await postRepository.getPosts();
//     } catch (error) {
//       throw Exception(error);
//     }
//   }
// }