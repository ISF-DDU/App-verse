// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChatContact {
  final String name;
  final String profilePic;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;

  ChatContact(this.name, this.profilePic, this.contactId, this.timeSent, this.lastMessage);


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      map['name'] as String,
      map['profilePic'] as String,
      map['contactId'] as String,
      DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      map['lastMessage'] as String,
    );
  }

 
}
