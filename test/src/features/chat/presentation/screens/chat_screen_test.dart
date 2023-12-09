import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_bloc_firebase/src/features/auth/domain/entities/auth_user.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:clean_bloc_firebase/src/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:clean_bloc_firebase/src/features/chat/presentation/screens/chat_screen.dart';
import 'package:clean_bloc_firebase/src/shared/app/blocs/app/app_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_screen_test.mocks.dart';

@GenerateMocks([ChatBloc, AppBloc, ChatRepository])
void main() {
  late MockChatBloc mockChatBloc;
  late MockChatRepository mockChatRepository;
  late MockAppBloc mockAppBloc;

  setUp(() {
    mockChatRepository = MockChatRepository();
    mockAppBloc = MockAppBloc();
    mockChatBloc = MockChatBloc();
  });

  final tChat = Chat(
    id: '1',
    userIds: const ['user_1', 'user_2'],
    lastMessage: Message(
      id: 'message_2',
      senderId: 'user_1',
      receiverId: 'user_2',
      text: 'Sample Text',
      createdAt: DateTime.now(),
    ),
    createdAt: DateTime.now(),
    messages: [
      Message(
        id: 'message_2',
        senderId: 'user_1',
        receiverId: 'user_2',
        text: 'Sample Text',
        createdAt: DateTime.now(),
      ),
      Message(
        id: 'message_1',
        senderId: 'user_1',
        receiverId: 'user_2',
        text: 'Sample Text',
        createdAt: DateTime.now(),
      ),
    ],
  );

  setUp(() {
    mockChatBloc = MockChatBloc();
    mockChatRepository = MockChatRepository();

    // Stubbing the ChatBloc instance for testing
    when(mockChatBloc.state).thenReturn(const ChatState());
    // Stub the state stream.
    when(mockChatBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([const ChatState()]),
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
          BlocProvider<ChatBloc>(
            create: (_) => mockChatBloc,
          ),
          BlocProvider<AppBloc>(
            create: (context) => mockAppBloc,
          ),
        ],
        child: const ChatView(userId: 'user_1'),
      ),
    );
  }

  testWidgets('renders a ChatScreen', (tester) async {
    await tester.pumpWidget(
      RepositoryProvider<ChatRepository>(
        create: (_) => mockChatRepository,
        child: BlocProvider<AppBloc>(
          create: (context) => mockAppBloc,
          child: const MaterialApp(home: ChatScreen(chatId: 'chat_1')),
        ),
      ),
    );

    expect(find.byType(ChatScreen), findsOneWidget);
  });

  // Define a widget test for the initial/loading state
  testWidgets(
      'ChatView should show CircularProgressIndicator when initial or loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // Define a widget test for the loaded state
  testWidgets('ChatView should show the messages when loaded inside a ListView',
      (WidgetTester tester) async {
    when(mockChatBloc.state).thenReturn(
      ChatState(
        status: ChatStatus.loaded,
        chat: tChat,
      ),
    );
    await tester.pumpWidget(makeTestableWidget());

    // Find the a listview with all the messages
    expect(find.byType(ListView), findsOneWidget);

    // Find Text widgets that are descendants of a Card widget
    final textWidgetsInsideListView = find
        .descendant(
          of: find.byType(ListView),
          matching: find.byType(Text),
        )
        .evaluate()
        .toList();

    expect(textWidgetsInsideListView.length, 2);

    for (final textWidget in textWidgetsInsideListView) {
      expect((textWidget.widget as Text).data, 'Sample Text');
    }
  });

  testWidgets('renders text field for writing a new message',
      (WidgetTester tester) async {
    when(mockChatBloc.state).thenReturn(
      const ChatState(
        status: ChatStatus.loaded,
      ),
    );

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(TextField), findsOneWidget);
  });
}
