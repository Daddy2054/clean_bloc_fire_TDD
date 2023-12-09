import 'package:clean_bloc_firebase/src/features/feed/domain/entities/post.dart';
import 'package:clean_bloc_firebase/src/features/feed/domain/repositories/post_repository.dart';
import 'package:clean_bloc_firebase/src/features/feed/domain/use_cases/get_post_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_post_use_case_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late MockPostRepository mockPostRepository;
  late GetPostUseCase getPostUseCase;

  setUp(() {
    mockPostRepository = MockPostRepository();
    getPostUseCase = GetPostUseCase(postRepository: mockPostRepository);
  });

  const tPostId = '1';
  const tPost = Post(
    id: '1',
    caption: 'title',
    imageUrl: 'https//image_url.com',
  );

  final tGetPostParams = GetPostParams(postId: tPostId);

  test(
      'should call getPost method on the PostRepository with correct parameters',
      () async {
    // when(mockPostRepository.getPost(postId: anyNamed('postId')))
    //     .thenAnswer((_) async => tPost);
    when(mockPostRepository.getPost(postId: anyNamed('postId')))
        .thenAnswer((_) async => const Right(tPost));

    await getPostUseCase.call(tGetPostParams);

    verify(mockPostRepository.getPost(postId: tGetPostParams.postId));
  });

  test(
      'should throw an exception when the getPost method on the PostRepository throws an exception',
      () async {
    // when(mockPostRepository.getPost(postId: anyNamed('postId')))
    //     .thenThrow(Exception());
    when(mockPostRepository.getPost(postId: anyNamed('postId')))
        .thenAnswer((_) async => Left(Exception()));

    final result = await getPostUseCase.call(tGetPostParams);

    expect(result, isA<Left>());

    result.fold(
      (failure) => expect(failure, isA<Exception>()),
      (_) => fail("Should return an Exception"),
    );

    // expect(() async => await getPostUseCase.call(tGetPostParams),
    //     throwsA(isA<Exception>()));
  });

  test(
      'should return the correct Post when the getPost method on the PostRepository returns successfully',
      () async {
    // when(mockPostRepository.getPost(postId: anyNamed('postId')))
    //     .thenAnswer((_) async => tPost);
    when(mockPostRepository.getPost(postId: anyNamed('postId')))
        .thenAnswer((_) async => const Right(tPost));

    final result = await getPostUseCase.call(tGetPostParams);

    expect(result, equals(const Right(tPost)));

    // expect(result, equals(tPost));
  });
}
