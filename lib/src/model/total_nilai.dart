// ignore_for_file: deprecated_member_use

class TotalNilai {
  int id;
  String title;
  String durasi;
  String tanggal;
  String totalTryout;
  String namaJenjang;
  int nilaiMatpel;
  String namaMatpel;
  int jumlahSoalMatpel;
  int totalBenarMatpel;
  int totalSalahMatpel;
  int nilai;
  int totalSoal;
  int totalBenar;
  int totalSalah;
  int belumDikerjakan;
  int sudahSelesai;
  String metodePembayaran;
  String jumlahBayar;
  String batasWaktu;
  bool statusTryout;
  int idPaket;
  int idJenjang;
  int idSekolahTujuan;
  TotalNilai(
      {this.id,
      this.title,
      this.durasi,
      this.tanggal,
      this.totalTryout,
      this.namaJenjang,
      this.nilaiMatpel,
      this.namaMatpel,
      this.jumlahSoalMatpel,
      this.totalBenarMatpel,
      this.totalSalahMatpel,
      this.nilai,
      this.totalSoal,
      this.totalBenar,
      this.totalSalah,
      this.belumDikerjakan,
      this.sudahSelesai,
      this.metodePembayaran,
      this.jumlahBayar,
      this.batasWaktu,
      this.statusTryout,
      this.idPaket,
      this.idJenjang,
      this.idSekolahTujuan,});
}

class TotalNilaiModel {
  bool isloading = false;
  bool isSuccess = false;
  List<TotalNilai> pakets = new List<TotalNilai>();
}
