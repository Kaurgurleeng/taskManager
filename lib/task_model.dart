class Task {
  String title, description, timeStamp, uniqueKey,maxTemp,minTemp,uid;
  String dueDate;

//<editor-fold desc="Data Methods">
  Task({
    required this.title,
    required this.description,
    required this.timeStamp,
    required this.uniqueKey,
    required this.maxTemp,
    required this.minTemp,
    required this.uid,
    required this.dueDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          timeStamp == other.timeStamp &&
          uniqueKey == other.uniqueKey &&
          maxTemp == other.maxTemp &&
          minTemp == other.minTemp &&
          uid == other.uid &&
          dueDate == other.dueDate);

  @override
  int get hashCode =>
      title.hashCode ^
      description.hashCode ^
      timeStamp.hashCode ^
      uniqueKey.hashCode ^
      maxTemp.hashCode ^
      minTemp.hashCode ^
      uid.hashCode ^
      dueDate.hashCode;

  @override
  String toString() {
    return 'Task{' +
        ' title: $title,' +
        ' description: $description,' +
        ' timeStamp: $timeStamp,' +
        ' uniqueKey: $uniqueKey,' +
        ' maxTemp: $maxTemp,' +
        ' minTemp: $minTemp,' +
        ' uid: $uid,' +
        ' dueDate: $dueDate,' +
        '}';
  }

  Task copyWith({
    String? title,
    String? description,
    String? timeStamp,
    String? uniqueKey,
    String? maxTemp,
    String? minTemp,
    String? uid,
    String? dueDate,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      timeStamp: timeStamp ?? this.timeStamp,
      uniqueKey: uniqueKey ?? this.uniqueKey,
      maxTemp: maxTemp ?? this.maxTemp,
      minTemp: minTemp ?? this.minTemp,
      uid: uid ?? this.uid,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'timeStamp': this.timeStamp,
      'uniqueKey': this.uniqueKey,
      'maxTemp': this.maxTemp,
      'minTemp': this.minTemp,
      'uid': this.uid,
      'dueDate': this.dueDate,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      description: map['description'] as String,
      timeStamp: map['timeStamp'] as String,
      uniqueKey: map['uniqueKey'] as String,
      maxTemp: map['maxTemp'] as String,
      minTemp: map['minTemp'] as String,
      uid: map['uid'] as String,
      dueDate: map['dueDate'] as String,
    );
  }

//</editor-fold>
}
