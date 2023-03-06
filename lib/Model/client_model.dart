class ClientModel {
  String name;
String email;
  String phoneNumber;
  double longitude;
  double latitude;
  String locationName;
  ClientModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.longitude,
    required this.locationName,
    required this.latitude,

  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'longitude': longitude,
      'latitude': latitude,
      'locationName': locationName,

    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
      locationName: map['locationName'] as String,


    );
  }
}