import 'package:crud_flutter/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Note>?> getPosts() async {
    var client = http.Client();

    var url = Uri.parse('http://192.168.1.10:8000/api/note');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var json = response.body;
      return noteFromJson(json);
    }
  }
}
