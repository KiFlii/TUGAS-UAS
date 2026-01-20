import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/booking.dart';

class BookingController extends GetxController {
  var bookingList = <Booking>[].obs;

  // IP 10.0.2.2 untuk Android Emulator akses localhost Laptop
  final String url = "http://127.0.0.1:8000/api/booking";

  @override
  void onInit() {
    ambilData();
    super.onInit();
  }

  Future<void> ambilData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        bookingList.assignAll(data.map((e) => Booking.fromJson(e)).toList());
      }
    } catch (e) {
      print("Error ambil data: $e");
    }
  }

  Future<void> tambahData(Booking data) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(data.toJson()),
      );

      // Sesuai dengan hasil Postman Anda yang 201
      if (response.statusCode == 201 || response.statusCode == 200) {
        await ambilData();
        Get.back();
        Get.snackbar("Sukses", "Data Booking berhasil ditambahkan");
      } else {
        print("Gagal: ${response.body}");
        Get.snackbar("Gagal", "Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Tidak bisa terhubung ke server");
    }
  }

  Future<void> updateData(String id, Booking data) async {
    // Validasi agar tidak mengirim URL null
    if (id == "null" || id.isEmpty) {
      Get.snackbar("Error", "ID data tidak ditemukan (null)");
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
        Get.snackbar("Sukses", "Data berhasil diupdate");
      }
    } catch (e) {
      print("Error Update: $e");
    }
  }

  Future<void> hapusData(String id) async {
    if (id == "null" || id.isEmpty) {
      Get.snackbar("Error", "ID data tidak ditemukan (null)");
      return;
    }

    try {
      final response = await http.delete(Uri.parse("$url/$id"));
      if (response.statusCode == 200) {
        await ambilData();
        Get.snackbar("Sukses", "Data berhasil dihapus");
      }
    } catch (e) {
      print("Error Hapus: $e");
    }
  }
}
