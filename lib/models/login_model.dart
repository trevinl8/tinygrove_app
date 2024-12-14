class LoginResponseModel {
  final bool success;
  final int statusCode;
  final String? code; // Nullable because it might not always be present
  final String? message; // Nullable because it might not always be present
  final Data? data; // Nullable because 'data' may not always be present

  LoginResponseModel({
    required this.success,
    required this.statusCode,
    this.code,
    this.message,
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false, // Default to false if null
      statusCode: json['statusCode'] ?? 0, // Default to 0 if null
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['success'] = success;
    json['statusCode'] = statusCode;
    if (code != null) json['code'] = code;
    if (message != null) json['message'] = message;
    if (data != null) json['data'] = data!.toJson();
    return json;
  }
}

class Data {
  final String token;
  final int id;
  final String email;
  final String? niceName; // Nullable if it might not always be present
  final String? firstName; // Nullable if it might not always be present
  final String? lastName; // Nullable if it might not always be present
  final String displayName;

  Data({
    required this.token,
    required this.id,
    required this.email,
    this.niceName,
    this.firstName,
    this.lastName,
    required this.displayName,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'] ?? "", // Default to empty string if null
      id: json['id'] ?? 0, // Default to 0 if null
      email: json['email'] ?? "",
      niceName: json['niceName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      displayName: json['displayName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['token'] = token;
    json['id'] = id;
    json['email'] = email;
    if (niceName != null) json['niceName'] = niceName;
    if (firstName != null) json['firstName'] = firstName;
    if (lastName != null) json['lastName'] = lastName;
    json['displayName'] = displayName;
    return json;
  }
}
