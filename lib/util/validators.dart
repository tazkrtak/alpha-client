enum MODE { TEST, DEPLOY }

final mode = MODE.TEST;

class _ValidatorsTestMode {
  static final RegExp nationalIdRegExp = RegExp(
    r'^\d{3,}$',
  );

  static final RegExp emailRegExp = RegExp(
    r'^.+@.+$',
  );

  static final RegExp phoneNumberRegExp = RegExp(
    r'^\d{3,}$',
  );

  static final RegExp passwordRegExp = RegExp(
    r'^.{3,}$',
  );
}

class Validators {
  static final RegExp _nationalIdRegExp = RegExp(
    r'^\d{14}$',
  );

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static final RegExp _phoneNumberRegExp = RegExp(
    r'^\d{11}$',
  );

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidNationalId(String nationalId) {
    return mode == MODE.TEST
        ? _ValidatorsTestMode.nationalIdRegExp.hasMatch(nationalId)
        : _nationalIdRegExp.hasMatch(nationalId);
  }

  static isValidEmail(String email) {
    return mode == MODE.TEST
        ? _ValidatorsTestMode.emailRegExp.hasMatch(email)
        : _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return mode == MODE.TEST
        ? _ValidatorsTestMode.passwordRegExp.hasMatch(password)
        : _passwordRegExp.hasMatch(password);
  }

  static isValidPhoneNumber(String phoneNumber) {
    return mode == MODE.TEST
        ? _ValidatorsTestMode.phoneNumberRegExp.hasMatch(phoneNumber)
        : _phoneNumberRegExp.hasMatch(phoneNumber);
  }
}
