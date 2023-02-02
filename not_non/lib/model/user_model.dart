class UserModel {
  final String uid;
  final String notid;
  final String profilePic;
  final bool isOnline;
  final String abouts;
  final String phoneNumber;
  final int known;
  final int unknown;
  final List<String> groupId;

  UserModel({
    required this.uid,
    required this.notid,
    required this.profilePic,
    required this.isOnline,
    required this.abouts,
    required this.phoneNumber,
    required this.known,
    required this.unknown,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'notid': notid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'abouts': abouts,
      'phoneNumber': phoneNumber,
      'known': known,
      'unknown': unknown,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      notid: map['notid'] ?? '',
      profilePic: map['profilePic'] ?? '',
      abouts: map['abouts'] ?? '',
      isOnline: map['isOnline'] ?? false,
      phoneNumber: map['phoneNumber'] ?? '',
      known: map['known'] ?? 0,
      unknown: map['unknown'] ?? 0,
      groupId: List<String>.from(map['groupId']),
    );
  }
}
