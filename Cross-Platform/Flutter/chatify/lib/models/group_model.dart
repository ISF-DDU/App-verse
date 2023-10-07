// ignore_for_file: public_member_api_docs, sort_constructors_first
class GroupModel {
  final String senderId;
  final String name;
  final String groupId;
  final String lastMessage;
  final String groupProfilePic;
  final List<String> memberUid;
  final DateTime timeSent;
  GroupModel({
    required this.senderId,
    required this.name,
    required this.groupId,
    required this.lastMessage,
    required this.groupProfilePic,
    required this.memberUid,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'name': name,
      'groupId': groupId,
      'lastMessage': lastMessage,
      'groupProfilePic': groupProfilePic,
      'memberUid': memberUid,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      senderId: map['senderId'] ?? "",
      name: map['name'] ?? "",
      groupId: map['groupId'] ?? "",
      lastMessage: map['lastMessage'] ?? "",
      groupProfilePic: map['groupProfilePic'] ?? "",
      memberUid: List<String>.from(map['memberUid']),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
    );
  }
}
