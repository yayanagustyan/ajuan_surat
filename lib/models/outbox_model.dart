class OutboxModel {
  late final String obId;
  late final String obFrom;
  late final String obTo;
  late final String obCode;
  late final String obMessage;
  late final String obRead;
  late final String obDate;

  OutboxModel({
    required this.obId,
    required this.obFrom,
    required this.obTo,
    required this.obCode,
    required this.obMessage,
    required this.obRead,
    required this.obDate,
  });

  OutboxModel.fromJson(Map<String, dynamic> json) {
    obId = json['ob_id'].toString();
    obFrom = json['ob_from'].toString();
    obTo = json['ob_to'].toString();
    obCode = json['ob_code'].toString();
    obMessage = json['ob_message'].toString();
    obRead = json['ob_read'].toString();
    obDate = json['ob_date'].toString();
  }

  static OutboxModel empty() {
    return OutboxModel(
      obId: "",
      obFrom: "",
      obTo: "",
      obCode: "",
      obMessage: "",
      obRead: "",
      obDate: "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ob_id'] = obId;
    data['ob_from'] = obFrom;
    data['ob_to'] = obTo;
    data['ob_code'] = obCode;
    data['ob_message'] = obMessage;
    data['ob_read'] = obRead;
    data['ob_date'] = obDate;
    return data;
  }

  static List<OutboxModel> fromJsonList(List list) {
    if (list.isEmpty) return List.empty();
    return list.map((item) => OutboxModel.fromJson(item)).toList();
  }
}
