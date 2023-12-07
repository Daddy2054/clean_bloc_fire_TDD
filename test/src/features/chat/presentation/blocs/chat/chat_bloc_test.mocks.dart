// Mocks generated by Mockito 5.4.3 from annotations
// in clean_bloc_firebase/test/src/features/chat/presentation/blocs/chat/chat_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart'
    as _i5;
import 'package:clean_bloc_firebase/src/features/chat/domain/repositories/chat_repository.dart'
    as _i2;
import 'package:clean_bloc_firebase/src/features/chat/domain/use_cases/send_message_use_case.dart'
    as _i6;
import 'package:clean_bloc_firebase/src/features/chat/domain/use_cases/stream_chat_use_case.dart'
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

class _FakeChatRepository_0 extends _i1.SmartFake
    implements _i2.ChatRepository {
  _FakeChatRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [StreamChatUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamChatUseCase extends _i1.Mock implements _i3.StreamChatUseCase {
  MockStreamChatUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ChatRepository get chatRepository => (super.noSuchMethod(
        Invocation.getter(#chatRepository),
        returnValue: _FakeChatRepository_0(
          this,
          Invocation.getter(#chatRepository),
        ),
      ) as _i2.ChatRepository);

  @override
  _i4.Stream<_i5.Chat> call(_i3.StreamChatParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i4.Stream<_i5.Chat>.empty(),
      ) as _i4.Stream<_i5.Chat>);
}

/// A class which mocks [SendMessageUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSendMessageUseCase extends _i1.Mock
    implements _i6.SendMessageUseCase {
  MockSendMessageUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ChatRepository get chatRepository => (super.noSuchMethod(
        Invocation.getter(#chatRepository),
        returnValue: _FakeChatRepository_0(
          this,
          Invocation.getter(#chatRepository),
        ),
      ) as _i2.ChatRepository);

  @override
  _i4.Future<void> call(_i6.SendMessageParams? params) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
