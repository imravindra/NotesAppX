class Note {
  String? id;
  String? userId;
  String? title;
  String? content;
  DateTime? createdOn;

  Note({this.id, this.userId, this.title, this.content, this.createdOn});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map["id"],
      userId: map["userId"],
      title: map["title"],
      content: map["content"],
      createdOn: DateTime.tryParse(map["createdOn"].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userid": userId,
      "title": title,
      "content": content,
      "createdOn": createdOn!.toIso8601String()
    };
  }
}
