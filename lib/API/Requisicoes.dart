import 'package:http/http.dart' as http;
import 'dart:convert';


const request = "http://myfriend.pythonanywhere.com/web/service/locais/";

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}