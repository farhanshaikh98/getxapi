class ReusableString {
  static const String appName = 'GateKeeper';
  static const String invalidMobileNumber =
      "Please enter correct mobile/phone number";
  static const String pleaseWait = "Please wait...";
  static const String fieldEmptyErrorMsg = "Field can't be empty";
  static const String mobile = "Mobile";
  static const String email = "Email";
  static const String login = "Login";
  static const String forgotpassword = "Forgot Password";
  static const String logout = "Logout";
  static const String username = "Username";
  static const String password = "Password";
  static const String continueTxt = "continue";
  static const String worksiteName = "Worksite Name";
  static const String mobileNumber = "Mobile Number";
  static const String myNumber = "Mobile Number";
  static const String enterName = "Name";
  static const String numberNRIC = "NRIC/Passport Number";
  static const String passNumber = "Pass Number";
  static const String company = "Company";
  static const String submit = "Submit";
  static const String done = "Done";
  static const String profile = "Profile";
  static const String purpose = "Purpose?";
  static const String blockNumber = "Block Number";
  static const String unitNumber = "Unit Number";
  static const String duration = "Duration";
  static const String remarks = "Remarks";
  static const String remark = "Remark";
  static const String myNameId = "My name and ID is";
  static const String carPlateNumber = "Car Plate Number";
  static const String nRICNumber = "NRIC/Passport Number";
  static const String inTime = "In Time";
  static const String personalData = "Personal Data";
  static const String nda = "Data Protection\nNotice";
  static const String blocknumber = "Block Number";
  static const String unitnumber = "Unit Number";
  static const String continuee = "continue";
  static const String entername = "Name";
  static const String enterid = "NRIC/Passport Number";
  static const String passnumber = "Pass Number";
  static const String ForgotPassword = "Forgot Password?";
  static const String ForgotPassbuttonname = "Forgot Password";
  static const String carPlate = "Car Plate";
  static const String plateNumber = "Plate Number";
  static const String dataRecords = "Data Records";
  static const String delivery = "delivery";
  static const String pickup = "pickup";
  static const String dropoff = "dropoff";
  static const String contractor = "contractor";
  static const String visitor = "visitor";
  static const String other = "other";
  static const String noActiveVisitors = "No Active Visitors";
  static const String editmessage =
      "You can edit the car plate number if it is wrong. Just tap on input field and edit.";
  static const String personalDataCase =
      "1. As used in this Notice: “customer” means an individual who (a) has contacted us through any means to find out more about any goods or services we provide, or (b) may, or has, entered into a contract with us for the supply of any goods or services by us; and “personal data” means data, whether true or not, about a customer who can be identified: (a) from that data; or (b) from that data and other information to which we have or are likely to have access.\n2. Depending on the nature of your interaction with us, some examples of personal data which we may collect from you include your name and identification information such as your NRIC number, contact information such as your address, email address or telephone number, nationality, gender, date of birth, marital status, photographs and other audio-visual information, employment information and financial information such as credit card numbers, debit card numbers or bank account information. ";
  static const String checkTermsAndCondition =
      "By checking this box, I acknowledge that I have read and understood the Data Protection Notice, and consent to the collection, use and disclosure of my personal data for the purposes set out in the Notice.";
  static const String loremMyNumber =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam dui quis odio sem viverra.";
  static const String resetPasswordOTPVerify = "Reset Password OTP Verify";
  static const String forgotPassword = "Forgot Password";
  static const String invalidOTP = "Invalid OTP";
  static const String invalidPassword = "Invalid Passwrod";
  static const String addFamilyMember = "AddFamilyMember";
  static const String updateFamilyMember = "UpdateFamilyMember";
  static const String homeScreen = "HOME SCREEN";
  static const String consultSelectFamily = "CONSULT SELECT FAMILY";
  static const String myFamily = "MY FAMILY";
  static const String appNameTxt = "GATEKEEPER";
  static const String appTitle = "Visitor Management System App";
  static const String setFalse = "false";
  static const String setTrue = "true";
  static const String logoutConfirmation = "Are you sure you want to signout?";
  static const String emailIdRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String mobileNumberRegex = r"^[6-9]\d{9}$";
  static const String passwordRegex = r"^.{1,100}$";
  static const String mobileNoMaskRegex = r'\d(?!\d{0,2}$)';
  static const String nameRegex = r"^[a-zA-Z ]+$";
  static const String passwordMatchRegex =
      r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$";
  static const String agreementCase =
      "This Data Protection Notice (“Notice”) sets out the basis which [name of organisation] (“we”, “us”, or “our”) may collect, use, disclose or otherwise process personal data of our customers in accordance with the Personal Data Protection Act (“PDPA”). This Notice applies to personal data in our possession or under our control, including personal data in the possession of organisations which we have engaged to collect, use, disclose or process personal data for our purposes.";
  static Map<String, dynamic> networkErrorRes = <String, dynamic>{
    "status": false,
    "message": connectionMsg
  };
  static String connectionMsg =
      'Unable to connect. Check your internet connectivity.';
  static String tokenExpiry = 'Your token is expired,Please login again';
  static String loginErrorMsg =
      'Password is incorrect, please try again or check with your administrator ';
  static const String print = "Print";
}
