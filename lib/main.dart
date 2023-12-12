import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'src/features/auth/data/data_sources/auth_remote_data_source_firebase.dart';
import 'src/features/auth/data/repositories/auth_repository_impl.dart';
import 'src/features/auth/domain/repositories/auth_repository.dart';
import 'src/features/chat/data/models/chat_model.dart';
import 'src/features/chat/data/models/message_model.dart';
import 'src/features/chat/data/repositories/chat_repository_impl.dart';
import 'src/features/chat/domain/repositories/chat_repository.dart';
import 'src/features/common/data/data_sources/local_data_source.dart';
import 'src/features/common/data/data_sources/remote_data_source.dart';
import 'src/features/common/data/data_sources/remote_data_source_cloud_firestore.dart';
import 'src/features/feed/data/models/post_model.dart';
import 'src/features/feed/data/repositories/post_repository_impl.dart';
import 'src/features/feed/domain/repositories/post_repository.dart';
import 'src/shared/app/app.dart';

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(PostModelAdapter())
    ..registerAdapter(MessageModelAdapter())
    ..registerAdapter(ChatModelAdapter());

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

      LocalDataSource<PostModel> postLocalDataSource =
          LocalDataSource<PostModel>(
        boxName: 'posts',
        boxType: PostModel,
      );
      LocalDataSource<ChatModel> chatLocalDataSource =
          LocalDataSource<ChatModel>(
        boxName: 'chats',
        boxType: ChatModel,
      );
      AuthRepository authRepository = AuthRepositoryImpl(
        localDataSource: authLocalDataSource,
        remoteDataSource: authRemoteDataSource,
      );

      PostRepository postRepository = PostRepositoryImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: postLocalDataSource,
      );

      ChatRepository chatRepository = ChatRepositoryImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: chatLocalDataSource,
      );

      return App(
        authRepository: authRepository,
        postRepository: postRepository,
        chatRepository: chatRepository,
        authUser: await authRepository.authUser.first,
      );
    },
  );
}
