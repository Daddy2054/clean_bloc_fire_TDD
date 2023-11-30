import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/domain/entities/auth_user.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../navigation/app_router.dart';

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
    debugPrint(_authUser.toString());
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
      ],
      child: const AppView(),
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
      routerConfig: AppRouter().router,
    );
  }
}
