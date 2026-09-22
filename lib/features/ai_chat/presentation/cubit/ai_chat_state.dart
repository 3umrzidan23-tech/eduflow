import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, text, isUser, timestamp];
}

abstract class AiChatState extends Equatable {
  const AiChatState();

  @override
  List<Object?> get props => [];
}

class AiChatInitial extends AiChatState {}

class AiChatLoaded extends AiChatState {
  final List<ChatMessage> messages;
  final bool isTyping;

  const AiChatLoaded({required this.messages, this.isTyping = false});

  AiChatLoaded copyWith({
    List<ChatMessage>? messages,
    bool? isTyping,
  }) {
    return AiChatLoaded(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  @override
  List<Object?> get props => [messages, isTyping];
}
