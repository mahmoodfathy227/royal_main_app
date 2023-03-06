class TaskModel {

  String client_name;
  String assign_to_name;
  String from_date;
  String to_date;
  String from_time;
  String to_time;
  String description;
  String employee_email;
  String location;
  String client_phoneNumber;
  String reason_of_visit;
  String rep_sales_descroption;

  bool isDone;

  TaskModel({
    required this.client_name,
    required this.assign_to_name,
    required this.from_date,
    required this.to_date,
    required this.from_time,
    required this.to_time,
    required this.description,
    required this.employee_email,
    required this.location,
    required this.client_phoneNumber,
    required this.isDone,
    required this.reason_of_visit,
    required this.rep_sales_descroption,

  });

  Map<String, dynamic> toMap() {
    return {
      'client_name': client_name,
      'assign_to_name': assign_to_name,
      'from_date': from_date,
      'to_date': to_date,
      'from_time': from_time,
      'to_time': to_time,
      'description': description,
      'employee_email': employee_email,
      'location': location,
      'client_phoneNumber': client_phoneNumber,
      'isDone': isDone,
      'reason_of_visit': reason_of_visit,
      'rep_sales_descroption': rep_sales_descroption

    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> Map) {
    return TaskModel(
      client_name: Map['client_name'] as String,
      assign_to_name: Map['assign_to_name'] as String,
      from_date: Map['from_date'] as String,
      to_date: Map['to_date'] as String,
      from_time: Map['from_time'] as String,
      to_time: Map['to_time'] as String,
      description: Map['description'] as String,
      employee_email: Map['employee_email'] as String,
      location: Map['location'] as String,
      client_phoneNumber: Map['client_phoneNumber'] as String,
      isDone: Map['isDone'] as bool,
      reason_of_visit: Map['reason_of_visit'] as String,
      rep_sales_descroption: Map['rep_sales_descroption'] as String,

    );
  }
}