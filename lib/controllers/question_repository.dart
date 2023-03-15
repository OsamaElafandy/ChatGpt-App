import 'package:chatgpt/core/services/services.dart';

class QuestionRepository {
  static Future<dynamic> postQuestion(String question) async {
    var data = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": question}
      ]
    };
    final result = await Services.post("https://chatgpt-api.shn.hk/v1/", data);
    return result;
  }
}
