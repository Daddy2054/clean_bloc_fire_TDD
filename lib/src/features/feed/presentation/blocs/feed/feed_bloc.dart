import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post.dart';
import '../../../domain/use_cases/get_posts_use_case.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetPostsUseCase _getPostsUseCase;

  FeedBloc({
    required GetPostsUseCase getPostsUseCase,
  })  : _getPostsUseCase = getPostsUseCase,
        super(const FeedState()) {
    on<FeedGetPosts>(_onGetPosts);
  }

  void _onGetPosts(
    FeedGetPosts event,
    Emitter<FeedState> emit,
  ) async {
    final result = await _getPostsUseCase.call();
    result.fold(
      (exception) {
        // Handle the failure case
        emit(state.copyWith(status: FeedStatus.error));
      },
      (posts) {
        // Handle the success case
        emit(
          state.copyWith(
            status: FeedStatus.loaded,
            posts: posts,
          ),
        );
      },
    );
  }

  // void _onGetPosts(
  //   FeedGetPosts event,
  //   Emitter<FeedState> emit,
  // ) async {
  //   try {
  //     List<Post> posts = await _getPostsUseCase.call();
  //     emit(
  //       state.copyWith(
  //         status: FeedStatus.loaded,
  //         posts: posts,
  //       ),
  //     );
  //   } catch (error) {
  //     emit(state.copyWith(status: FeedStatus.error));
  //   }
  // }
}
