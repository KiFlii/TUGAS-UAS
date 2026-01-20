import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/booking_controller.dart';
import '../models/booking.dart';

class UbahBookingView extends StatelessWidget {
  final BookingController controller = Get.find();
  final Booking booking; // Menerima data booking yang akan diubah

  // Inisialisasi controller untuk TextField
  final idBookingC = TextEditingController();
  final waktuBookingC = TextEditingController();
  final hargaBookingC = TextEditingController();
  final buktiBayarC = TextEditingController();

  UbahBookingView({super.key, required this.booking}) {
    // Mengisi TextField dengan data yang sudah ada saat halaman dibuka
    idBookingC.text = booking.idBooking ?? "";
    waktuBookingC.text = booking.waktuBooking ?? "";
    hargaBookingC.text = booking.hargaBooking ?? "";
    buktiBayarC.text = booking.buktiBayar ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Data Booking")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: idBookingC,
              decoration: const InputDecoration(
                labelText: "ID Booking",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: waktuBookingC,
              decoration: const InputDecoration(
                labelText: "Waktu Booking",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: hargaBookingC,
              decoration: const InputDecoration(
                labelText: "Harga Booking",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: buktiBayarC,
              decoration: const InputDecoration(
                labelText: "Bukti Bayar",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                // Memanggil fungsi updateData di controller
                // Kita mengirimkan booking.id (ID primary key dari DB)
                controller.updateData(
                  booking.id.toString(),
                  Booking(
                    idBooking: idBookingC.text,
                    waktuBooking: waktuBookingC.text,
                    hargaBooking: hargaBookingC.text,
                    buktiBayar: buktiBayarC.text,
                  ),
                );
              },
              child: const Text("UPDATE DATA"),
            ),
          ],
        ),
      ),
    );
  }
}
