import 'dart:convert';

class UserModel {
  String? id;
  String? email;
  bool? emailConfirmed;
  String? fullName;
  bool? isActive;
  String? profilePhoto;
  String? topics;
  String? createdDate;
  String? birthday;
  String? lang;
  String? userTopicId;
  UserModel({
    this.id,
    this.email,
    this.emailConfirmed,
    this.fullName,
    this.isActive,
    this.profilePhoto,
    this.topics,
    this.createdDate,
    this.birthday,
    this.lang,
    this.userTopicId,
  });

  UserModel copyWith({
    String? id,
    String? email,
    bool? emailConfirmed,
    String? fullName,
    bool? isActive,
    String? profilePhoto,
    String? topics,
    String? createdDate,
    String? birthday,
    String? lang,
    String? userTopicId,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      emailConfirmed: emailConfirmed ?? this.emailConfirmed,
      fullName: fullName ?? this.fullName,
      isActive: isActive ?? this.isActive,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      topics: topics ?? this.topics,
      createdDate: createdDate ?? this.createdDate,
      birthday: birthday ?? this.birthday,
      lang: lang ?? this.lang,
      userTopicId: userTopicId ?? this.userTopicId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'emailConfirmed': emailConfirmed,
      'fullName': fullName,
      'isActive': isActive,
      'profilePhoto': profilePhoto,
      'topics': topics,
      'createdDate': createdDate,
      'birthday': birthday,
      'lang': lang,
      'userTopicId': userTopicId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      emailConfirmed: map['emailConfirmed'],
      fullName: map['fullName'],
      isActive: map['isActive'],
      profilePhoto: map['profilePhoto'],
      topics: map['topics'],
      createdDate: map['createdDate'],
      birthday: map['birthday'],
      lang: map['lang'],
      userTopicId: map['UserTopicId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, emailConfirmed: $emailConfirmed, fullName: $fullName, isActive: $isActive, profilePhoto: $profilePhoto, topics: $topics, createdDate: $createdDate, birthday: $birthday, lang: $lang, userTopicId: $userTopicId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.emailConfirmed == emailConfirmed &&
        other.fullName == fullName &&
        other.isActive == isActive &&
        other.profilePhoto == profilePhoto &&
        other.topics == topics &&
        other.createdDate == createdDate &&
        other.birthday == birthday &&
        other.lang == lang &&
        other.userTopicId == userTopicId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        emailConfirmed.hashCode ^
        fullName.hashCode ^
        isActive.hashCode ^
        profilePhoto.hashCode ^
        topics.hashCode ^
        createdDate.hashCode ^
        birthday.hashCode ^
        lang.hashCode ^
        userTopicId.hashCode;
  }
}
