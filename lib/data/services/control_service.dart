import 'package:dio/dio.dart';
import 'package:fanuc_focas_app/domain/models/info_model.dart';

class ControlService {
  final Dio _dio;

  ControlService()
    : _dio = Dio(
        BaseOptions(
          // baseUrl: "http://10.0.2.2:5046",
          baseUrl: "http://localhost:5000",
          // baseUrl: "http://localhost:5046",
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          responseType: ResponseType.json,
        ),
      );

  Future<List<String>> getAbsPositions() async {
    try {
      final response = await _dio.get("/positions/absolute");
      print("ESTO LLEGA AL SERVICE DE DART");
      print(response.data);

      return (response.data as List).map((e) => e?.toString() ?? "0").toList();
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
      print(response.data);

      return (response.data as List).map((e) => e?.toString() ?? "0").toList();
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

  Future<Info> getInfo() async {
    try {
      final response = await _dio.get("/status/info");
      final data = response.data;
      Info info = Info(
        alarm: data[0],
        mode: data[1],
        dummy: data[2],
        edit: data[3],
        emergency: data[4],
        motion: data[5],
        mstb: data[6],
        run: data[7],
        tmmode: data[8],
      );
      return info;
    } catch (e) {
      throw Exception("Error getting info : $e");
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

  Future<String> setFeedrate(int feedrate) async {
    try {
      print("este es el Feedrate: $feedrate");
      final response = await _dio.post("/feedrate?feedrate=$feedrate");

      return response.data;
    } catch (e) {
      throw Exception("Error setting mode : $e");
    }
  }

  Future<String> setRapidTraverse(int rapidTraverse) async {
    try {
      print("este es el Feedrate: $rapidTraverse");
      final response = await _dio.post(
        "/rapid-traverse?rapidTraverse=$rapidTraverse",
      );

      return response.data;
    } catch (e) {
      throw Exception("Error setting mode : $e");
    }
  }

  Future<String> startCycle(bool value) async {
    try {
      // print("este es el MODEEE: $mode");
      final response = await _dio.post("/control/cycle/start?value=$value");

      return response.data;
    } catch (e) {
      throw Exception("Error setting mode : $e");
    }
  }

  Future<String> stopCycle(bool value) async {
    try {
      // print("este es el MODEEE: $mode");
      final response = await _dio.post("/control/cycle/stop?value=$value");

      return response.data;
    } catch (e) {
      throw Exception("Error setting mode : $e");
    }
  }

  Future<String> reset(bool value) async {
    try {
      // print("este es el MODEEE: $mode");
      final response = await _dio.post("/control/reset?value=$value");

      return response.data;
    } catch (e) {
      throw Exception("Error setting mode : $e");
    }
  }

  Future<String> home(bool value) async {
    try {
      // print("este es el MODEEE: $mode");
      final response = await _dio.post("/control/home?value=$value");

      return response.data;
    } catch (e) {
      throw Exception("Error setting mode : $e");
    }
  }

  Future<String> getMainProgram() async {
    try {
      final response = await _dio.get("/program/main");

      return response.data;
    } catch (e) {
      throw Exception("Error getting program : $e");
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
