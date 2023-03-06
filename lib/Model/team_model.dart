class TeamModel{
  String team_name;
String team_count ;
  String supervisor_name;
  String member_data;
  String supervisor_email;
  TeamModel({
    required this.team_name,
    required this.team_count,
    required this.supervisor_name,
    required this.member_data,
    required this.supervisor_email,

  });

  Map<String, dynamic> toMap() {
    return {
      'team_name': team_name,
      'team_number' : team_count,
      'supervisor_name' : supervisor_name,
      'member_data' : member_data,
'supervisor_email' : supervisor_email
    };
  }

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      team_name: map['team_name'] as String,
      team_count: map['team_count'] as String,
      supervisor_name: map['supervisor_name'] as String,
      member_data: map['member_data'] as String,
        supervisor_email: map['supervisor_email'] as String,

    );
  }
}