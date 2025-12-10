import 'package:dio/dio.dart';

class ConnService {
  final Dio _dio;

  ConnService()
    : _dio = Dio(
        BaseOptions(
          // baseUrl: "http://10.0.2.2:5046",
          baseUrl: "http://192.168.50.15:5000",
          // baseUrl: "http://localhost:5046",
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          responseType: ResponseType.json,
        ),
      );

  Future<String> connect(String ip, int port, int timeout) async {
    try {
      final response = await _dio.post(
        "/connections",
        data: {"ip": ip, "port": port, "timeout": timeout},
      );
      print("Connected.");
      return response.data;
    } catch (e) {
      throw Exception("Error al conectar: $e");
    }
  }

  Future<int> getHandle() async {
    print("ENTRA AL METODO DE OBTENER HANDLE");
    try {
      print("ENTRA AL TRYYY");
      final response = await _dio.get("/connections/handle");
      print(response.data);
      return response.data;
    } catch (e) {
      throw Exception("Error al obtener el handle : $e");
    }
  }

  Future<String> disconnect() async {
    try {
      final response = await _dio.delete("/connections");
      return response.data;
    } catch (e) {
      throw Exception("Error al desconectar : $e");
    }
  }
}
