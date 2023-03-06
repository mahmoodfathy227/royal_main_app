class UserModel {

  String first_name;
  String last_name;
  // String address;
  String phone_number;
  String email;
  // String password;
  String user_role;
  String user_type;
  bool agreed_or_not;

  UserModel({
    required this.first_name,
    required this.last_name,
    // required this.address,
    required this.phone_number,
    required this.email,
    // required this.password,
    required this.user_role,
    required this.user_type,
    required this.agreed_or_not,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      // 'address': address,
      'phone_number': phone_number,
      'email': email,
      // 'password': password,
      'user_role': user_role,
      'user_type': user_type,
      'agreed_or_not': agreed_or_not,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      // address: map['address'] as String,
      phone_number: map['phone_number'] as String,
      email: map['email'] as String,
      // password: map['password'] as String,
      user_role: map['user_role'] as String,
      user_type: map['user_type'] as String,
      agreed_or_not: map['agreed_or_not'] as bool,
    );
  }
}