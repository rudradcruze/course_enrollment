class Course {
  int? id;
  String name;
  String details;
  double fee;

  Course({
    this.id,
    required this.name,
    required this.details,
    required this.fee,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json['id'] as int,
    name: json['name'] as String,
    details: json['details'] as String,
    fee: json['fee'] as double,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'name': name,
      'details': details,
      'fee': fee,
    };
    if (id != null) {
      json['id'] = id;
    }
    return json;
  }
}