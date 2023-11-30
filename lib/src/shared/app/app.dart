import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/domain/entities/auth_user.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/sign_out_use_case.dart';
import '../../features/auth/domain/use_cases/stream_auth_user_use_case.dart';
import '../navigation/app_router.dart';
import 'blocs/app/app_bloc.dart';

class App extends StatelessWidget {
  const App({
    required AuthRepository authRepository,
    required AuthUser authUser,
    super.key,
  })  : _authRepository = authRepository,
        _authUser = authUser;

  final AuthRepository _authRepository;
  final AuthUser _authUser;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              streamAuthUserUseCase: StreamAuthUserUseCase(
                authRepository: _authRepository,
              ),
              signOutUseCase: SignOutUseCase(
                authRepository: _authRepository,
              ),
              authUser: _authUser,
            )..add(AppUserChanged(_authUser)),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Clean Architecture & TDD',
      theme: ThemeData.light(useMaterial3: true),
      routerConfig: AppRouter(context.read<AppBloc>()).router,
    );
  }
}
