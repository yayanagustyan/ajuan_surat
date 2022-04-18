class InboxModel {
  late final String ajuId;
  late final String ajuCode;
  late final String ajuTipe;
  late final String ajuDatetime;
  late final String ajuNim;
  late final String ajuNama;
  late final String ajuJurusan;
  late final String ajuSmester;
  late final String ajuTahun;
  late final String ajuDosen;
  late final String ajuPhone;
  late final String ajuEmail;
  late final String ajuJenis;
  late final String ajuAlasan;
  late final String ajuStatus;
  late final String ajuAccReject;
  late final String ajuFile;
  late final String ajuNomorSurat;

  InboxModel({
    required this.ajuId,
    required this.ajuCode,
    required this.ajuTipe,
    required this.ajuDatetime,
    required this.ajuNim,
    required this.ajuNama,
    required this.ajuJurusan,
    required this.ajuSmester,
    required this.ajuTahun,
    required this.ajuPhone,
    required this.ajuEmail,
    required this.ajuDosen,
    required this.ajuJenis,
    required this.ajuAlasan,
    required this.ajuStatus,
    required this.ajuAccReject,
    required this.ajuFile,
    required this.ajuNomorSurat,
  });

  InboxModel.fromJson(Map<String, dynamic> json) {
    ajuId = json['aju_id'].toString();
    ajuCode = json['aju_code'].toString();
    ajuTipe = json['aju_tipe'].toString();
    ajuDatetime = json['aju_datetime'].toString();
    ajuNim = json['aju_nim'].toString();
    ajuNama = json['aju_nama'].toString();
    ajuJurusan = json['aju_jurusan'].toString();
    ajuSmester = json['aju_smester'].toString();
    ajuTahun = json['aju_tahun'].toString();
    ajuPhone = json['aju_phone'].toString();
    ajuEmail = json['aju_email'].toString();
    ajuDosen = json['aju_dosen'].toString();
    ajuJenis = json['aju_jenis'].toString();
    ajuAlasan = json['aju_alasan'].toString();
    ajuStatus = json['aju_status'].toString();
    ajuAccReject = json['aju_acc_reject'].toString();
    ajuFile = json['aju_file'].toString();
    ajuNomorSurat = json['aju_nomor_surat'].toString();
  }

  static InboxModel empty() {
    return InboxModel(
      ajuId: "",
      ajuCode: "",
      ajuTipe: "",
      ajuDatetime: "",
      ajuNim: "",
      ajuNama: "",
      ajuJurusan: "",
      ajuSmester: "",
      ajuTahun: "",
      ajuPhone: "",
      ajuEmail: "",
      ajuDosen: "",
      ajuJenis: "",
      ajuAlasan: "",
      ajuStatus: "",
      ajuAccReject: "",
      ajuFile: "",
      ajuNomorSurat: "",
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['aju_id'] = ajuId;
    _data['aju_code'] = ajuCode;
    _data['aju_tipe'] = ajuTipe;
    _data['aju_datetime'] = ajuDatetime;
    _data['aju_nim'] = ajuNim;
    _data['aju_nama'] = ajuNama;
    _data['aju_jurusan'] = ajuJurusan;
    _data['aju_smester'] = ajuSmester;
    _data['aju_tahun'] = ajuSmester;
    _data['aju_phone'] = ajuPhone;
    _data['aju_email'] = ajuEmail;
    _data['aju_dosen'] = ajuDosen;
    _data['aju_jenis'] = ajuJenis;
    _data['aju_alasan'] = ajuAlasan;
    _data['aju_status'] = ajuStatus;
    _data['aju_acc_reject'] = ajuAccReject;
    _data['aju_file'] = ajuFile;
    _data['aju_nomor_surat'] = ajuNomorSurat;
    return _data;
  }

  static List<InboxModel> fromJsonList(List list) {
    if (list.isEmpty) return List.empty();
    return list.map((item) => InboxModel.fromJson(item)).toList();
  }
}
