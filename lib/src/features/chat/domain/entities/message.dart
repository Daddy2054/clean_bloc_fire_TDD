import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime? createdAt;

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    this.createdAt,
  });

  static const empty = Message(id: '', senderId: '', receiverId: '', text: '');

  @override
  List<Object?> get props => [id, senderId, receiverId, text, createdAt];
}
