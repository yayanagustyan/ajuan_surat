class AjuanModel {
  late String nomor = "";
  late final String jenis;
  late final String nim;
  late final String nama;
  late final String jurusan;
  late final String smester;
  late final String tahun;
  late final String dosen;
  late final String alasan;
  late final String tanggal;
  late final String status;

  AjuanModel({
    required this.jenis,
    required this.nim,
    required this.nama,
    required this.jurusan,
    required this.smester,
    required this.tahun,
    required this.dosen,
    required this.alasan,
    required this.tanggal,
  });

  AjuanModel.fromJson(Map<String, dynamic> json) {
    nomor = json['nomor_surat'].toString();
    jenis = json['jenis'].toString();
    nim = json['nim'].toString();
    nama = json['nama'];
    jurusan = json['jurusan'].toString();
    smester = json['smester'].toString();
    tahun = json['tahun'].toString();
    dosen = json['dosen'].toString();
    alasan = json['alasan'].toString();
    tanggal = json['tanggal_ajuan'].toString();
    status = json['status'].toString();
  }

  static AjuanModel empty() {
    return AjuanModel(
      jenis: "",
      nim: "",
      nama: "",
      jurusan: "",
      smester: "",
      tahun: "",
      dosen: "",
      alasan: "",
      tanggal: "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nomor_surat'] = nomor;
    data['jenis'] = jenis;
    data['nim'] = nim;
    data['nama'] = nama;
    data['jurusan'] = jurusan;
    data['smester'] = smester;
    data['tahun'] = tahun;
    data['dosen'] = dosen;
    data['alasan'] = alasan;
    data['tanggal'] = tanggal;
    data['status'] = status;
    return data;
  }

  static List<AjuanModel> fromJsonList(List list) {
    if (list.isEmpty) return List.empty();
    return list.map((item) => AjuanModel.fromJson(item)).toList();
  }
}
