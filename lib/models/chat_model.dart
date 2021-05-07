class ChatModel {
  String name;
  String time;
  String icon;
  String currentMessage;
  bool isGroup;
  bool isSelected = false;
  String status;
  int id;
  ChatModel(
      {this.icon,
      this.name,
      this.isSelected = false,
      this.currentMessage,
      this.status,
      this.isGroup,
      this.time,
      this.id});
}
