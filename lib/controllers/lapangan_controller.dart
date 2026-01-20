import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/lapangan.dart'; // Pastikan Anda membuat file model ini

class LapanganController extends GetxController {
  var lapanganList = <Lapangan>[].obs;

  // URL API (Gunakan 127.0.0.1 untuk Chrome, 10.0.2.2 untuk Emulator)
  final String url = "http://127.0.0.1:8000/api/lapangan";

  @override
  void onInit() {
    ambilData();
    super.onInit();
  }

  // 1. Ambil Data (GET)
  Future<void> ambilData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        lapanganList.assignAll(data.map((e) => Lapangan.fromJson(e)).toList());
      }
    } catch (e) {
      print("Error ambil data lapangan: $e");
    }
  }

  // 2. Tambah Data (POST)
  Future<void> tambahData(Lapangan data) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(data.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        await ambilData();
        Get.back();
        Get.snackbar("Sukses", "Data lapangan berhasil ditambahkan");
      } else {
        Get.snackbar("Gagal", "Error: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak bisa terhubung ke server");
    }
  }

  // 3. Update Data (PUT)
  Future<void> updateData(String id, Lapangan data) async {
    if (id == "null" || id.isEmpty) {
      Get.snackbar("Error", "ID Lapangan tidak valid");
      return;
    }

    try {
      final response = await http.put(
        Uri.parse("$url/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data.toJson()),
      );

      if (response.statusCode == 200) {
        await ambilData();
        Get.back();
        Get.snackbar("Sukses", "Data lapangan berhasil diperbarui");
      }
    } catch (e) {
      print("Error Update: $e");
    }
  }

  // 4. Hapus Data (DELETE)
  Future<void> hapusData(String id) async {
    if (id == "null" || id.isEmpty) {
      Get.snackbar("Error", "ID Lapangan tidak ditemukan");
      return;
    }

    try {
      final response = await http.delete(Uri.parse("$url/$id"));
      if (response.statusCode == 200 || response.statusCode == 204) {
        await ambilData();
        Get.snackbar("Sukses", "Data lapangan berhasil dihapus");
      }
    } catch (e) {
      print("Error Hapus: $e");
    }
  }
}
