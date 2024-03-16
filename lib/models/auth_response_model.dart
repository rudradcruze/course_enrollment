class AuthResponseModel {
  int statusCode;
  String message;
  String accessToken;
  int time;
  int expirationDuration;

  AuthResponseModel({
    required this.statusCode,
    required this.message,
    required this.accessToken,
    required this.time,
    required this.expirationDuration,
  });

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'accessToken': accessToken,
      'time': time,
      'expirationDuration': expirationDuration,
    };
  }

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => AuthResponseModel(
    statusCode: json['statusCode'],
    message: json['message'],
    accessToken: json['accessToken'],
    time: json['time'],
    expirationDuration: json['expirationDuration'],
  );
}
