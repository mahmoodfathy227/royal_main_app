class PersonChatData{
  String image;
  String name;

  PersonChatData({
    required this.image,
    required this.name,
  });
}

class PersonMessageDataApi{

  List messageData = [
    PersonChatData(image: '', name: ''),
    PersonChatData(image: '', name: ''),
    PersonChatData(image: '', name: ''),
  ];
}