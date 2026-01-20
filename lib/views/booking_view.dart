import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/booking_controller.dart';
import 'tambah_booking.dart'; // Pastikan Anda membuat file ini nanti
import 'ubah_booking.dart'; // Pastikan Anda membuat file ini nanti

class BookingView extends StatelessWidget {
  final BookingController controller = Get.put(BookingController());

  BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Booking"), centerTitle: true),
      body: Obx(() {
        // Jika data sedang kosong
        if (controller.bookingList.isEmpty) {
          return const Center(child: Text("Tidak ada data booking"));
        }

        return ListView.builder(
          itemCount: controller.bookingList.length,
          itemBuilder: (context, index) {
            var booking = controller.bookingList[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.confirmation_number),
                ),
                title: Text("${booking.idBooking} - ${booking.waktuBooking}"),
                subtitle: Text("Harga: Rp ${booking.hargaBooking}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tombol Edit
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () =>
                          Get.to(() => UbahBookingView(booking: booking)),
                    ),
                    // Tombol Hapus
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Hapus Data",
                          middleText: "Yakin ingin menghapus booking ini?",
                          onConfirm: () {
                            controller.hapusData(booking.id.toString());
                            Get.back();
                          },
                          textConfirm: "Ya",
                          textCancel: "Batal",
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => TambahBookingView()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
