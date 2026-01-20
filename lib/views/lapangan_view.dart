import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lapangan_controller.dart';
import '../models/lapangan.dart';

class LapanganView extends StatelessWidget {
  final LapanganController controller = Get.put(LapanganController());

  LapanganView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Lapangan"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.ambilData(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.lapanganList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.stadium, size: 60, color: Colors.grey),
                const Text("Belum ada data lapangan."),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => controller.ambilData(),
                  child: const Text("Refresh"),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.lapanganList.length,
          itemBuilder: (context, index) {
            final lp = controller.lapanganList[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text(lp.namaLapangan ?? "Tanpa Nama"),
                subtitle: Text("Jadwal: ${lp.jadwal ?? 'Belum diatur'}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _bukaForm(lapangan: lp),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _konfirmasiHapus(lp),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bukaForm(),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _bukaForm({Lapangan? lapangan}) {
    bool isEdit = lapangan != null;

    // Menyesuaikan Controller dengan field table lapangan
    final idC = TextEditingController(text: isEdit ? lapangan.idLapangan : "");
    final namaC = TextEditingController(
      text: isEdit ? lapangan.namaLapangan : "",
    );
    final alamatC = TextEditingController(text: isEdit ? lapangan.alamat : "");
    final jadwalC = TextEditingController(text: isEdit ? lapangan.jadwal : "");

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isEdit ? "Edit Lapangan" : "Tambah Lapangan",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: idC,
                decoration: const InputDecoration(labelText: "ID Lapangan"),
                enabled: !isEdit, // ID tidak boleh diubah saat edit
              ),
              TextField(
                controller: namaC,
                decoration: const InputDecoration(labelText: "Nama Lapangan"),
              ),
              TextField(
                controller: alamatC,
                decoration: const InputDecoration(labelText: "Alamat"),
              ),
              TextField(
                controller: jadwalC,
                decoration: const InputDecoration(
                  labelText: "Jadwal (Contoh: 08:00 - 22:00)",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () {
                  Lapangan data = Lapangan(
                    idLapangan: idC.text,
                    namaLapangan: namaC.text,
                    alamat: alamatC.text,
                    jadwal: jadwalC.text,
                  );

                  if (isEdit) {
                    // Menggunakan data.id yang merupakan mapping dari id_lapangan di model
                    controller.updateData(lapangan.id ?? "", data);
                  } else {
                    controller.tambahData(data);
                  }
                },
                child: Text(
                  isEdit ? "Update" : "Simpan",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _konfirmasiHapus(Lapangan lp) {
    Get.defaultDialog(
      title: "Hapus",
      middleText: "Yakin hapus lapangan ${lp.namaLapangan}?",
      textConfirm: "Ya",
      textCancel: "Tidak",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        // Menggunakan lp.id yang berisi id_lapangan dari database
        controller.hapusData(lp.id ?? "");
        Get.back();
      },
    );
  }
}
