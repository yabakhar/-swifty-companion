import 'package:http/http.dart' as http;

Future<String> getImageUrl(url) async {
  try {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return url;
    }
    else
      throw Error();
  } catch (e) {
    throw e;
  }
}
