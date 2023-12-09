// Mocks generated by Mockito 5.4.3 from annotations
// in clean_bloc_firebase/test/src/features/feed/presentation/screens/feed_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:bloc/bloc.dart' as _i4;
import 'package:clean_bloc_firebase/src/features/feed/domain/entities/post.dart'
    as _i7;
import 'package:clean_bloc_firebase/src/features/feed/domain/repositories/post_repository.dart'
    as _i5;
import 'package:clean_bloc_firebase/src/features/feed/presentation/blocs/feed/feed_bloc.dart'
    as _i2;
import 'package:fpdart/fpdart.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;

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

class _FakeFeedState_0 extends _i1.SmartFake implements _i2.FeedState {
  _FakeFeedState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FeedBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockFeedBloc extends _i1.Mock implements _i2.FeedBloc {
  MockFeedBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FeedState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeFeedState_0(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.FeedState);

  @override
  _i3.Stream<_i2.FeedState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<_i2.FeedState>.empty(),
      ) as _i3.Stream<_i2.FeedState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i2.FeedEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i2.FeedEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i2.FeedState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i2.FeedEvent>(
    _i4.EventHandler<E, _i2.FeedState>? handler, {
    _i4.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(_i4.Transition<_i2.FeedEvent, _i2.FeedState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  void onChange(_i4.Change<_i2.FeedState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [PostRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPostRepository extends _i1.Mock implements _i5.PostRepository {
  MockPostRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i6.Either<Exception, _i7.Post>> getPost(
          {required String? postId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPost,
          [],
          {#postId: postId},
        ),
        returnValue: _i3.Future<_i6.Either<Exception, _i7.Post>>.value(
            _i8.dummyValue<_i6.Either<Exception, _i7.Post>>(
          this,
          Invocation.method(
            #getPost,
            [],
            {#postId: postId},
          ),
        )),
      ) as _i3.Future<_i6.Either<Exception, _i7.Post>>);

  @override
  _i3.Future<_i6.Either<Exception, List<_i7.Post>>> getPosts() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPosts,
          [],
        ),
        returnValue: _i3.Future<_i6.Either<Exception, List<_i7.Post>>>.value(
            _i8.dummyValue<_i6.Either<Exception, List<_i7.Post>>>(
          this,
          Invocation.method(
            #getPosts,
            [],
          ),
        )),
      ) as _i3.Future<_i6.Either<Exception, List<_i7.Post>>>);
}
