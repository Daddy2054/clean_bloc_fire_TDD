import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_bloc_firebase/src/features/feed/domain/entities/post.dart';
import 'package:clean_bloc_firebase/src/features/feed/domain/repositories/post_repository.dart';
import 'package:clean_bloc_firebase/src/features/feed/presentation/blocs/feed/feed_bloc.dart';
import 'package:clean_bloc_firebase/src/features/feed/presentation/screens/feed_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'feed_screen_test.mocks.dart';

@GenerateMocks([FeedBloc, PostRepository])
void main() {
  late MockFeedBloc mockFeedBloc;
  late MockPostRepository mockPostRepository;

  const tPost = Post(
    id: '1',
    imageUrl: 'https://via.placeholder.com/150',
    caption: 'Test caption',
  );

  setUp(() {
    mockFeedBloc = MockFeedBloc();
    mockPostRepository = MockPostRepository();

    // Stubbing the FeedBloc instance for testing
    when(mockFeedBloc.state).thenReturn(const FeedState());
    // Stub the state stream.
    when(mockFeedBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([const FeedState()]),
    );
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      home: BlocProvider<FeedBloc>(
        create: (_) => mockFeedBloc,
        child: const FeedView(),
      ),
    );
  }

  testWidgets('renders a FeedScreen', (tester) async {
    await tester.pumpWidget(
      RepositoryProvider<PostRepository>(
        create: (_) => mockPostRepository,
        child: const MaterialApp(home: FeedScreen()),
      ),
    );

    expect(find.byType(FeedScreen), findsOneWidget);
  });

  // Define a widget test for the initial/loading state
  testWidgets(
      'FeedView should show CircularProgressIndicator when initial or loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // Define a widget test for the loaded state
  testWidgets('FeedView should show posts when loaded',
      (WidgetTester tester) async {
    when(mockFeedBloc.state).thenReturn(
      const FeedState(
        status: FeedStatus.loaded,
        posts: [tPost, tPost],
      ),
    );
    await mockNetworkImagesFor(() => tester.pumpWidget(makeTestableWidget()));
    // Find the Card widget
    final cardWidgets = tester.widgetList(find.byType(Card)).toList();

    expect(cardWidgets.length, 2);
    for (final cardWidget in cardWidgets) {
      expect((cardWidget as Card).clipBehavior, Clip.hardEdge);
      expect((cardWidget).child, isA<Column>());
    }

    // Find Text widgets that are descendants of a Card widget
    final textWidgetsInsideCard = find
        .descendant(
          of: find.byType(Card),
          matching: find.byType(Text),
        )
        .evaluate()
        .toList();

    expect(textWidgetsInsideCard.length, 2);

    for (final textWidget in textWidgetsInsideCard) {
      expect((textWidget.widget as Text).maxLines, 3);
      expect((textWidget.widget as Text).data, tPost.caption);
    }

    // Find the Image widgets
    final imageWidgets = tester.widgetList<Image>(find.byType(Image)).toList();

    expect(imageWidgets.length, 2);
  });

  // Define a widget test for the error state
  testWidgets('FeedView should show error message when there is an error',
      (WidgetTester tester) async {
    when(mockFeedBloc.state).thenReturn(
      const FeedState(status: FeedStatus.error),
    );

    await tester.pumpWidget(makeTestableWidget());
    expect(find.text('Something went wrong.'), findsOneWidget);
  });
}
