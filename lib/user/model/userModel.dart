class UserModel {
  UserModel({
    required this.gender,
    required this.name,
    required this.email,
    required this.dob,
    required this.phone,
    required this.picture,
    required this.nat,
  });

  String gender;
  String name;
  String email;
  DateTime dob;
  String phone;
  String picture;
  String nat;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    gender: json["gender"],
    name: json["name"]["title"] + '. ' + json["name"]["first"] + ' ' + json["name"]["last"],
    email: json["email"],
    dob: DateTime.parse(json["dob"]["date"]),
    phone: json["phone"],
    picture: json["picture"]["large"],
    nat: json["nat"],
  );
}
