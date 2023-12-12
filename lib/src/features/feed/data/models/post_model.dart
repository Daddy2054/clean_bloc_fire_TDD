import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/post.dart';

part 'post_model.g.dart';

@HiveType(typeId: 0)
class PostModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String caption;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final DateTime? createdAt;

  const PostModel({
    required this.id,
    required this.caption,
    required this.imageUrl,
    this.createdAt,
  });

  factory PostModel.fromFakeDataSource(
    Map<String, dynamic>? data, {
    String? id,
  }) {
    return PostModel(
      id: id ?? '',
      caption: data?['caption'] ?? '',
      imageUrl: data?['imageUrl'] ?? '',
      createdAt: data?['createdAt'] != null
          ? DateTime.parse(data?['createdAt'])
          : null,
    );
  }

  factory PostModel.fromCloudFirestore(
    Map<String, dynamic>? data, {
    String? id,
  }) {
    return PostModel(
      id: id ?? '',
      caption: data?['caption'] ?? '',
      imageUrl: data?['imageUrl'] ?? '',
      createdAt: data?['createdAt'].toDate(),
    );
  }

  Post toEntity() {
    return Post(
      id: id,
      caption: caption,
      imageUrl: imageUrl,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, caption, imageUrl, createdAt];
}
