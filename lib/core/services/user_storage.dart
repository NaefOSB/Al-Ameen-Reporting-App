import 'package:flutter_app_alameen/Model/server_details_model.dart';
import 'package:get_storage/get_storage.dart';

class UserStorage {
  static GetStorage _getStorage;

  factory UserStorage() => UserStorage._internal();

  UserStorage._internal();

  init() {
    _getStorage ??= GetStorage();
  }

  String read(String key) {
    return _getStorage?.read(key);
  }

  void write(String key, dynamic value) {
    _getStorage.write(key, value);
  }

  setServerDetails(ServerDetailsModel server) async {
    await init();
    write('local', server.local);
    write('global', server.global);
    write('selectedServer', server.selectedServer);
  }

  Future<ServerDetailsModel> getServerDetails() async {
    await init();
    String local = read('local');
    String global = read('global');
    String selectedServer = read('selectedServer');
    ServerDetailsModel server = ServerDetailsModel(
        local: local, global: global, selectedServer: selectedServer);
    return server;
  }

  void clearAll() async {
    await init();
    await _getStorage.erase();
  }
}
