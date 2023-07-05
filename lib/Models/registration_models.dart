class RegistrationModels {
  RegistrationModels({
      bool? status, 
      List<Data>? data,}){
    _status = status;
    _data = data;
}

  RegistrationModels.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Data>? _data;
RegistrationModels copyWith({  bool? status,
  List<Data>? data,
}) => RegistrationModels(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      String? id, 
      String? firstName, 
      String? lastName, 
      String? emailId, 
      String? mobileNumber, 
      String? gender, 
      String? password, 
      String? alternateContactNo, 
      String? emergencyContactNo, 
      String? userType, 
      String? aadharNumber, 
      String? panNumber, 
      String? profileImage, 
      List<dynamic>? documents, 
      String? maritalStatus, 
      String? citizenship, 
      String? failAttempt, 
      String? isLock, 
      String? address, 
      Dldetails? dldetails, 
      String? city, 
      String? state, 
      String? pincode, 
      String? resetPassword, 
      String? status, 
      dynamic permanentAddress, 
      PresentAddress? presentAddress, 
      String? sameAddress, 
      String? createdAt, 
      String? updatedAt, 
      String? createdBy, 
      String? updatedBy, 
      String? dob, 
      dynamic fcmtoken, 
      String? logintoken,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _emailId = emailId;
    _mobileNumber = mobileNumber;
    _gender = gender;
    _password = password;
    _alternateContactNo = alternateContactNo;
    _emergencyContactNo = emergencyContactNo;
    _userType = userType;
    _aadharNumber = aadharNumber;
    _panNumber = panNumber;
    _profileImage = profileImage;
    _documents = documents;
    _maritalStatus = maritalStatus;
    _citizenship = citizenship;
    _failAttempt = failAttempt;
    _isLock = isLock;
    _address = address;
    _dldetails = dldetails;
    _city = city;
    _state = state;
    _pincode = pincode;
    _resetPassword = resetPassword;
    _status = status;
    _permanentAddress = permanentAddress;
    _presentAddress = presentAddress;
    _sameAddress = sameAddress;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _dob = dob;
    _fcmtoken = fcmtoken;
    _logintoken = logintoken;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _emailId = json['email_id'];
    _mobileNumber = json['mobile_number'];
    _gender = json['gender'];
    _password = json['password'];
    _alternateContactNo = json['alternate_contact_no'];
    _emergencyContactNo = json['emergency_contact_no'];
    _userType = json['user_type'];
    _aadharNumber = json['aadhar_number'];
    _panNumber = json['pan_number'];
    _profileImage = json['profile_image'];

    _maritalStatus = json['marital_status'];
    _citizenship = json['citizenship'];
    _failAttempt = json['fail_attempt'];
    _isLock = json['is_lock'];
    _address = json['address'];
    _dldetails = json['dldetails'] != null ? Dldetails.fromJson(json['dldetails']) : null;
    _city = json['city'];
    _state = json['state'];
    _pincode = json['pincode'];
    _resetPassword = json['reset_password'];
    _status = json['status'];
    _permanentAddress = json['permanent_address'];
    _presentAddress = json['present_address'] != null ? PresentAddress.fromJson(json['present_address']) : null;
    _sameAddress = json['same_address'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _dob = json['dob'];
    _fcmtoken = json['fcmtoken'];
    _logintoken = json['logintoken'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _emailId;
  String? _mobileNumber;
  String? _gender;
  String? _password;
  String? _alternateContactNo;
  String? _emergencyContactNo;
  String? _userType;
  String? _aadharNumber;
  String? _panNumber;
  String? _profileImage;
  List<dynamic>? _documents;
  String? _maritalStatus;
  String? _citizenship;
  String? _failAttempt;
  String? _isLock;
  String? _address;
  Dldetails? _dldetails;
  String? _city;
  String? _state;
  String? _pincode;
  String? _resetPassword;
  String? _status;
  dynamic _permanentAddress;
  PresentAddress? _presentAddress;
  String? _sameAddress;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
  String? _updatedBy;
  String? _dob;
  dynamic _fcmtoken;
  String? _logintoken;
Data copyWith({  String? id,
  String? firstName,
  String? lastName,
  String? emailId,
  String? mobileNumber,
  String? gender,
  String? password,
  String? alternateContactNo,
  String? emergencyContactNo,
  String? userType,
  String? aadharNumber,
  String? panNumber,
  String? profileImage,
  List<dynamic>? documents,
  String? maritalStatus,
  String? citizenship,
  String? failAttempt,
  String? isLock,
  String? address,
  Dldetails? dldetails,
  String? city,
  String? state,
  String? pincode,
  String? resetPassword,
  String? status,
  dynamic permanentAddress,
  PresentAddress? presentAddress,
  String? sameAddress,
  String? createdAt,
  String? updatedAt,
  String? createdBy,
  String? updatedBy,
  String? dob,
  dynamic fcmtoken,
  String? logintoken,
}) => Data(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  emailId: emailId ?? _emailId,
  mobileNumber: mobileNumber ?? _mobileNumber,
  gender: gender ?? _gender,
  password: password ?? _password,
  alternateContactNo: alternateContactNo ?? _alternateContactNo,
  emergencyContactNo: emergencyContactNo ?? _emergencyContactNo,
  userType: userType ?? _userType,
  aadharNumber: aadharNumber ?? _aadharNumber,
  panNumber: panNumber ?? _panNumber,
  profileImage: profileImage ?? _profileImage,
  documents: documents ?? _documents,
  maritalStatus: maritalStatus ?? _maritalStatus,
  citizenship: citizenship ?? _citizenship,
  failAttempt: failAttempt ?? _failAttempt,
  isLock: isLock ?? _isLock,
  address: address ?? _address,
  dldetails: dldetails ?? _dldetails,
  city: city ?? _city,
  state: state ?? _state,
  pincode: pincode ?? _pincode,
  resetPassword: resetPassword ?? _resetPassword,
  status: status ?? _status,
  permanentAddress: permanentAddress ?? _permanentAddress,
  presentAddress: presentAddress ?? _presentAddress,
  sameAddress: sameAddress ?? _sameAddress,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  createdBy: createdBy ?? _createdBy,
  updatedBy: updatedBy ?? _updatedBy,
  dob: dob ?? _dob,
  fcmtoken: fcmtoken ?? _fcmtoken,
  logintoken: logintoken ?? _logintoken,
);
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get emailId => _emailId;
  String? get mobileNumber => _mobileNumber;
  String? get gender => _gender;
  String? get password => _password;
  String? get alternateContactNo => _alternateContactNo;
  String? get emergencyContactNo => _emergencyContactNo;
  String? get userType => _userType;
  String? get aadharNumber => _aadharNumber;
  String? get panNumber => _panNumber;
  String? get profileImage => _profileImage;
  List<dynamic>? get documents => _documents;
  String? get maritalStatus => _maritalStatus;
  String? get citizenship => _citizenship;
  String? get failAttempt => _failAttempt;
  String? get isLock => _isLock;
  String? get address => _address;
  Dldetails? get dldetails => _dldetails;
  String? get city => _city;
  String? get state => _state;
  String? get pincode => _pincode;
  String? get resetPassword => _resetPassword;
  String? get status => _status;
  dynamic get permanentAddress => _permanentAddress;
  PresentAddress? get presentAddress => _presentAddress;
  String? get sameAddress => _sameAddress;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  String? get updatedBy => _updatedBy;
  String? get dob => _dob;
  dynamic get fcmtoken => _fcmtoken;
  String? get logintoken => _logintoken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email_id'] = _emailId;
    map['mobile_number'] = _mobileNumber;
    map['gender'] = _gender;
    map['password'] = _password;
    map['alternate_contact_no'] = _alternateContactNo;
    map['emergency_contact_no'] = _emergencyContactNo;
    map['user_type'] = _userType;
    map['aadhar_number'] = _aadharNumber;
    map['pan_number'] = _panNumber;
    map['profile_image'] = _profileImage;
    if (_documents != null) {
      map['documents'] = _documents?.map((v) => v.toJson()).toList();
    }
    map['marital_status'] = _maritalStatus;
    map['citizenship'] = _citizenship;
    map['fail_attempt'] = _failAttempt;
    map['is_lock'] = _isLock;
    map['address'] = _address;
    if (_dldetails != null) {
      map['dldetails'] = _dldetails?.toJson();
    }
    map['city'] = _city;
    map['state'] = _state;
    map['pincode'] = _pincode;
    map['reset_password'] = _resetPassword;
    map['status'] = _status;
    map['permanent_address'] = _permanentAddress;
    if (_presentAddress != null) {
      map['present_address'] = _presentAddress?.toJson();
    }
    map['same_address'] = _sameAddress;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['dob'] = _dob;
    map['fcmtoken'] = _fcmtoken;
    map['logintoken'] = _logintoken;
    return map;
  }

}

class PresentAddress {
  PresentAddress({
      String? address, 
      dynamic city, 
      dynamic state, 
      dynamic pincode,}){
    _address = address;
    _city = city;
    _state = state;
    _pincode = pincode;
}

  PresentAddress.fromJson(dynamic json) {
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _pincode = json['pincode'];
  }
  String? _address;
  dynamic _city;
  dynamic _state;
  dynamic _pincode;
PresentAddress copyWith({  String? address,
  dynamic city,
  dynamic state,
  dynamic pincode,
}) => PresentAddress(  address: address ?? _address,
  city: city ?? _city,
  state: state ?? _state,
  pincode: pincode ?? _pincode,
);
  String? get address => _address;
  dynamic get city => _city;
  dynamic get state => _state;
  dynamic get pincode => _pincode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['pincode'] = _pincode;
    return map;
  }

}

class Dldetails {
  Dldetails({
      String? dlNumber, 
      String? photo, 
      String? dlExpiryDate, 
      String? dlMobileNumber, 
      String? accidentalHistory, 
      String? accidentalDiscription, 
      String? available24by7, 
      String? shiftTimeFrom, 
      String? shiftTimeTo,}){
    _dlNumber = dlNumber;
    _photo = photo;
    _dlExpiryDate = dlExpiryDate;
    _dlMobileNumber = dlMobileNumber;
    _accidentalHistory = accidentalHistory;
    _accidentalDiscription = accidentalDiscription;
    _available24by7 = available24by7;
    _shiftTimeFrom = shiftTimeFrom;
    _shiftTimeTo = shiftTimeTo;
}

  Dldetails.fromJson(dynamic json) {
    _dlNumber = json['dl_number'];
    _photo = json['photo'];
    _dlExpiryDate = json['dl_expiry_date'];
    _dlMobileNumber = json['dl_mobile_number'];
    _accidentalHistory = json['accidental_history'];
    _accidentalDiscription = json['accidental_discription'];
    _available24by7 = json['available24by7'];
    _shiftTimeFrom = json['shift_time_from'];
    _shiftTimeTo = json['shift_time_to'];
  }
  String? _dlNumber;
  String? _photo;
  String? _dlExpiryDate;
  String? _dlMobileNumber;
  String? _accidentalHistory;
  String? _accidentalDiscription;
  String? _available24by7;
  String? _shiftTimeFrom;
  String? _shiftTimeTo;
Dldetails copyWith({  String? dlNumber,
  String? photo,
  String? dlExpiryDate,
  String? dlMobileNumber,
  String? accidentalHistory,
  String? accidentalDiscription,
  String? available24by7,
  String? shiftTimeFrom,
  String? shiftTimeTo,
}) => Dldetails(  dlNumber: dlNumber ?? _dlNumber,
  photo: photo ?? _photo,
  dlExpiryDate: dlExpiryDate ?? _dlExpiryDate,
  dlMobileNumber: dlMobileNumber ?? _dlMobileNumber,
  accidentalHistory: accidentalHistory ?? _accidentalHistory,
  accidentalDiscription: accidentalDiscription ?? _accidentalDiscription,
  available24by7: available24by7 ?? _available24by7,
  shiftTimeFrom: shiftTimeFrom ?? _shiftTimeFrom,
  shiftTimeTo: shiftTimeTo ?? _shiftTimeTo,
);
  String? get dlNumber => _dlNumber;
  String? get photo => _photo;
  String? get dlExpiryDate => _dlExpiryDate;
  String? get dlMobileNumber => _dlMobileNumber;
  String? get accidentalHistory => _accidentalHistory;
  String? get accidentalDiscription => _accidentalDiscription;
  String? get available24by7 => _available24by7;
  String? get shiftTimeFrom => _shiftTimeFrom;
  String? get shiftTimeTo => _shiftTimeTo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dl_number'] = _dlNumber;
    map['photo'] = _photo;
    map['dl_expiry_date'] = _dlExpiryDate;
    map['dl_mobile_number'] = _dlMobileNumber;
    map['accidental_history'] = _accidentalHistory;
    map['accidental_discription'] = _accidentalDiscription;
    map['available24by7'] = _available24by7;
    map['shift_time_from'] = _shiftTimeFrom;
    map['shift_time_to'] = _shiftTimeTo;
    return map;
  }

}