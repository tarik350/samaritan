import '../models/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  // List<Post> posts = [];
  Future<Post> getPosts(String? medication) async {
    var client = http.Client();
    // var anotherUri = Uri.parse(
    //     'https://api.fda.gov/drug/label.json?search=${medication}&limit=1');

    ////there is a bug with this api call -- it allows users to search with random words
    var uri = Uri.parse(
        'https://api.fda.gov/drug/label.json?search=description:${medication}&limit=1');
    // var anotherResponse = await client.get(anotherUri);
    var response = await client.get(uri);

    // if(anotherResponse.statusCode == 200){
    //   var json = anotherResponse.body;
    //   posts.add(postFromJson(json));
    // }
    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
    } else {
      return postFromJson(response.statusCode.toString());
    }
  }
}
