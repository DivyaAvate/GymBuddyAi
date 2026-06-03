import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/util/api_client.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  return ChatNotifier(ref.watch(dioProvider));
});

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final _dio;
  ChatNotifier(this._dio) : super([]);

  Future<void> sendMessage(String text) async {
    state = [...state, ChatMessage(text: text, isUser: true)];
    
    try {
      final response = await _dio.post('/ai/chat', data: {'message': text});
      final reply = response.data['reply'];
      state = [...state, ChatMessage(text: reply, isUser: false)];
    } catch (e) {
      state = [...state, ChatMessage(text: "Sorry, I'm having trouble connecting.", isUser: false)];
    }
  }
}