const String emptyEmailField = 'Email field cannot be empty!';
const String emptyTextField = 'Field cannot be empty!';
const String emptyPasswordField = 'Password field cannot be empty';
const String invalidEmailField =
    "Email provided isn't valid.Try another email address";
const String passwordLengthError = 'Password length must be greater than 8';
const String invalidPassword =
    'password must contain at least 1 symbol, \n1 number, 1 lowercase and 1 uppercase';
const String invalidPhoneNumberField =
    "Number provided isn't valid.Try another phone number";
const String invalidOTPField = "OTP should contain 6 digits";
const String invalidPinField = "Pin should contain 4 digits";

//Regular Expressions
const String phoneNumberRegex = r'0[789][01]\d{8}';
const String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

//new regex without allowing +
// const String emailRegex = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
