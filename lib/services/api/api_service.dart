import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl =
      "https://supay.in/recharge_api/recharge?member_id=9876543210&api_password=1234&api_pin=1234&number=998988200";

  Future<Map<String, dynamic>> fetchApiResponse() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load API response');
    }
  }
}
