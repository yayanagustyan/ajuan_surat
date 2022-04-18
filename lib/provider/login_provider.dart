// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dps/network/http.dart';
import 'package:flutter/cupertino.dart';

import '../common/config.dart';
import '../common/helper.dart';
import 'auth/auth.dart';

class LoginProvider extends ChangeNotifier {
  final _serverUrl = getBaseUrl();
  final Dio _dio = dio;

  var _users;
  get dataUsers => _users;
  Future<dynamic> getDataUser(String email, String pass) async {
    _dio.options.headers.addAll(await Auth.instance.getHeaders());
    try {
      var response = await _dio.post(_serverUrl + '/siswa/login',
          data: jsonEncode({"sw_nim": email, "sw_password": pass}));
      final result = response.data;
      return _users = result;
    } catch (error, stacktrace) {
      wLogs(error.toString());
      wLogs(stacktrace.toString());
      return _users;
    }
  }

  Future<dynamic> updateUser(String data) async {
    _dio.options.headers.addAll(await Auth.instance.getHeaders());
    try {
      var response = await _dio.post(_serverUrl + '/siswa/update', data: data);
      final result = response.data;
      return _users = result;
    } catch (error, stacktrace) {
      wLogs(error.toString());
      wLogs(stacktrace.toString());
      return _users;
    }
  }

  Future<dynamic> saveSurat(String data) async {
    _dio.options.headers.addAll(await Auth.instance.getHeaders());
    try {
      var response =
          await _dio.post(_serverUrl + '/siswa/ajuan/save', data: data);
      final result = response.data;
      return _users = result;
    } catch (error, stacktrace) {
      wLogs(error.toString());
      wLogs(stacktrace.toString());
      return _users;
    }
  }

  Future<dynamic> printSurat(String data) async {
    _dio.options.headers.addAll(await Auth.instance.getHeaders());
    try {
      var response =
          await _dio.post(_serverUrl + '/pdf/create/awal', data: data);
      final result = response.data;
      return _users = result;
    } catch (error, stacktrace) {
      wLogs(error.toString());
      wLogs(stacktrace.toString());
      return _users;
    }
  }

  Future<dynamic> getSurat(String data) async {
    _dio.options.headers.addAll(await Auth.instance.getHeaders());
    try {
      var response =
          await _dio.post(_serverUrl + '/siswa/ajuan/list', data: data);
      final result = response.data;
      return _users = result;
    } catch (error, stacktrace) {
      wLogs(error.toString());
      wLogs(stacktrace.toString());
      return _users;
    }
  }

  Future<dynamic> updateSurat(String data) async {
    _dio.options.headers.addAll(await Auth.instance.getHeaders());
    try {
      var response =
          await _dio.post(_serverUrl + '/siswa/ajuan/update', data: data);
      final result = response.data;
      return _users = result;
    } catch (error, stacktrace) {
      wLogs(error.toString());
      wLogs(stacktrace.toString());
      return _users;
    }
  }

  Future<dynamic> getInbox(String data) async {
    _dio.options.headers.addAll(await Auth.instance.getHeaders());
    try {
      var response = await _dio.post(_serverUrl + '/siswa/inbox', data: data);
      final result = response.data;
      return _users = result;
    } catch (error, stacktrace) {
      wLogs(error.toString());
      wLogs(stacktrace.toString());
      return _users;
    }
  }

  Future<dynamic> getOutbox(String data) async {
    _dio.options.headers.addAll(await Auth.instance.getHeaders());
    try {
      var response = await _dio.post(_serverUrl + '/siswa/outbox', data: data);
      final result = response.data;
      return _users = result;
    } catch (error, stacktrace) {
      wLogs(error.toString());
      wLogs(stacktrace.toString());
      return _users;
    }
  }

//end
}
