import 'package:dio/dio.dart';

class ControlService {
  final Dio _dio;

  ControlService()
    : _dio = Dio(
        BaseOptions(
          // baseUrl: "http://10.0.2.2:5046",
          baseUrl: "http://192.168.50.15:5046",
          // baseUrl: "http://localhost:5046",
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          responseType: ResponseType.json,
        ),
      );

  Future<List<String>> getAbsPositions() async {
    try {
      final response = await _dio.get("/positions/absolute");
      return response.data;
    } catch (e) {
      throw Exception("Error al obtener posiciones : $e");
    }
  }

  Future<String> getAbsPosition(int axis) async {
    print("Requesting absolute position for  axis $axis");
    try {
      final response = await _dio.get("/positions/absolute/$axis");

      return response.data.toString();
    } catch (e) {
      throw Exception("Error al obtener posiciones : $e");
    }
  }

  Future<List<String>> getMachPositions() async {
    try {
      final response = await _dio.get("/positions/machine");
      return response.data;
    } catch (e) {
      throw Exception("Error al obtener posiciones : $e");
    }
  }

  Future<String> getMachPosition(int axis) async {
    try {
      final response = await _dio.get("/positions/machine/$axis");

      return response.data.toString();
    } catch (e) {
      throw Exception("Error al obtener posiciones : $e");
    }
  }

  Future<String> startJog(int axis, int direction) async {
    try {
      print("SE MANDA EL AXIS $axis");
      final response = await _dio.post(
        "/control/jog/start",
        data: {"axis": axis, "direction": direction},
      );
      return response.data;
    } catch (e) {
      throw Exception("Error al iniciar jog en eje $axis : $e");
    }
  }

  Future<String> startJogFeedrate(int axis, int direction, int feedrate) async {
    try {
      final response = await _dio.post(
        "/control/jog/feedrate/start",
        data: {"axis": axis, "direction": direction, "feedrate": feedrate},
      );
      return response.data;
    } catch (e) {
      throw Exception("Error al iniciar jog en eje $axis : $e");
    }
  }

  Future<String> stopJog(List<int?> axes) async {
    try {
      final response = await _dio.post(
        "/control/jog/stop",
        data: {"axis1": axes[0], "axis2": axes[1]},
      );
      return response.data;
    } catch (e) {
      throw Exception("Error al detener jog : $e");
    }
  }

  Future<int> getMode() async {
    try {
      final response = await _dio.get("/mode");

      return response.data;
    } catch (e) {
      throw Exception("Error getting mode : $e");
    }
  }

  Future<String> setMode(int mode) async {
    try {
      print("este es el MODEEE: $mode");
      final response = await _dio.post("/mode?mode=$mode");

      return response.data;
    } catch (e) {
      throw Exception("Error setting mode : $e");
    }
  }

  Future<String> getProgram(int programNum) async {
    try {
      final response = await _dio.get("/program?programNum=$programNum");

      return response.data;
    } catch (e) {
      throw Exception("Error getting program : $e");
    }
  }

  Future<List<String>> getPrograms() async {
    try {
      final response = await _dio.get("/programs/all");

      // Si la respuesta es una lista dinámica
      final data = response.data;

      // Asegúrate de que es una lista
      if (data is List) {
        // Convertimos cada elemento a String
        return data.map((e) => e.toString()).toList();
      } else {
        // Si no es una lista, lanzamos un error claro
        throw Exception("Invalid response format: expected a list");
      }
    } catch (e) {
      throw Exception("Error getting programs: $e");
    }
  }
}
