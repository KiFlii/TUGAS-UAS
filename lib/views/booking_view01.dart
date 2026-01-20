import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/booking_controller.dart';
import 'tambah_booking.dart';
import 'ubah_booking.dart';

class BookingView01 extends StatelessWidget {
  final BookingController controller = Get.put(BookingController());

  BookingView01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Master Booking",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.ambilData(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.bookingList.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.folder_open, size: 80, color: Colors.grey),
                SizedBox(height: 10),
                Text("Belum ada data booking"),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.ambilData(),
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: controller.bookingList.length,
            itemBuilder: (context, index) {
              var item = controller.bookingList[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlpha(
                        25,
                      ), // Mengganti withOpacity yang deprecated
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.receipt_long, color: Colors.blue),
                  ),
                  title: Text(
                    "ID: ${item.idBooking}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Waktu: ${item.waktuBooking}"),
                      Text(
                        "Harga: Rp ${item.hargaBooking}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight:
                              FontWeight.w600, // PERBAIKAN: Tadi tertulis w60
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () =>
                            Get.to(() => UbahBookingView(booking: item)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _konfirmasiHapus(item),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => TambahBookingView()),
        label: const Text("Tambah"),
        icon: const Icon(Icons.add),
      ),
    );
  }

  // lib/views/booking_view01.dart

  void _konfirmasiHapus(dynamic item) {
    print("DEBUG: Menghapus ID Database = ${item.id}"); // Cek console!
    print("DEBUG: Kode Booking = ${item.idBooking}");

    Get.defaultDialog(
      title: "Hapus",
      middleText: "Hapus data ${item.idBooking}?",
      onConfirm: () {
        if (item.id != null) {
          controller.hapusData(item.id.toString());
        } else {
          Get.snackbar("Error", "ID Database Kosong!");
        }
        Get.back();
      },
      textConfirm: "Ya",
      textCancel: "Tidak",
    );
  }
}
