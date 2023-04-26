import "package:crudflutter/user.dart";
import "package:http/http.dart" as http;

class RemoteServer {
   Future<List<User>?> getPosts() async {
    var client = http.Client();

    var uri =
        Uri.parse("https://631c37911b470e0e12fcdd0b.mockapi.io/api/users");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    }
  }
}
