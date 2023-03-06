class TeamChatData{
  String image;
  String teamName;

  TeamChatData({
    required this.image,
    required this.teamName,
  });
}

class TeamMessageDataApi{

  List messageData = [
    TeamChatData(image: '', teamName: ''),
    TeamChatData(image: '', teamName: ''),
    TeamChatData(image: '', teamName: ''),
  ];
}