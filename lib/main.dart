import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'src/features/auth/data/data_sources/auth_remote_data_source_firebase.dart';
import 'src/features/auth/data/repositories/auth_repository_impl.dart';
import 'src/features/auth/domain/repositories/auth_repository.dart';
import 'src/features/common/data/data_sources/remote_data_source.dart';
import 'src/features/common/data/data_sources/remote_data_source_cloud_firestore.dart';
import 'src/features/feed/data/repositories/post_repository_impl.dart';
import 'src/features/feed/domain/repositories/post_repository.dart';
import 'src/shared/app/app.dart';

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(await builder());
}

void main() {
  bootstrap(
    () async {
      AuthLocalDataSource authLocalDataSource = AuthLocalDataSource();
      AuthRemoteDataSource authRemoteDataSource =
          AuthRemoteDataSourceFirebase();

    // RemoteDataSource remoteDataSource = RemoteDataSourceFake();
      RemoteDataSource remoteDataSource = RemoteDataSourceCloudFirestore();

      AuthRepository authRepository = AuthRepositoryImpl(
        localDataSource: authLocalDataSource,
        remoteDataSource: authRemoteDataSource,
      );


      PostRepository postRepository = PostRepositoryImpl(
        remoteDataSource: remoteDataSource,
      );

      return App(
        authRepository: authRepository,
        postRepository: postRepository,
        authUser: await authRepository.authUser.first,
      );
    },
  );
}
