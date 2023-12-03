// Mocks generated by Mockito 5.4.3 from annotations
// in clean_bloc_firebase/test/src/features/feed/presentation/blocs/feed/feed_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:clean_bloc_firebase/src/features/feed/domain/entities/post.dart'
    as _i5;
import 'package:clean_bloc_firebase/src/features/feed/domain/repositories/post_repository.dart'
    as _i2;
import 'package:clean_bloc_firebase/src/features/feed/domain/use_cases/get_posts_use_case.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePostRepository_0 extends _i1.SmartFake
    implements _i2.PostRepository {
  _FakePostRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetPostsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPostsUseCase extends _i1.Mock implements _i3.GetPostsUseCase {
  MockGetPostsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PostRepository get postRepository => (super.noSuchMethod(
        Invocation.getter(#postRepository),
        returnValue: _FakePostRepository_0(
          this,
          Invocation.getter(#postRepository),
        ),
      ) as _i2.PostRepository);

  @override
  _i4.Future<List<_i5.Post>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i4.Future<List<_i5.Post>>.value(<_i5.Post>[]),
      ) as _i4.Future<List<_i5.Post>>);
}
