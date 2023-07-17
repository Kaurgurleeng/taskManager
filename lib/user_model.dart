class Users {
  String id,
      name,
      email,
      password;
  int timeStamp;

//<editor-fold desc="Data Methods">
  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.timeStamp,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Users &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          password == other.password &&
          timeStamp == other.timeStamp);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      timeStamp.hashCode;

  @override
  String toString() {
    return 'Users{' +
        ' id: $id,' +
        ' name: $name,' +
        ' email: $email,' +
        ' password: $password,' +
        ' timeStamp: $timeStamp,' +
        '}';
  }

  Users copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    int? timeStamp,
  }) {
    return Users(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'password': this.password,
      'timeStamp': this.timeStamp,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      timeStamp: map['timeStamp'] as int,
    );
  }

//</editor-fold>
}
