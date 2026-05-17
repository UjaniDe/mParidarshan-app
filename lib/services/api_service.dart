import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/storage_service.dart';

class ApiService {
  static const String baseUrl = 'https://mparidarshan-backend-production.up.railway.app';

  static Future<Map<String, dynamic>> sendOtp(String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/send-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'otp': otp}),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getUserProfile() async {
    final token = await StorageService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/api/auth/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> createInspection({
  required String district,
  required String circle,
  required String school,
  required String schoolType,
  int? boysPresent,
  int? girlsPresent,
  int? boysAbsent,
  int? girlsAbsent,
  required String libraryBooks,
}) async {
  final token = await StorageService.getToken();
  final response = await http.post(
    Uri.parse('$baseUrl/api/inspections'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'district': district,
      'circle': circle,
      'school': school,
      'school_type': schoolType,
      'boys_present': boysPresent,
      'girls_present': girlsPresent,
      'boys_absent': boysAbsent,
      'girls_absent': girlsAbsent,
      'library_books': libraryBooks,
    }),
  );
  return jsonDecode(response.body);
}

static Future<List<dynamic>> getInspections() async {
  final token = await StorageService.getToken();
  final response = await http.get(
    Uri.parse('$baseUrl/api/inspections'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  return jsonDecode(response.body);
}
}