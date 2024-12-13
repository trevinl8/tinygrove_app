import 'package:flutter/material.dart';
import 'package:tinygrove_android_app/api_service.dart';
import 'package:tinygrove_android_app/models/customer.dart';
import 'package:tinygrove_android_app/utils/ProgressHUD.dart';
import 'package:tinygrove_android_app/utils/form_helper.dart';
import 'package:tinygrove_android_app/utils/validator_service.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late APIService apiService;
  late CustomerModel model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
    apiService = APIService();
    model = CustomerModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: Text("Sign Up"),
      ),
      body: ProgressHUD(
        child: Form(
          key: globalKey,
          child: _formUI(),
        ),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormHelper.fieldLabel("First Name"),
              FormHelper.textInput(
                context,
                model.firstName,
                (value) {
                  model.firstName = value;
                },
                onValidate: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter First Name.';
                  }
                  return null;
                },
                // Can be omitted if the refactored code handles null
              ),
              FormHelper.fieldLabel("Last Name"),
              FormHelper.textInput(
                context,
                model.lastName,
                (value) {
                  model.lastName = value;
                },
                onValidate: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter Last Name.';
                  }
                  return null;
                },
              ),
              FormHelper.fieldLabel("Email Address"),
              FormHelper.textInput(
                context,
                model.email,
                (value) {
                  model.email = value;
                },
                onValidate: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter Email Address.';
                  }
                  if (value.isNotEmpty && !value.toString().isValidEmail()) {
                    return 'Please enter a valid Email Address.';
                  }
                  return null;
                },
              ),
              FormHelper.fieldLabel("Password"),
              FormHelper.textInput(
                context,
                model.password,
                (value) {
                  model.password = value;
                },
                onValidate: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter your password.';
                  }
                  return null;
                },
                obscureText: hidePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: isApiCallProcess
                    ? CircularProgressIndicator()
                    : FormHelper.saveButton(
                        "Register",
                        () {
                          if (validateAndSave()) {
                            setState(() {
                              isApiCallProcess = true;
                            });
                            apiService.createCustomer(model).then((ret) {
                              setState(() {
                                isApiCallProcess = false;
                              });
                              // Handle success
                            }).catchError((e) {
                              setState(() {
                                isApiCallProcess = false;
                              });
                              FormHelper.showMessage(
                                context,
                                "Error",
                                "There was an error during registration. Please try again.",
                                "OK",
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            });
                          }
                        },
                        color: '',
                        textColor: '',
                        fullWidth: false,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
