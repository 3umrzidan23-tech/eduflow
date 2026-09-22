import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:uuid/uuid.dart';
import 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final _uuid = const Uuid();
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  AiChatCubit() : super(const AiChatLoaded(messages: [])) {
    // Send welcome message
    _addBotMessage('Hello! I am EduFlow AI Assistant. How can I help you with your studies today?');
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    if (state is AiChatLoaded) {
      final currentState = state as AiChatLoaded;
      
      // Add user message
      final userMsg = ChatMessage(
        id: _uuid.v4(),
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      );
      
      emit(currentState.copyWith(
        messages: List.from(currentState.messages)..add(userMsg),
        isTyping: true,
      ));

      try {
        final HttpsCallable callable = _functions.httpsCallable('chatWithGemini');
        final result = await callable.call(<String, dynamic>{
          'prompt': text,
        });

        if (result.data != null && result.data['response'] != null) {
          _addBotMessage(result.data['response'] as String);
        } else {
          _addBotMessage('I received an empty response. Please try again.');
        }
      } on FirebaseFunctionsException catch (e) {
        if (e.code == 'not-found') {
           _addBotMessage("AI Assistant is temporarily unavailable. The backend service is not deployed yet. Please configure the GEMINI API KEY on the backend.");
        } else {
          _addBotMessage("AI Assistant is temporarily unavailable. Please try again later. (${e.message})");
        }
      } catch (e) {
        _addBotMessage("Unable to connect. Check your internet connection or try again later.");
      } finally {
        if (state is AiChatLoaded) {
          final s = state as AiChatLoaded;
          emit(s.copyWith(isTyping: false));
        }
      }
    }
  }

  void _addBotMessage(String text) {
    if (state is AiChatLoaded) {
      final currentState = state as AiChatLoaded;
      final botMsg = ChatMessage(
        id: _uuid.v4(),
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      );
      
      emit(currentState.copyWith(
        messages: List.from(currentState.messages)..add(botMsg),
        isTyping: false,
      ));
    }
  }
}
