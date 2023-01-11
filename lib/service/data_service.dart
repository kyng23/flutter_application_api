import 'dart:convert';

import 'package:http/http.dart' as http;

class DataService {
  final String title;
  final String text;
  DataService({required this.title, required this.text});

  factory DataService.fromJson(Map<String, dynamic> json) {
    return DataService(title: json['speed'], text: json['temp2m']);
  }
}
