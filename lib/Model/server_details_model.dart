class ServerDetailsModel {
  String global;
  String local;
  String selectedServer;

  ServerDetailsModel({this.global, this.local, this.selectedServer});

  ServerDetailsModel.fromJson(Map<String, dynamic> map) {
    if (map == null) return;

    global = map['global'];
    local = map['local'];
    selectedServer = map['selectedServer'];
  }

  toJson() {
    return {'global': global, 'local': local, 'selectedServer': selectedServer};
  }
}
