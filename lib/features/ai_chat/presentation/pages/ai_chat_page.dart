import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/ai_chat_cubit.dart';
import '../cubit/ai_chat_state.dart';

class AiChatPage extends StatelessWidget {
  const AiChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiChatCubit(),
      child: const AiChatView(),
    );
  }
}

class AiChatView extends StatefulWidget {
  const AiChatView({super.key});

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1E293B)),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy, color: Colors.blueAccent, size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              'EduFlow AI',
              style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<AiChatCubit, AiChatState>(
                listener: (context, state) {
                  if (state is AiChatLoaded) {
                    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
                  }
                },
                builder: (context, state) {
                  if (state is AiChatLoaded) {
                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: state.messages.length + (state.isTyping ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.messages.length && state.isTyping) {
                          return _buildTypingIndicator();
                        }
                        final message = state.messages[index];
                        return _buildMessageBubble(message);
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            _buildMessageInput(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
          boxShadow: isUser
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.white : const Color(0xFF1E293B),
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 8),
            Text('EduFlow AI is typing...', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: const Color(0xFFF1F5F9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  context.read<AiChatCubit>().sendMessage(value);
                  _textController.clear();
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              final text = _textController.text;
              if (text.trim().isNotEmpty) {
                context.read<AiChatCubit>().sendMessage(text);
                _textController.clear();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
