import 'package:clean_bloc_firebase/src/features/auth/domain/entities/auth_user.dart';
import 'package:clean_bloc_firebase/src/shared/app/blocs/app/app_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppEvent', () {
    group('AppUserChanged', () {
      test('supports value comparisons', () {
        expect(
          const AppUserChanged(AuthUser.empty),
          const AppUserChanged(AuthUser.empty),
        );
      });
    });

    group('AppSignOutRequested', () {
      test('supports value comparisons', () {
        expect(
          const AppSignOutRequested(),
          const AppSignOutRequested(),
        );
      });
    });
  });
}
