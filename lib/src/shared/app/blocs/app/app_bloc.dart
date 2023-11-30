import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/auth/domain/use_cases/stream_auth_user_use_case.dart';
import '../../../../features/auth/domain/entities/auth_user.dart';
import '../../../../features/auth/domain/use_cases/sign_out_use_case.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final StreamAuthUserUseCase _streamAuthUserUseCase;
  final SignOutUseCase _signOutUseCase;
  late StreamSubscription<AuthUser> _authUserSubscription;

  AppBloc({
    required StreamAuthUserUseCase streamAuthUserUseCase,
    required SignOutUseCase signOutUseCase,
    required AuthUser authUser,
  })  : _streamAuthUserUseCase = streamAuthUserUseCase,
        _signOutUseCase = signOutUseCase,
        super(
          authUser == AuthUser.empty
              ? const AppState.unauthenticated()
              : AppState.authenticated(authUser),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppSignOutRequested>(_onSignOutRequested);

    _authUserSubscription = _streamAuthUserUseCase().listen(_userChanged);
  }

  void _userChanged(AuthUser authUser) => add(AppUserChanged(authUser));

  void _onUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) {
    return event.authUser.isEmpty
        ? emit(const AppState.unauthenticated())
        : emit(AppState.authenticated(event.authUser));
  }

  void _onSignOutRequested(
    AppSignOutRequested event,
    Emitter<AppState> emit,
  ) {
    unawaited(_signOutUseCase());
  }

  @override
  Future<void> close() {
    _authUserSubscription.cancel();
    return super.close();
  }
}
