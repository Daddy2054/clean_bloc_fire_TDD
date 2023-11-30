import 'package:bloc_test/bloc_test.dart';
import 'package:clean_bloc_firebase/src/features/auth/domain/entities/auth_user.dart';
import 'package:clean_bloc_firebase/src/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:clean_bloc_firebase/src/features/auth/domain/use_cases/stream_auth_user_use_case.dart';
import 'package:clean_bloc_firebase/src/shared/app/blocs/app/app_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_bloc_test.mocks.dart';

@GenerateMocks([StreamAuthUserUseCase, SignOutUseCase])
void main() {
  const authUser = AuthUser(id: 'id', email: 'test@test.com');
  late StreamAuthUserUseCase mockStreamAuthUserUseCase;
  late SignOutUseCase mockSignOutUseCase;

  setUp(() {
    mockStreamAuthUserUseCase = MockStreamAuthUserUseCase();
    mockSignOutUseCase = MockSignOutUseCase();
  });
  group('AppBloc', () {
    blocTest<AppBloc, AppState>(
      'emits [unauthenticated] when the user is empty',
      setUp: () {
        when(mockStreamAuthUserUseCase()).thenAnswer(
          (_) => Stream.value(AuthUser.empty),
        );
      },
      build: () => AppBloc(
        streamAuthUserUseCase: mockStreamAuthUserUseCase,
        signOutUseCase: mockSignOutUseCase,
        authUser: AuthUser.empty,
      ),
      expect: () => const [AppState.unauthenticated()],
    );
    blocTest<AppBloc, AppState>(
      'emits [authenticated] when the user is not empty',
      setUp: () {
        when(mockStreamAuthUserUseCase()).thenAnswer(
          (_) => Stream.value(authUser),
        );
      },
      build: () => AppBloc(
        streamAuthUserUseCase: mockStreamAuthUserUseCase,
        signOutUseCase: mockSignOutUseCase,
        authUser: authUser,
      ),
      expect: () => const [AppState.authenticated(authUser)],
    );

    blocTest<AppBloc, AppState>(
      'emits [authenticated] when user sign in',
      setUp: () {
        when(mockStreamAuthUserUseCase()).thenAnswer(
          (_) => Stream.value(authUser),
        );
      },
      build: () => AppBloc(
        streamAuthUserUseCase: mockStreamAuthUserUseCase,
        signOutUseCase: mockSignOutUseCase,
        authUser: AuthUser.empty,
      ),
      act: (bloc) => bloc.add(
        const AppUserChanged(
          AuthUser(id: 'id', email: 'test@test.com'),
        ),
      ),
      expect: () => [
        const AppState.authenticated(AuthUser(id: 'id', email: 'test@test.com'))
      ],
      verify: (_) {
        verify(mockStreamAuthUserUseCase()).called(1);
      },
    );

    blocTest<AppBloc, AppState>(
      'emits [unauthenticated] when user sign out and invokes signOut',
      setUp: () {
        when(mockSignOutUseCase()).thenAnswer(
          (_) => Future.value(),
        );
        when(mockStreamAuthUserUseCase()).thenAnswer(
          (_) => Stream.value(AuthUser.empty),
        );
      },
      build: () => AppBloc(
        streamAuthUserUseCase: mockStreamAuthUserUseCase,
        signOutUseCase: mockSignOutUseCase,
        authUser: const AuthUser(id: 'id', email: 'test@test.com'),
      ),
      act: (bloc) => bloc.add(const AppSignOutRequested()),
      expect: () => const [AppState.unauthenticated()],
      verify: (_) {
        verify(mockSignOutUseCase()).called(1);
      },
    );

    blocTest<AppBloc, AppState>(
      'emits [authenticated] when user sign in, does not emit again if the event is added twice',
      setUp: () {
        when(mockStreamAuthUserUseCase()).thenAnswer(
          (_) => Stream.value(authUser),
        );
      },
      build: () => AppBloc(
        streamAuthUserUseCase: mockStreamAuthUserUseCase,
        signOutUseCase: mockSignOutUseCase,
        authUser: AuthUser.empty,
      ),
      act: (bloc) => bloc
        ..add(const AppUserChanged(
          AuthUser(id: 'id', email: 'test@test.com'),
        ))
        ..add(const AppUserChanged(
          AuthUser(id: 'id', email: 'test@test.com'),
        )),
      expect: () => [
        const AppState.authenticated(AuthUser(id: 'id', email: 'test@test.com'))
      ],
    );

    blocTest<AppBloc, AppState>(
      'emits [unauthenticated] when user sign out, does not emit again if the event is added twice',
      setUp: () {
        when(mockSignOutUseCase()).thenAnswer(
          (_) => Future.value(),
        );
        when(mockStreamAuthUserUseCase()).thenAnswer(
          (_) => Stream.value(AuthUser.empty),
        );
      },
      build: () => AppBloc(
        streamAuthUserUseCase: mockStreamAuthUserUseCase,
        signOutUseCase: mockSignOutUseCase,
        authUser: const AuthUser(id: 'id', email: 'test@test.com'),
      ),
      act: (bloc) => bloc
        ..add(const AppSignOutRequested())
        ..add(const AppSignOutRequested()),
      expect: () => const [AppState.unauthenticated()],
    );
  });
}
