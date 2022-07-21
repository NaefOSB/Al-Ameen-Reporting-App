import 'dart:convert';

import 'package:flutter_app_alameen/Model/server_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences _sharedPrefs;

  factory SharedPreferencesService() => SharedPreferencesService._internal();

  SharedPreferencesService._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String getString(String key) {
    SharedPreferencesService().init();
    return _sharedPrefs?.getString(key);
  }

  int getInt(String key) {
    return _sharedPrefs?.getInt(key);
  }

  Future<bool> setString(String key, String value) async {
    try {
      await init();
      await _sharedPrefs.setString(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setBool(String key, bool value) async {
    try {
      await init();
      await _sharedPrefs.setBool(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool getBool(String key) {
    return _sharedPrefs?.getBool(key);
  }

  setUserData(
      String userName, String userGuid, String guid, bool isAdmin) async {
    await SharedPreferencesService().init();
    setString('userName', '$userName');
    setString('userGuid', '$userGuid');
    setString('guid', '$guid');
    setBool('isAdmin', isAdmin);
    return true;
  }

  Future<bool> setInt(String key, int value) async {
    try {
      await _sharedPrefs.setInt(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  getUserInfo() async {
    List<dynamic> userInfo = List<dynamic>();
    await SharedPreferencesService().init();
    String userName = getString('userName');
    String userGuid = getString('userGuid');
    String guid = getString('guid');
    bool isAdmin = getBool('isAdmin');
    if (userName != null) userInfo.add(userName);
    if (userGuid != null) userInfo.add(userGuid);
    if (guid != null) userInfo.add(guid);
    if (isAdmin != null) userInfo.add(isAdmin);
    return userInfo;
  }

  setServerDetails({ServerDetailsModel serverDetails}) async {
    await SharedPreferencesService().init();
    setString('local', serverDetails.local);
    setString('global', serverDetails.global);
    setString('selectedServer', serverDetails.selectedServer);
  }

  ServerDetailsModel getServerDetails() {
    String local = _sharedPrefs.getString('local');
    String global = _sharedPrefs.getString('global');
    String selectedServer = _sharedPrefs.getString('selectedServer');

    return ServerDetailsModel(
        local: local, global: global, selectedServer: selectedServer);
  }

  clearUserInfo() async {
    try {
      await init();
      _sharedPrefs.clear();
    } catch (e) {}
  }
}
