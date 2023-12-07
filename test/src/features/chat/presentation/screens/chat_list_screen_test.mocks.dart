// Mocks generated by Mockito 5.4.3 from annotations
// in clean_bloc_firebase/test/src/features/chat/presentation/screens/chat_list_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart'
    as _i7;
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart'
    as _i8;
import 'package:clean_bloc_firebase/src/features/chat/domain/repositories/chat_repository.dart'
    as _i6;
import 'package:clean_bloc_firebase/src/features/chat/presentation/blocs/chat_list/chat_list_bloc.dart'
    as _i2;
import 'package:clean_bloc_firebase/src/shared/app/blocs/app/app_bloc.dart'
    as _i3;
import 'package:flutter_bloc/flutter_bloc.dart' as _i5;
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

class _FakeChatListState_0 extends _i1.SmartFake implements _i2.ChatListState {
  _FakeChatListState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAppState_1 extends _i1.SmartFake implements _i3.AppState {
  _FakeAppState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ChatListBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockChatListBloc extends _i1.Mock implements _i2.ChatListBloc {
  MockChatListBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ChatListState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeChatListState_0(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.ChatListState);

  @override
  _i4.Stream<_i2.ChatListState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i2.ChatListState>.empty(),
      ) as _i4.Stream<_i2.ChatListState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i2.ChatListEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i2.ChatListEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i2.ChatListState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i2.ChatListEvent>(
    _i5.EventHandler<E, _i2.ChatListState>? handler, {
    _i5.EventTransformer<E>? transformer,
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
  void onTransition(
          _i5.Transition<_i2.ChatListEvent, _i2.ChatListState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void onChange(_i5.Change<_i2.ChatListState>? change) => super.noSuchMethod(
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

/// A class which mocks [AppBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppBloc extends _i1.Mock implements _i3.AppBloc {
  MockAppBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.AppState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeAppState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.AppState);

  @override
  _i4.Stream<_i3.AppState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i3.AppState>.empty(),
      ) as _i4.Stream<_i3.AppState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void add(_i3.AppEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i3.AppEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i3.AppState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i3.AppEvent>(
    _i5.EventHandler<E, _i3.AppState>? handler, {
    _i5.EventTransformer<E>? transformer,
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
  void onTransition(_i5.Transition<_i3.AppEvent, _i3.AppState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onChange(_i5.Change<_i3.AppState>? change) => super.noSuchMethod(
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

/// A class which mocks [ChatRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockChatRepository extends _i1.Mock implements _i6.ChatRepository {
  MockChatRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Stream<List<_i7.Chat>> streamChats({required String? userId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #streamChats,
          [],
          {#userId: userId},
        ),
        returnValue: _i4.Stream<List<_i7.Chat>>.empty(),
      ) as _i4.Stream<List<_i7.Chat>>);

  @override
  _i4.Stream<_i7.Chat> streamChat({required String? chatId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #streamChat,
          [],
          {#chatId: chatId},
        ),
        returnValue: _i4.Stream<_i7.Chat>.empty(),
      ) as _i4.Stream<_i7.Chat>);

  @override
  _i4.Future<void> addMessageToChat({
    required String? chatId,
    required _i8.Message? message,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addMessageToChat,
          [],
          {
            #chatId: chatId,
            #message: message,
          },
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
