import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkHelper {

  NetworkHelper(this.url);
  final String url;

  Future getData() async {

    //Response object comes form http package
    http.Response resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      String data = resp.body;
      //decode our JSON to get the values from the API response.
      return jsonDecode(data);
    } else {
      print(resp.statusCode);
    }

  }
}