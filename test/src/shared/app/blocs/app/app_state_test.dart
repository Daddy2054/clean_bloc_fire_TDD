import 'package:clean_bloc_firebase/src/features/auth/domain/entities/auth_user.dart';
import 'package:clean_bloc_firebase/src/shared/app/blocs/app/app_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppState', () {
    const authUser = AuthUser(id: 'id', email: 'test@test.com');
    test('creates an unknown AppState by default', () {
      const state = AppState(status: AppStatus.unknown);

      expect(state.status, AppStatus.unknown);
      expect(state.authUser, AuthUser.empty);
    });

    test('creates an authenticated AppState', () {
      const state = AppState.authenticated(authUser);

      expect(state.status, AppStatus.authenticated);
      expect(state.authUser, authUser);
    });

    test('creates an unauthenticated AppState', () {
      const state = AppState.unauthenticated();

      expect(state.status, AppStatus.unauthenticated);
      expect(state.authUser, AuthUser.empty);
    });

    test('copyWith modifies the AppState', () {
      const state = AppState(status: AppStatus.unknown);
      final newState = state.copyWith(
        status: AppStatus.authenticated,
        authUser: authUser,
      );

      expect(newState.status, AppStatus.authenticated);
      expect(newState.authUser, authUser);
    });

    test('props contains all properties', () {
      const state = AppState(
        status: AppStatus.authenticated,
        authUser: authUser,
      );

      expect(state.props, [AppStatus.authenticated, authUser]);
    });
  });
}
