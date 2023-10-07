
// ignore_for_file: public_member_api_docs, sort_constructors_first
class CallModel {
  final String callerId;
  final String callerName;
  final String callerPic;
  final String recieverId;
  final String recieverName;
  final String recieverPic;
  final String callId;
  final bool hasDialled;
  CallModel({
    required this.callerId,
    required this.callerName,
    required this.callerPic,
    required this.recieverId,
    required this.recieverName,
    required this.recieverPic,
    required this.callId,
    required this.hasDialled,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'callerId': callerId,
      'callerName': callerName,
      'callerPic': callerPic,
      'recieverId': recieverId,
      'recieverName': recieverName,
      'recieverPic': recieverPic,
      'callId': callId,
      'hasDialled': hasDialled,
    };
  }

  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      callerId: map['callerId'] as String,
      callerName: map['callerName'] as String,
      callerPic: map['callerPic'] as String,
      recieverId: map['recieverId'] as String,
      recieverName: map['recieverName'] as String,
      recieverPic: map['recieverPic'] as String,
      callId: map['callId'] as String,
      hasDialled: map['hasDialled'] as bool,
    );
  }

}
