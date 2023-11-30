import 'dart:convert';

import 'package:streamhealth_interview/src/repositories/universities/university_model.dart';
import 'package:http/http.dart' as http;

const int induceDelay = 1;

class UniversityRepository {
  Future<List<University>> getUnivesities({
    required String country,
  }) async {
    final uri =
        Uri.parse("http://universities.hipolabs.com/search?country=$country");

    await Future.delayed(const Duration(seconds: induceDelay));

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      List<University> resultsList = [];

      for (final element in json) {
        resultsList.add(University.fromMap(element as Map<String, dynamic>));
      }

      if (resultsList.isEmpty) {
        throw 404;
      }
      return resultsList;
    } else {
      throw response.statusCode;
    }
  }
}
