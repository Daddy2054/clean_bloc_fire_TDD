import 'package:clean_bloc_firebase/src/features/feed/domain/entities/post.dart';
import 'package:clean_bloc_firebase/src/features/feed/domain/repositories/post_repository.dart';
import 'package:clean_bloc_firebase/src/features/feed/domain/use_cases/get_posts_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_posts_use_case_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late MockPostRepository mockPostRepository;
  late GetPostsUseCase getPostsUseCase;

  setUp(() {
    mockPostRepository = MockPostRepository();
    getPostsUseCase = GetPostsUseCase(postRepository: mockPostRepository);
  });

  const tPosts = [
    Post(
      id: '1',
      caption: 'title',
      imageUrl: 'https//image_url.com',
    )
  ];

  test('should call getPosts method on the PostRepository', () async {
    // when(mockPostRepository.getPosts()).thenAnswer((_) async => tPosts);
    when(mockPostRepository.getPosts())
        .thenAnswer((_) async => const Right(tPosts));

    await getPostsUseCase.call();

    verify(mockPostRepository.getPosts());
  });

  test(
      'should throw an exception when the getPosts method on the PostRepository throws an exception',
      () async {
    // when(mockPostRepository.getPosts()).thenThrow(Exception());
    when(mockPostRepository.getPosts())
        .thenAnswer((_) async => Left(Exception()));

    final result = await getPostsUseCase.call();

    expect(result, isA<Left>());

    result.fold(
      (failure) => expect(failure, isA<Exception>()),
      (_) => fail("Should return an Exception"),
    );

    // expect(() async => await getPostsUseCase.call(), throwsA(isA<Exception>()));
  });

  test(
      'should return the correct list of Posts when the getPosts method on the PostRepository returns successfully',
      () async {
    // when(mockPostRepository.getPosts()).thenAnswer((_) async => tPosts);

    when(mockPostRepository.getPosts())
        .thenAnswer((_) async => const Right(tPosts));

    final result = await getPostsUseCase.call();

    expect(result, equals(const Right(tPosts)));

    // expect(result, equals(tPosts));
  });
}
