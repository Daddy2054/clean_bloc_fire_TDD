import 'package:clean_bloc_firebase/src/features/feed/domain/entities/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Post entity', () {
    test(
        'should create Post object with given id, caption, imageUrl, and createdAt',
        () {
      // Sample data to create the Post object
      const id = '1';
      const caption = 'Sample caption';
      const imageUrl = 'imageUrl';
      final createdAt = DateTime.now();

      // Create a Post object
      final post = Post(
        id: id,
        caption: caption,
        imageUrl: imageUrl,
        createdAt: createdAt,
      );

      // Validate if the object is created with the expected values
      expect(post.id, id);
      expect(post.caption, caption);
      expect(post.imageUrl, imageUrl);
      expect(post.createdAt, createdAt);
    });

    test('empty Post has correct default values', () {
      expect(Post.empty.id, equals(''));
      expect(Post.empty.caption, equals(''));
      expect(Post.empty.imageUrl, equals(''));
      expect(Post.empty.createdAt, equals(null));
    });

    test('two Post instances with different values are not equal', () {
      final createdAt = DateTime.now();
      final post = Post(
        id: 'id',
        caption: 'caption',
        imageUrl: 'imageUrl',
        createdAt: createdAt,
      );
      final post2 = Post(
        id: 'id',
        caption: 'different caption',
        imageUrl: 'imageUrl',
        createdAt: createdAt,
      );
      expect(post, isNot(equals(post2)));
    });

    test('props returns correct properties', () {
      final createdAt = DateTime.now();
      final post = Post(
        id: 'id',
        caption: 'caption',
        imageUrl: 'imageUrl',
        createdAt: createdAt,
      );

      expect(
        post.props,
        equals(
          [
            'id',
            'caption',
            'imageUrl',
            createdAt,
          ],
        ),
      );
    });

    test('createdAt can be null', () {
      const post = Post(
        id: 'id',
        caption: 'caption',
        imageUrl: 'imageUrl',
      );
      expect(post.createdAt, isNull);
    });
  });
}
