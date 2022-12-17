import 'dart:convert';

import 'package:flutter_application_1/model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=7ab0c91dec063f7e6a405b40e76f54be'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) =>  Users.fromJson(job)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Users');
    }
  }
}