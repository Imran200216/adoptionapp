class ChatRoom {
  String roomId;
  String userUid1;
  String userUid2;
  DateTime createdAt;

  ChatRoom({
    required this.roomId,
    required this.userUid1,
    required this.userUid2,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'userUid1': userUid1,
      'userUid2': userUid2,
      'createdAt': createdAt,
    };
  }
}
