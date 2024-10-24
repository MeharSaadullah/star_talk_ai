class ChatModels {
  final String role;
  final List<ChatParModel> parts;

  ChatModels({required this.role, required this.parts});

  // Convert ChatModels to Map
  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'parts': parts.map((x) => x.toMap()).toList(),
    };
  }
}

class ChatParModel {
  final String text;

  ChatParModel({required this.text});

  // Convert ChatParModel to Map
  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }
}
