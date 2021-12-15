import 'dart:convert';
import '../API.dart';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  final int id;
  String email, full_name;
  String? city, province, zip_code, phone_num, address;
  final DateTime created_at;
  final DateTime? modified_at;
  bool enabled;
  static User? currentUser;
  static List<User> users = [];

  User(
      {required this.id,
      required this.email,
      required this.full_name,
      this.city,
      this.province,
      this.phone_num,
      this.address,
      this.zip_code,
      required this.enabled,
      required this.created_at,
      this.modified_at});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      full_name: json['full_name'],
      city: json['city'],
      province: json['province'],
      phone_num: json['phone_num'],
      address: json['address'],
      zip_code: json['zip_code'],
      enabled: json["enabled"] == 1,
      created_at: DateTime.parse(json['created_at']),
      modified_at: DateTime.parse(json['modified_at']),
    );
  }

  static fromJsonString(String x) =>
      new List<User>.from(json.decode(x).map((j) => User.fromJson(j)).toList());

  static Map<String, dynamic> currentUsertoJson() => {
        "id": currentUser?.id,
        "email": currentUser?.email,
        "full_name": currentUser?.full_name,
        "created_at": currentUser?.created_at.toIso8601String(),
        "modified_at": currentUser?.modified_at?.toIso8601String(),
        "enabled": currentUser?.enabled,
        "city": currentUser?.city,
        "province": currentUser?.province,
        "zip_code": currentUser?.zip_code,
        "phone_num": currentUser?.phone_num,
        "address": currentUser?.address
      };

  static Future<List<User>> getAll() async {
  try {
    var x = await apiRequest("v1/users", "GET");
    x = User.fromJsonString(x);
    User.users = x;
    return x;
  } catch (e) {
    print(e);
    throw e;
  }
}

Future<void> getById(id) async {
  try {
    var x = await apiRequest("v1/user/$id", "GET");
    x = User.fromJsonString(x);
    return x;
  } catch (e) {
    print(e);
    return null;
  }
}

static Future<void> update(id,body) async {
  try {
    var x = await apiRequest("v1/user/$id", "POST",body:body);
    return x;
  } catch (e) {
    print(e);
    throw e;
  }
}

static Future<void> delete(id) async {
  try {
    var x = await apiRequest("v1/user/$id", "DELETE");
    return x;
  } catch (e) {
    print(e);
    throw e;
  }
}
}



String jsonUsers =
    '[{"id":2,"email":"rakazhp@gmail.com","full_name":"Muhammad Raka Zuhdi","city":"Jakarta Barat","province":"DKI Jakarta","phone_num":"11212","address":"Pieva 021","zip_code":"12440","enabled":1,"created_at":"2021-02-24T03:13:53.000Z","modified_at":"2021-09-17T04:04:06.000Z"},{"id":4,"email":"thunkank@gmail.com","full_name":"Fyodor","city":"Badung","province":"Bali","phone_num":"23424","address":"Jl.jalan no 10","zip_code":"20012","enabled":1,"created_at":"2021-01-19T01:44:00.000Z","modified_at":"2021-01-19T01:46:08.000Z"},{"id":5,"email":"rakazhp1@gmail.com","full_name":"Raka Zuhdi","city":"Jakarta Selatan","province":"DKI Jakarta","phone_num":"2341112","address":"JL. Karang Tengah Raya, Pieva Townhouse, No. 21","zip_code":"12440","enabled":1,"created_at":"2021-01-07T07:51:57.000Z","modified_at":"2021-01-04T02:50:54.000Z"},{"id":8,"email":"eka.valentino@gmail.com","full_name":"Timotius Eka V","city":"Tangerang","province":"Banten","phone_num":"123","address":"Royal 2 Jl. SIngos","zip_code":"15141","enabled":1,"created_at":"2021-01-07T07:52:18.000Z","modified_at":"2021-01-05T08:20:24.000Z"},{"id":9,"email":"eka.valentino+a@gmail.com","full_name":"Timotius Eka V","city":"Serang","province":"Banten","phone_num":"456","address":"Royal 2 Jl. SIngos","zip_code":"15141","enabled":1,"created_at":"2021-01-07T07:52:20.000Z","modified_at":"2021-01-05T08:24:32.000Z"},{"id":10,"email":"eka.valentino+xyz@gmail.com","full_name":"Timotius Eka V","city":"Bengkulu Utara","province":"Bengkulu","phone_num":"789","address":"Royal 2 Jl. SIngos","zip_code":"15141","enabled":1,"created_at":"2021-01-07T07:52:24.000Z","modified_at":"2021-01-05T08:25:13.000Z"},{"id":11,"email":"eka.valentino+xyzv@gmail.com","full_name":"Timotius Eka V","city":"Pandeglang","province":"Banten","phone_num":"101112","address":"Royal 2 Jl. SIngos","zip_code":"15141","enabled":1,"created_at":"2021-01-07T07:52:28.000Z","modified_at":"2021-01-05T08:40:24.000Z"},{"id":12,"email":"fix@fix.com","full_name":"fixer","phone_num":"131415","enabled":1,"created_at":"2021-01-07T07:52:31.000Z","modified_at":"2021-01-05T09:01:33.000Z"},{"id":13,"email":"eka.valentino+123@gmail.com","full_name":"Timotius Eka V","city":"Serang","province":"Banten","phone_num":"2351","address":"Royal 2 Jl. SIngos","zip_code":"15141","enabled":1,"created_at":"2021-01-07T07:52:41.000Z","modified_at":"2021-01-05T09:02:05.000Z"},{"id":14,"email":"timotiusek@gmail.com","full_name":"Timotius","city":"Tangerang","province":"Banten","phone_num":"08219448","address":"Royal","zip_code":"15141","enabled":1,"created_at":"2021-01-07T07:52:50.000Z","modified_at":"2021-01-05T09:10:39.000Z"},{"id":15,"email":"eka.valentino+oppa@gmail.com","full_name":"Tim","city":"Tangerang","province":"Banten","phone_num":"081912999333","address":"Royal 2 Jl Singosari Raya no 55B","zip_code":"15141","enabled":1,"created_at":"2021-01-07T08:57:09.000Z","modified_at":"2021-01-07T08:57:09.000Z"},{"id":16,"email":"adiputrawilbert@gmail.com","full_name":"Wilbert Adiputra","city":"Tangerang","province":"Banten","phone_num":"085921425544","address":"Pondok Hijau Golf No 28","zip_code":"15141","enabled":1,"created_at":"2021-01-08T07:16:07.000Z","modified_at":"2021-01-12T07:10:09.000Z"},{"id":17,"email":"rakathekid17@gmail.com","full_name":"Raka Zuhdi","city":"Jakarta Selatan","province":"DKI Jakarta","phone_num":"+6281311108120","address":"Pieva Townhouse 21","zip_code":"12440","enabled":1,"created_at":"2021-01-13T10:32:12.000Z","modified_at":"2021-01-12T06:05:08.000Z"},{"id":18,"email":"adiputrawilbert+demo@gmail.com","full_name":"Wilbert A","city":"Tangerang Selatan","province":"Banten","phone_num":"08123156456","address":"Prominence Tower Lt 20","zip_code":"12345","enabled":1,"created_at":"2021-01-12T08:33:54.000Z","modified_at":"2021-01-12T08:33:54.000Z"},{"id":19,"email":"rakathekid18@gmail.com","full_name":"Raka Zuhdi 2","city":"Jakarta Selatan","province":"DKI Jakarta","phone_num":"+6281311108120","address":"Pieva 21","zip_code":"12440","enabled":1,"created_at":"2021-01-18T10:55:40.000Z","modified_at":"2021-01-18T10:55:40.000Z"},{"id":20,"email":"gundam@vendor.com","full_name":"Raka Zuhdi","city":"Bangli","province":"Bali","phone_num":"081311108120","address":"JL. Karang Tengah Raya, Pieva Townhouse, No. 21","zip_code":"12440","enabled":1,"created_at":"2021-01-20T09:38:15.000Z","modified_at":"2021-01-20T09:38:15.000Z"},{"id":21,"email":"ericasutandi10@gmail.com","full_name":"Erica Sutandi","city":"Tangerang","province":"Banten","phone_num":"087772107998","address":"Gading Serpong","zip_code":"15810","enabled":1,"created_at":"2021-01-21T07:02:30.000Z","modified_at":"2021-01-21T07:02:30.000Z"},{"id":22,"email":"garilletasmara@gmail.com","full_name":"Garille Tasmara","city":"Jakarta Barat","province":"DKI Jakarta","phone_num":"08119898135","address":"citra 1","zip_code":"11840","enabled":1,"created_at":"2021-01-21T07:08:33.000Z","modified_at":"2021-01-21T07:08:33.000Z"},{"id":23,"email":"garille_t@yahoo.com","full_name":"Garille","city":"Jakarta Barat","province":"DKI Jakarta","phone_num":"08119898135","address":"Citra Garden","zip_code":"11840","enabled":1,"created_at":"2021-01-21T16:17:05.000Z","modified_at":"2021-01-21T16:17:05.000Z"},{"id":24,"email":"rakathekid20@gmail.com","full_name":"raka zuhdi ","city":"Jakarta Selatan","province":"DKI Jakarta","phone_num":"081311108120","address":"JL. Karang Tengah Raya, Pieva Townhouse, No. 21","zip_code":"12440","enabled":1,"created_at":"2021-02-26T06:51:30.000Z","modified_at":"2021-02-26T06:51:30.000Z"},{"id":25,"email":"renaldystwn@gmail.com","full_name":"Renaldy Setiawan","city":"Tangerang Selatan","province":"Banten","phone_num":"081383798649","address":"Jl blablabla","zip_code":"15326","enabled":1,"created_at":"2021-07-06T06:23:36.000Z","modified_at":"2021-07-06T06:23:36.000Z"},{"id":26,"email":"eka.valentino+abcde@gmail.com","full_name":"Timotius Eka Valentino","city":"Tangerang","province":"Banten","phone_num":"085159889844","address":"Royal","zip_code":"15141","enabled":1,"created_at":"2021-09-14T09:02:46.000Z","modified_at":"2021-09-14T09:02:46.000Z"}]';
