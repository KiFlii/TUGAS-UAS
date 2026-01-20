import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/booking_controller.dart';
import '../models/booking.dart';

class TambahBookingView extends StatelessWidget {
  final BookingController controller = Get.find();

  // Controller untuk menangkap input dari masing-masing TextField
  final idBookingC = TextEditingController();
  final waktuBookingC = TextEditingController();
  final hargaBookingC = TextEditingController();
  final buktiBayarC = TextEditingController();

  TambahBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Data Booking")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: idBookingC,
              decoration: const InputDecoration(
                labelText: "ID Booking",
                hintText: "Masukkan kode booking",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: waktuBookingC,
              decoration: const InputDecoration(
                labelText: "Waktu Booking",
                hintText: "Contoh: 2024-05-20 10:00",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: hargaBookingC,
              decoration: const InputDecoration(
                labelText: "Harga Booking",
                hintText: "Contoh: 50000",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType
                  .number, // Tetap gunakan keyboard angka untuk kenyamanan
            ),
            const SizedBox(height: 15),
            TextField(
              controller: buktiBayarC,
              decoration: const InputDecoration(
                labelText: "Bukti Bayar",
                hintText: "Masukkan nama file atau link bukti",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // Membuat tombol lebar
              ),
              onPressed: () {
                // Validasi sederhana: pastikan tidak ada field yang kosong
                if (idBookingC.text.isNotEmpty &&
                    waktuBookingC.text.isNotEmpty &&
                    hargaBookingC.text.isNotEmpty &&
                    buktiBayarC.text.isNotEmpty) {
                  controller.tambahData(
                    Booking(
                      idBooking: idBookingC.text,
                      waktuBooking: waktuBookingC.text,
                      hargaBooking:
                          hargaBookingC.text, // Langsung kirim sebagai string
                      buktiBayar: buktiBayarC.text,
                    ),
                  );
                } else {
                  Get.snackbar("Peringatan", "Semua field harus diisi!");
                }
              },
              child: const Text("SIMPAN DATA"),
            ),
          ],
        ),
      ),
    );
  }
}
