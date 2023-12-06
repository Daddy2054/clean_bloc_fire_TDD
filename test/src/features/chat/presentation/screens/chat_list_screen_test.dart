import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:clean_bloc_firebase/src/features/auth/domain/entities/auth_user.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:clean_bloc_firebase/src/features/chat/presentation/blocs/chat_list/chat_list_bloc.dart';
import 'package:clean_bloc_firebase/src/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:clean_bloc_firebase/src/shared/app/blocs/app/app_bloc.dart';

import 'chat_list_screen_test.mocks.dart';

@GenerateMocks([ChatListBloc, AppBloc, ChatRepository])
void main() {
  late MockChatListBloc mockChatListBloc;
  late MockChatRepository mockChatRepository;
  late MockAppBloc mockAppBloc;

  setUp(() {
    mockChatRepository = MockChatRepository();
    mockAppBloc = MockAppBloc();
    mockChatListBloc = MockChatListBloc();
  });

  final tChat = Chat(
    id: '1',
    userIds: const ['user1', 'user2'],
    lastMessage: Message(
      id: '1',
      senderId: 'user1',
      receiverId: 'user2',
      text: 'Sample Text',
      createdAt: DateTime.now(),
    ),
    createdAt: DateTime.now(),
    messages: [
      Message(
        id: '1',
        senderId: 'user1',
        receiverId: 'user2',
        text: 'Sample Text',
        createdAt: DateTime.now(),
      ),
    ],
  );

  setUp(() {
    mockChatListBloc = MockChatListBloc();
    mockChatRepository = MockChatRepository();

    // Stubbing the ChatListBloc instance for testing
    when(mockChatListBloc.state).thenReturn(const ChatListState());
    // Stub the state stream.
    when(mockChatListBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([const ChatListState()]),
    );

    // Stubbing the AppBloc instance for testing
    when(mockAppBloc.state).thenReturn(
      const AppState.authenticated(
        AuthUser(id: '1', email: 'test@gmail.com'),
      ),
    );
    // Stub the state stream.
    when(mockAppBloc.stream).thenAnswer(
      (_) => Stream.fromIterable(
        [
          const AppState.authenticated(
            AuthUser(id: '1', email: 'test@gmail.com'),
          ),
        ],
      ),
    );
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ChatListBloc>(
            create: (_) => mockChatListBloc,
          ),
          BlocProvider<AppBloc>(
            create: (context) => mockAppBloc,
          ),
        ],
        child: const ChatListView(),
      ),
    );
  }

  testWidgets('renders a ChatListScreen', (tester) async {
    await tester.pumpWidget(
      RepositoryProvider<ChatRepository>(
        create: (_) => mockChatRepository,
        child: BlocProvider<AppBloc>(
          create: (context) => mockAppBloc,
          child: const MaterialApp(home: ChatListScreen()),
        ),
      ),
    );

    expect(find.byType(ChatListScreen), findsOneWidget);
  });

  // Define a widget test for the initial/loading state
  testWidgets(
      'ChatListView should show CircularProgressIndicator when initial or loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // Define a widget test for the loaded state
  testWidgets('ChatListView should show Chats when loaded inside a ListView',
      (WidgetTester tester) async {
    when(mockChatListBloc.state).thenReturn(
      ChatListState(
        status: ChatListStatus.loaded,
        chats: [tChat],
      ),
    );
    await tester.pumpWidget(makeTestableWidget());

    // Find the a listview with all the chats
    expect(find.byType(ListView), findsOneWidget);

    final listTileWidgets = tester.widgetList(find.byType(ListTile)).toList();
    expect(listTileWidgets.length, 1);
  });
}
