import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/domain/entities/auth_user.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/sign_out_use_case.dart';
import '../../features/auth/domain/use_cases/stream_auth_user_use_case.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/feed/domain/repositories/post_repository.dart';
import '../navigation/app_router.dart';
import '../theme/app_theme.dart';
import 'blocs/app/app_bloc.dart';

class App extends StatelessWidget {
  const App({
    required AuthRepository authRepository,
    required PostRepository postRepository,
    required ChatRepository chatRepository,
    required AuthUser authUser,
    super.key,
  })  : _authRepository = authRepository,
        _postRepository = postRepository,
        _chatRepository = chatRepository,
        _authUser = authUser;

  final AuthRepository _authRepository;
  final PostRepository _postRepository;
  final ChatRepository _chatRepository;
  final AuthUser _authUser;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _postRepository),
        RepositoryProvider.value(value: _chatRepository),
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
      theme: AppTheme.theme,
      routerConfig: AppRouter(context.read<AppBloc>()).router,
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Screen'),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Row(children: []),
//           ElevatedButton(
//             onPressed: () {
//               // context.goNamed('sign-up');
//               context.pushNamed('sign-up');
//               // Navigator.of(context).push(
//               //   MaterialPageRoute(
//               //     builder: (_) => const SignUpScreen(),
//               //   ),
//               // );
//             },
//             child: const Text('Sign Up'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // context.goNamed('sign-in');
//               context.pushNamed('sign-in');
//               // Navigator.of(context).push(
//               //   MaterialPageRoute(
//               //     builder: (_) => const SignInScreen(),
//               //   ),
//               // );
//             },
//             child: const Text('Sign In'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               context.read<AppBloc>().add(const AppSignOutRequested());
//             },
//             child: const Text('Sign Out'),
//           ),
//         ],
//       ),
//     );
//   }
// }
