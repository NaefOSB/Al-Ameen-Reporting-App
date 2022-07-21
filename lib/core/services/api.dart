import 'dart:convert';
import 'dart:io';
import 'package:flutter_app_alameen/Model/server_details_model.dart';
import 'package:flutter_app_alameen/Views/authentication/welcome.dart';
import 'package:flutter_app_alameen/Views/server_details/server_details.dart';
import 'package:flutter_app_alameen/core/services/shared_preferences_service.dart';
import 'package:flutter_app_alameen/core/services/user_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class APIService {
  // static final path = 'http://192.168.1.100:9500';
  // static final path = 'https://5105-178-130-84-239.ngrok.io';
  static String path = '';

  static getPath() async {
    ServerDetailsModel server = await UserStorage().getServerDetails();
    if (server.selectedServer == 'global') {
      path = server.global;
    } else if (server.selectedServer == 'local') {
      path = server.local;
    }
  }

  static signIn(String userName, String password) async {
    try {
      await getPath();
      final String url =
          '$path/api/home/Login?user=$userName&password=$password';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return 'wrongLoginInfo';
      }
    } catch (e) {
      return 'error';
    }
  }

  static signOut() async {
    try {
      await SharedPreferencesService().clearUserInfo();
      Get.offAll(Welcome());
    } catch (e) {}
  }

  static getAccountLevel0() async {
    try {
      await getPath();
      final String url = '$path/api/home/GetAcLev0';
      print(url);
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.get(url, headers: headers);
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  static getAccountSubLevel(String guid) async {
    try {
      await getPath();
      final String url = '$path/api/home/GetAcSub?id=$guid';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.get(url, headers: headers);
      return json.decode(response.body);
    } catch (e) {}
  }

  static getAccountDetails(String id) async {
    try {
      await getPath();
      final url = '$path/api/home/Details?id=$id';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      var res = await http.get(url, headers: headers);
      return json.decode(res.body);
    } catch (e) {}
  }

  static getEmployees() async {
    try {
      await getPath();
      final String url = '$path/api/home/Getcustomer';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {}
  }

  static getCustomerReport({id, firstDate, endDate, currency}) async {
    try {
      await getPath();
      final String url =
          '$path/api/home/CustomerReport?id=$id&first=$firstDate&end=$endDate&Currency=$currency';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {}
  }

  static getCurrency() async {
    try {
      await getPath();
      final String url = '$path/api/home/GetCurrency';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      var res = await http.get(url, headers: headers);
      if (res.statusCode == 200) {
        var list = json.decode(res.body);
        return list as List;
      }
    } catch (e) {
      print('---------');
    }
  }

  static getAccountReport({id, firstDate, endDate, currency}) async {
    try {
      await getPath();
      final String url =
          '$path/api/home/CustomerAccountReport?id=$id&first=$firstDate&end=$endDate&Currency=$currency';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {}
  }

  static getMaterialLevel0() async {
    try {
      await getPath();
      final String url = '$path/api/home/GetMtLev0';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {}
  }

  static getMaterialSubLevel(id) async {
    try {
      await getPath();
      final String url = '$path/api/home/GetMtSub?id=$id';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {}
  }

  static getMaterialDetails(id) async {
    try {
      await getPath();
      final String url = '$path/api/home/MtDetails?id=$id';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.get(url, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {}
  }

  static getMaterialAmount(id) async {
    try {
      await getPath();
      final String url = '$path/api/home/MtDepot?id=$id';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return json.decode(response.body);
      }
    } catch (e) {}
  }

  static getAccountTBook({id, first, end, currency}) async {
    try {
      await getPath();
      final String url =
          '$path/api/home/Report?id=$id&first=$first&end=$end&Currency=$currency';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {}
  }

  static createUser(userGuid, username, password) async {
    try {
      await getPath();
      final String url =
          '$path/api/home/CreateUser?UserGuid=$userGuid&Username=$username&Password=$password';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } catch (e) {}
  }

  static getUsers() async {
    try {
      await getPath();
      final String url = '$path/api/home/GetUsers';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {}
  }

  static changePassword(String userGuid, newPassword) async {
    try {
      await getPath();
      final String url =
          '$path/api/home/ChangePassword?UserGuid=$userGuid&NewPassword=$newPassword';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.post(url, headers: headers);
      return response.statusCode;
    } catch (e) {}
  }
}
