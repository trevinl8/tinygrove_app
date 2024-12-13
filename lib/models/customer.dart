class CustomerModel {
  String firstName;
  String lastName;
  String email;
  String password;

  CustomerModel(
      {this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.password = ''});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }
}
