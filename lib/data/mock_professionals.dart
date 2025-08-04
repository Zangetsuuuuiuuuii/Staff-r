import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/professional.dart';

Future<List<Professional>> loadMockProfessionals() async {
  final String jsonString = await rootBundle.loadString('assets/data/mock_professionals.json');
  final List<dynamic> jsonList = json.decode(jsonString);

  return jsonList.map((e) => Professional.fromJson(e)).toList();
}
