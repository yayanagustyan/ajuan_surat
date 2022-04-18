import 'dart:convert';
import 'dart:developer' as d;
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:dps/common/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

String toAlias(int source) {
  return alpha[source];
}

String toFirstCaps(String words) {
  if (words.isNotEmpty) {
    return '${words[0].toUpperCase()}${words.substring(1).toLowerCase()}';
  } else {
    return words;
  }
}

String allInCaps(String value) => value.toUpperCase();

String capitalizeFirstofEach(String value) {
  List<String> words = value.split(" ");
  if (words.length > 1) {
    String combine = words[0] + words[1];
    if (combine.toLowerCase() == "dkijakarta" ||
        combine.toLowerCase() == "diyogyakarta") {
      return '${words[0].toUpperCase()} ' + toFirstCaps(words[1]);
    }
  }
  return value.split(" ").map((str) => toFirstCaps(str)).join(" ");
}

String getUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

int getUniqInt() {
  var random = Random();
  return random.nextInt(pow(2, 31).toInt() - 1);
}

String getCurrentDate() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd', 'id_ID');
  return formatter.format(now);
}

String getCurrentTime() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('HH:mm', 'id_ID');
  return formatter.format(now);
}

String getCurrentDateTime() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss', 'id_ID');
  return formatter.format(now);
}

String getCurrentChatTime() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('dd MMM, HH:mm', 'id_ID');
  return formatter.format(now);
}

int dateDiff(String startDate, String endDate) {
  DateTime date1 = DateTime.parse(startDate);
  DateTime date2;
  if (endDate.isEmpty) {
    date2 = DateTime.now();
  } else {
    date2 = DateTime.parse(endDate);
  }
  final difference = date2.difference(date1).inDays;
  return difference;
}

int timeDiff(String startDate, String endDate) {
  DateTime date1 = DateTime.parse(startDate);
  DateTime date2;
  if (endDate.isEmpty) {
    date2 = DateTime.now();
  } else {
    date2 = DateTime.parse(endDate);
  }
  final difference = date2.difference(date1).inMilliseconds;
  return difference;
}

String dateFormat(String date, String patern) {
  final ff = DateFormat('yyyy-MM-dd', 'id_ID');
  DateTime dates = ff.parse(date);
  DateFormat formatter = DateFormat(patern, 'id_ID');
  return formatter.format(dates);
}

String dateTimeFormat(String date, String patern) {
  final ff = DateFormat('yyyy-MM-dd hh:mm:ss', 'id_ID');
  DateTime dates = ff.parse(date);
  DateFormat formatter = DateFormat(patern, 'id_ID');
  return formatter.format(dates);
}

String dateToString(DateTime date, String patern) {
  DateFormat formatter = DateFormat(patern, 'id_ID');
  return formatter.format(date);
}

DateTime stringToDate(String date) {
  DateTime newdate = DateTime.parse(date);
  return newdate;
}

String nF(String source, {bool symbol = false, bool denom = false}) {
  if (denom) {
    var dd = double.parse(source);
    double be = dd / 1000;
    String sb = "K";
    if (dd >= 1000000000) {
      be = dd / 1000000;
      sb = "M";
    } else if (dd >= 1000000) {
      be = dd / 1000;
      sb = "K";
    } else if (dd >= 1000) {
      be = dd / 1000;
      sb = "K";
    }
    return (symbol ? "Rp. " : "") +
        NumberFormat.decimalPattern().format(be.ceil()) +
        " $sb";
  } else {
    return (symbol ? "Rp. " : "") +
        NumberFormat.decimalPattern().format(double.parse(source));
  }
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

String getInitials(String words) {
  if (words.isNotEmpty) {
    return words.trim().split(' ').map((l) => l[0]).take(2).join();
  } else {
    return '';
  }
}

String getFirstName(String words) {
  if (words.isNotEmpty) {
    return words.trim().split(' ')[0];
  } else {
    return '';
  }
}

String getFirstSecondName(String words) {
  String newName = '';
  if (words.isNotEmpty) {
    List<String> name = words.trim().split(' ');
    if (name.length > 1) {
      newName = words.trim().split(' ')[0] + " " + words.trim().split(' ')[1];
    } else {
      newName = words.trim().split(' ')[0];
    }
  }
  return newName.replaceAll(",", "");
}

String getGreeting(String name) {
  var message = '';
  DateTime date = DateTime.now();
  var timeNow = int.parse(DateFormat('kk').format(date));
  if (timeNow <= 12) {
    message = 'Selamat Pagi, ';
  } else if ((timeNow > 12) && (timeNow <= 16)) {
    message = 'Selamat Siang, ';
  } else if ((timeNow > 16) && (timeNow <= 20)) {
    message = 'Selamat Sore, ';
  } else {
    message = 'Selamat Malam, ';
  }
  return message + name;
}

String utf8convert(String text) {
  var encode = utf8.encode(text);
  return utf8.decode(encode);
}

String stringWithNewLine(List readLines) {
  StringBuffer sb = StringBuffer();
  for (String line in readLines) {
    sb.write(line + "\n");
  }
  return sb.toString();
}

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

Future updateCookies(List<dynamic> value, String keys) async {
  List<String> myList = value.map((e) => json.encode(e)).toList();
  var login = await Hive.openBox("session");
  login.put(keys, myList);
}

Future updateSingleCookies(dynamic _value, String keys) async {
  var login = await Hive.openBox("login");
  final result = login.put(keys, _value);
  result.then((value) {});
}

Future<String> getCookies(String key) async {
  var login = await Hive.openBox("login");
  final result = login.get(key);
  return result;
}

Future<Box<dynamic>> openSession() async {
  var session = await Hive.openBox("session");
  return session;
}

removeFocus(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode()); //remove focus
}

wLogs(dynamic message) {
  d.log(message.toString(), time: DateTime.now());
}

String addSpaceWord(String value, {String group = "3"}) {
  return value.replaceAllMapped(
      RegExp(r".{" + group + "}"), (match) => "${match.group(0)} ");
}
