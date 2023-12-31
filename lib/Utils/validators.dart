class MyValidator {
  static String? validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    } else {
      return null;
    }
  }

  static String? validateDropDefaultData(value) {
    if (value == null) {
      return 'Please select an item.';
    } else {
      return null;
    }
  }

  // static String? validatePassword(String value) {
  //   Pattern pattern = r'^.{5,}$';
  //   RegExp regex = RegExp(pattern as String);
  //   if (!regex.hasMatch(value)) {
  //     return 'Password must be at least 6 characters.';
  //   } else {
  //     return null;
  //   }
  // }

  static String? validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else {
      return null;
    }
  }

  static String? validateName(String value) {
    if (value.length < 3) {
      return 'Username is too short.';
    } else {
      return null;
    }
  }

  static String? validateText(String value) {
    if (value.isEmpty) {
      return 'Text is too short.';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String value) {
    if (value.length != 10) {
      return 'Phone number is not valid.';
    } else {
      return null;
    }
  }

  static String? validatePinCode(String value) {
    if (value.length != 6) {
      return 'Please enter 6 number digit!';
    } else {
      return null;
    }
  }
  static String? mobile(String value) {
    if (value.isEmpty) {
      return 'Phone number is not valid.';
    } else {
      return null;
    }
  }
  static String? validatePassword(String value) {
    if (value.length < 4) {
      return 'Password Minimal 4 Karakter';
    }
    return null;
  }
}
