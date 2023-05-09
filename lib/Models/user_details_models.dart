class UserDetailsModels {
  UserDetailsModels({
      bool? status, 
      List<UserDetailsData>? data,}){
    _status = status;
    _data = data;
}

  UserDetailsModels.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(UserDetailsData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<UserDetailsData>? _data;
UserDetailsModels copyWith({  bool? status,
  List<UserDetailsData>? data,
}) => UserDetailsModels(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<UserDetailsData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class UserDetailsData {
  UserDetailsData({
      String? id, 
      String? firstName, 
      String? lastName, 
      String? emailId, 
      String? mobileNumber, 
      String? gender, 
      String? password, 
      dynamic alternateContactNo, 
      String? emergencyContactNo, 
      String? userType, 
      dynamic aadharNumber, 
      dynamic panNumber, 
      dynamic profileImage, 
      List<Documents>? documents, 
      dynamic maritalStatus, 
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
      PermanentAddress? permanentAddress, 
      dynamic presentAddress, 
      String? sameAddress, 
      String? createdAt, 
      String? updatedAt, 
      String? createdBy, 
      String? updatedBy, 
      String? dob, 
      dynamic fcmtoken, 
      dynamic coordinatorContactNo, 
      dynamic coordinatorName, 
      dynamic organizationName, 
      String? dlNumber, 
      String? dlExpiryDate, 
      String? dlMobileNumber, 
      String? accidentalHistory, 
      String? accidentalDiscription, 
      String? available24by7, 
      String? shiftTimeFrom, 
      String? shiftTimeTo, 
      dynamic profilePercentage,}){
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
    _coordinatorContactNo = coordinatorContactNo;
    _coordinatorName = coordinatorName;
    _organizationName = organizationName;
    _dlNumber = dlNumber;
    _dlExpiryDate = dlExpiryDate;
    _dlMobileNumber = dlMobileNumber;
    _accidentalHistory = accidentalHistory;
    _accidentalDiscription = accidentalDiscription;
    _available24by7 = available24by7;
    _shiftTimeFrom = shiftTimeFrom;
    _shiftTimeTo = shiftTimeTo;
    _profilePercentage = profilePercentage;
}

  UserDetailsData.fromJson(dynamic json) {
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
    if (json['documents'] != null) {
      _documents = [];
      json['documents'].forEach((v) {
        _documents?.add(Documents.fromJson(v));
      });
    }
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
    _permanentAddress = json['permanent_address'] != null ? PermanentAddress.fromJson(json['permanent_address']) : null;
    _presentAddress = json['present_address'];
    _sameAddress = json['same_address'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _dob = json['dob'];
    _fcmtoken = json['fcmtoken'];
    _coordinatorContactNo = json['coordinator_contact_no'];
    _coordinatorName = json['coordinator_name'];
    _organizationName = json['organization_name'];
    _dlNumber = json['dl_number'];
    _dlExpiryDate = json['dl_expiry_date'];
    _dlMobileNumber = json['dl_mobile_number'];
    _accidentalHistory = json['accidental_history'];
    _accidentalDiscription = json['accidental_discription'];
    _available24by7 = json['available24by7'];
    _shiftTimeFrom = json['shift_time_from'];
    _shiftTimeTo = json['shift_time_to'];
    _profilePercentage = json['profile_percentage'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _emailId;
  String? _mobileNumber;
  String? _gender;
  String? _password;
  dynamic _alternateContactNo;
  String? _emergencyContactNo;
  String? _userType;
  dynamic _aadharNumber;
  dynamic _panNumber;
  dynamic _profileImage;
  List<Documents>? _documents;
  dynamic _maritalStatus;
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
  PermanentAddress? _permanentAddress;
  dynamic _presentAddress;
  String? _sameAddress;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
  String? _updatedBy;
  String? _dob;
  dynamic _fcmtoken;
  dynamic _coordinatorContactNo;
  dynamic _coordinatorName;
  dynamic _organizationName;
  String? _dlNumber;
  String? _dlExpiryDate;
  String? _dlMobileNumber;
  String? _accidentalHistory;
  String? _accidentalDiscription;
  String? _available24by7;
  String? _shiftTimeFrom;
  String? _shiftTimeTo;
  dynamic _profilePercentage;
  UserDetailsData copyWith({  String? id,
  String? firstName,
  String? lastName,
  String? emailId,
  String? mobileNumber,
  String? gender,
  String? password,
  dynamic alternateContactNo,
  String? emergencyContactNo,
  String? userType,
  dynamic aadharNumber,
  dynamic panNumber,
  dynamic profileImage,
  List<Documents>? documents,
  dynamic maritalStatus,
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
  PermanentAddress? permanentAddress,
  dynamic presentAddress,
  String? sameAddress,
  String? createdAt,
  String? updatedAt,
  String? createdBy,
  String? updatedBy,
  String? dob,
  dynamic fcmtoken,
  dynamic coordinatorContactNo,
  dynamic coordinatorName,
  dynamic organizationName,
  String? dlNumber,
  String? dlExpiryDate,
  String? dlMobileNumber,
  String? accidentalHistory,
  String? accidentalDiscription,
  String? available24by7,
  String? shiftTimeFrom,
  String? shiftTimeTo,
  dynamic profilePercentage,
}) => UserDetailsData(  id: id ?? _id,
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
  coordinatorContactNo: coordinatorContactNo ?? _coordinatorContactNo,
  coordinatorName: coordinatorName ?? _coordinatorName,
  organizationName: organizationName ?? _organizationName,
  dlNumber: dlNumber ?? _dlNumber,
  dlExpiryDate: dlExpiryDate ?? _dlExpiryDate,
  dlMobileNumber: dlMobileNumber ?? _dlMobileNumber,
  accidentalHistory: accidentalHistory ?? _accidentalHistory,
  accidentalDiscription: accidentalDiscription ?? _accidentalDiscription,
  available24by7: available24by7 ?? _available24by7,
  shiftTimeFrom: shiftTimeFrom ?? _shiftTimeFrom,
  shiftTimeTo: shiftTimeTo ?? _shiftTimeTo,
  profilePercentage: profilePercentage ?? _profilePercentage,
);
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get emailId => _emailId;
  String? get mobileNumber => _mobileNumber;
  String? get gender => _gender;
  String? get password => _password;
  dynamic get alternateContactNo => _alternateContactNo;
  String? get emergencyContactNo => _emergencyContactNo;
  String? get userType => _userType;
  dynamic get aadharNumber => _aadharNumber;
  dynamic get panNumber => _panNumber;
  dynamic get profileImage => _profileImage;
  List<Documents>? get documents => _documents;
  dynamic get maritalStatus => _maritalStatus;
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
  PermanentAddress? get permanentAddress => _permanentAddress;
  dynamic get presentAddress => _presentAddress;
  String? get sameAddress => _sameAddress;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  String? get updatedBy => _updatedBy;
  String? get dob => _dob;
  dynamic get fcmtoken => _fcmtoken;
  dynamic get coordinatorContactNo => _coordinatorContactNo;
  dynamic get coordinatorName => _coordinatorName;
  dynamic get organizationName => _organizationName;
  String? get dlNumber => _dlNumber;
  String? get dlExpiryDate => _dlExpiryDate;
  String? get dlMobileNumber => _dlMobileNumber;
  String? get accidentalHistory => _accidentalHistory;
  String? get accidentalDiscription => _accidentalDiscription;
  String? get available24by7 => _available24by7;
  String? get shiftTimeFrom => _shiftTimeFrom;
  String? get shiftTimeTo => _shiftTimeTo;
  dynamic get profilePercentage => _profilePercentage;

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
    if (_permanentAddress != null) {
      map['permanent_address'] = _permanentAddress?.toJson();
    }
    map['present_address'] = _presentAddress;
    map['same_address'] = _sameAddress;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['dob'] = _dob;
    map['fcmtoken'] = _fcmtoken;
    map['coordinator_contact_no'] = _coordinatorContactNo;
    map['coordinator_name'] = _coordinatorName;
    map['organization_name'] = _organizationName;
    map['dl_number'] = _dlNumber;
    map['dl_expiry_date'] = _dlExpiryDate;
    map['dl_mobile_number'] = _dlMobileNumber;
    map['accidental_history'] = _accidentalHistory;
    map['accidental_discription'] = _accidentalDiscription;
    map['available24by7'] = _available24by7;
    map['shift_time_from'] = _shiftTimeFrom;
    map['shift_time_to'] = _shiftTimeTo;
    map['profile_percentage'] = _profilePercentage;
    return map;
  }

}

class PermanentAddress {
  PermanentAddress({
      String? address, 
      dynamic city, 
      dynamic state, 
      dynamic pincode,}){
    _address = address;
    _city = city;
    _state = state;
    _pincode = pincode;
}

  PermanentAddress.fromJson(dynamic json) {
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _pincode = json['pincode'];
  }
  String? _address;
  dynamic _city;
  dynamic _state;
  dynamic _pincode;
PermanentAddress copyWith({  String? address,
  dynamic city,
  dynamic state,
  dynamic pincode,
}) => PermanentAddress(  address: address ?? _address,
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

class Documents {
  Documents({
      String? idNumber, 
      String? photo,}){
    _idNumber = idNumber;
    _photo = photo;
}

  Documents.fromJson(dynamic json) {
    _idNumber = json['id_number'];
    _photo = json['photo'];
  }
  String? _idNumber;
  String? _photo;
Documents copyWith({  String? idNumber,
  String? photo,
}) => Documents(  idNumber: idNumber ?? _idNumber,
  photo: photo ?? _photo,
);
  String? get idNumber => _idNumber;
  String? get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_number'] = _idNumber;
    map['photo'] = _photo;
    return map;
  }

}