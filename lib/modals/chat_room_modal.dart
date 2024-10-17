class ChatRoom {
  String roomId;
  String userUid1;
  String userUid2;
  String userUid1AvatarUrl;
  String userUid2AvatarUrl;
  DateTime createdAt;

  ChatRoom({
    required this.roomId,
    required this.userUid1,
    required this.userUid2,
    required this.userUid1AvatarUrl,
    required this.userUid2AvatarUrl,
    required this.createdAt,
  });

  // Convert a ChatRoom object into a map
  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'userUid1': userUid1,
      'userUid2': userUid2,
      'userUid1AvatarUrl': userUid1AvatarUrl,
      'userUid2AvatarUrl': userUid2AvatarUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create a ChatRoom object from a map
  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      roomId: map['roomId'],
      userUid1: map['userUid1'],
      userUid2: map['userUid2'],
      userUid1AvatarUrl: map['userUid1AvatarUrl'],
      userUid2AvatarUrl: map['userUid2AvatarUrl'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
