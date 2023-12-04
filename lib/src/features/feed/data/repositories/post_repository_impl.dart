import '../../../common/data/data_sources/remote_data_source.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final RemoteDataSource remoteDataSource;

  const PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Post> getPost({required String postId}) async {
    final postModel = await remoteDataSource.getDocument(
      collectionPath: 'posts',
      documentId: postId,
      objectMapper: PostModel.fromCloudFirestore,
    );
    return postModel == null ? Post.empty : postModel.toEntity();
  }

  @override
  Future<List<Post>> getPosts() async {
    final postModels = await remoteDataSource.getCollection(
      collectionPath: 'posts',
      objectMapper: PostModel.fromCloudFirestore,
    );

    return postModels.map((postModel) => postModel.toEntity()).toList();
  }
}


// You can make your implementation more flexible by passing the object mapper as a 
// dependency to the repository. This way, you can easily switch between different 
// data sources with different object mappers without having to change the implementation 
// of the repository itself.
