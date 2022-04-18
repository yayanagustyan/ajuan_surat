import 'dart:convert';

import 'helper.dart';

// String envy = 'dev';
String envy = 'prod';

getEnvy() {
  return envy;
}

String username = "android";
String password = "android-keys";

String getBaseUrl() {
  if (envy == 'dev') {
    return "http://192.168.1.101/app_project/kuliah/dps/api";
  } else {
    return "https://dps.mookaps.com/api";
  }
}

Future<String> getApiKey() async {
  var s = await openSession();
  return s.get("map_api_key");
}

String getBasicAuth() {
  return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
}

String getBase64Encode(String source) {
  return 'Basic ' + base64Encode(utf8.encode(source));
}
