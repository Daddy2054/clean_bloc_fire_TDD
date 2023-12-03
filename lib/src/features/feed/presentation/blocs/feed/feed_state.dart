part of 'feed_bloc.dart';

enum FeedStatus { initial, loading, loaded, error }

class FeedState extends Equatable {
  final List<Post> posts;
  final FeedStatus status;

  const FeedState({
    this.posts = const <Post>[],
    this.status = FeedStatus.initial,
  });

  FeedState copyWith({
    List<Post>? posts,
    FeedStatus? status,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [posts, status];
}
