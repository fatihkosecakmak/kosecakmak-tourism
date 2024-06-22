

class UserModel{
  String user_name;
  String email;
  String user_surname;
  String user_id;
  String user_gender;
  String user_password;
  String user_phone;
  String user_uid;
  bool is_disabled;
  String user_date;

  UserModel(
      {required this.user_name,
      required this.email,
      required this.user_surname,
      required this.user_id,
      required this.user_gender,
      required this.user_password,
      required this.user_phone,
      required this.user_uid,
      required this.is_disabled,
      required this.user_date});
  factory UserModel.fromJson(Map<dynamic,dynamic> json,String key){
    return UserModel(
        user_name: json["user_name"],
        email: json["email"],
        user_surname: json["user_surname"],
        user_id: json["user_id"],
        user_gender: json["user_gender"],
        user_password: json["user_password"],
        user_phone: json["user_phone"],
        is_disabled: json["is_disabled"],
        user_date: json["user_date"],
        user_uid: key);
  }
}