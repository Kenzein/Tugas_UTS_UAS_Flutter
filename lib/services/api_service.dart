import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_laundry/models/service.dart';

class ApiService {
  static const String baseUrl =
      'https://6a144f5e6c7db8aac054462e.mockapi.io/api/v1/services';

  Future<List<Service>> getServices() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData.map((item) => Service.fromJson(item)).toList();
    } else {
      throw Exception('Gagal mengambil data layanan');
    }
  }
}
