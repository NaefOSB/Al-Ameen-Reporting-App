class Users{

  int id;
  String user;
  String password;

  Users({this.id,this.user, this.password});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id??0;
    data['user'] = this.user;
    data['Password'] = this.password;
    return data;
  }
}