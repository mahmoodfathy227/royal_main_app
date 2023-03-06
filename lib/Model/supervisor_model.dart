class SupervisorModel {

  String name;


  SupervisorModel({
    required this.name,

  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,

    };
  }

  factory SupervisorModel.fromMap(Map<String, dynamic> map) {
    return SupervisorModel(
      name: map['name'] as String,

    );
  }
}