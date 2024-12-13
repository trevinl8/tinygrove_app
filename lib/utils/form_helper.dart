import 'package:flutter/material.dart';

class FormHelper {
  static Widget textInput(
    BuildContext context,
    String? initialValue, // Changed to String? for null safety
    Function onChanged, {
    bool isTextArea = false,
    bool isNumberInput = false,
    bool obscureText = false, // Added type bool for clarity
    required Function onValidate,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      initialValue: initialValue ?? "", // Null safety handling
      decoration: fieldDecoration(
        context,
        "",
        "",
        suffixIcon: suffixIcon ?? SizedBox(),
        prefixIcon: prefixIcon ?? SizedBox(),
      ),
      obscureText: obscureText,
      maxLines: !isTextArea ? 1 : 3,
      keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
      onChanged: (String value) {
        return onChanged(value);
      },
      validator: (value) {
        return onValidate(value);
      },
    );
  }

  static InputDecoration fieldDecoration(
    BuildContext context,
    String hintText,
    String helperText, {
    required Widget prefixIcon,
    required Widget suffixIcon,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(6),
      hintText: hintText,
      helperText:
          helperText.isNotEmpty ? helperText : null, // Handle null helperText
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
    );
  }

  static Widget fieldLabel(String labelName) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: Text(
        labelName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),
    );
  }

  static Widget saveButton(String buttonText, Function onTap,
      {required String color,
      required String textColor,
      required bool fullWidth}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 50.0,
        width: fullWidth ? double.infinity : 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.redAccent,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }

  static void showMessage(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                onPressed();
              },
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}
