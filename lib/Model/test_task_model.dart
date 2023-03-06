class TestTaskModel {

  String clientName;
  String assignToName;
  String fromDate;
  String toDate;
  String fromTime;
  String toTime;
  String description;
  String locationName;
  double latitude;
  double longitude;
  String employee_email;
  String client_phoneNumber;
  String reason_of_visit;
  String rep_sales_descroption;

  bool isDone;

  TestTaskModel({
    required this.clientName,
    required this.assignToName,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.description,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.employee_email,
    required this.client_phoneNumber,
    required this.isDone,
    required this.reason_of_visit,
    required this.rep_sales_descroption,

  });

  Map<String, dynamic> toMap() {
    return {
      'client_name': clientName,
      'assign_to_name': assignToName,
      'from_date': fromDate,
      'to_date': toDate,
      'from_time': fromTime,
      'to_time': toTime,
      'employee_email': employee_email,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'locationName': locationName,
      'client_phoneNumber': client_phoneNumber,
      'isDone': isDone,
      'reason_of_visit': reason_of_visit,
      'rep_sales_descroption': rep_sales_descroption

    };
  }

  factory TestTaskModel.fromMap(Map<String, dynamic> Map) {
    return TestTaskModel(
      clientName: Map['client_name'] as String,
      assignToName: Map['assign_to_name'] as String,
      fromDate: Map['from_date'] as String,
      toDate: Map['to_date'] as String,
      fromTime: Map['from_time'] as String,
      toTime: Map['to_time'] as String,
      description: Map['description'] as String,
      locationName :Map['locationName'] as String,
      latitude : Map['latitude'] as double,
      longitude : Map['longitude'] as double,
      employee_email: Map['employee_email'] as String,
      client_phoneNumber: Map['client_phoneNumber'] as String,
      isDone: Map['isDone'] as bool,
      reason_of_visit: Map['reason_of_visit'] as String,
      rep_sales_descroption: Map['rep_sales_descroption'] as String,

    );
  }
}