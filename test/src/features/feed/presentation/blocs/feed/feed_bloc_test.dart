import 'package:bloc_test/bloc_test.dart';
import 'package:clean_bloc_firebase/src/features/feed/domain/entities/post.dart';
import 'package:clean_bloc_firebase/src/features/feed/domain/use_cases/get_posts_use_case.dart';
import 'package:clean_bloc_firebase/src/features/feed/presentation/blocs/feed/feed_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'feed_bloc_test.mocks.dart';

@GenerateMocks([GetPostsUseCase])
void main() {
  group('FeedBloc', () {
    const tPost = Post(
      id: 'id',
      caption: 'caption',
      imageUrl: 'imageUrl',
    );

    late MockGetPostsUseCase mockGetPostsUseCase;

    setUp(() {
      mockGetPostsUseCase = MockGetPostsUseCase();
    });

    FeedBloc buildBloc() {
      return FeedBloc(getPostsUseCase: mockGetPostsUseCase);
    }

    blocTest<FeedBloc, FeedState>(
      'emits [loaded] when posts are successfully fetched and the post list contains the posts',
      setUp: () {
        // when(mockGetPostsUseCase.call()).thenAnswer(
        //   (_) async => [tPost, tPost],
        // );
        when(mockGetPostsUseCase.call()).thenAnswer(
          (_) async => const Right([tPost, tPost]),
        );
      },
      build: buildBloc,
      act: (bloc) => bloc.add(FeedGetPosts()),
      expect: () => [
        const FeedState(
          posts: [tPost, tPost],
          status: FeedStatus.loaded,
        ),
      ],
    );

    blocTest<FeedBloc, FeedState>(
      'emits [error] when fetching posts throws an exception',
      setUp: () {
        // when(mockGetPostsUseCase.call()).thenThrow(Exception());
        when(mockGetPostsUseCase.call()).thenAnswer(
          (_) async => Left(Exception()),
        );
      },
      build: buildBloc,
      act: (bloc) => bloc.add(FeedGetPosts()),
      expect: () => [
        const FeedState(status: FeedStatus.error),
      ],
    );
  });
}
