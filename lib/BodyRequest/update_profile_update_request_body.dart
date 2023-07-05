class UpdateProfileUpdateRequestBody {
  UpdateProfileUpdateRequestBody({
      String? userId, 
      String? firstName, 
      String? lastName, 
      String? aadharNumber, 
      String? panNumber, 
      String? emailId, 
      String? gender, 
      String? dob, 
      String? mobileNumber, 
      String? alternateContactNo, 
      String? emergencyContactNo, 
      String? profileImage,
      String? address,
      String? maritalStatus, 
      PermanentAddress? permanentAddress, 
      PresentAddress? presentAddress, 
      String? sameAddress, 
      Dldetails? dldetails,}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _aadharNumber = aadharNumber;
    _panNumber = panNumber;
    _emailId = emailId;
    _gender = gender;
    _dob = dob;
    _mobileNumber = mobileNumber;
    _alternateContactNo = alternateContactNo;
    _emergencyContactNo = emergencyContactNo;
    _profileImage = profileImage;
    _maritalStatus = maritalStatus;
    _permanentAddress = permanentAddress;
    _presentAddress = presentAddress;
    _sameAddress = sameAddress;
    _dldetails = dldetails;
    _address =address;
}

  UpdateProfileUpdateRequestBody.fromJson(dynamic json) {
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _aadharNumber = json['aadhar_number'];
    _panNumber = json['pan_number'];
    _emailId = json['email_id'];
    _gender = json['gender'];
    _dob = json['dob'];
    _mobileNumber = json['mobile_number'];
    _alternateContactNo = json['alternate_contact_no'];
    _emergencyContactNo = json['emergency_contact_no'];
    _profileImage = json['profile_image'];
    _maritalStatus = json['marital_status'];
    _permanentAddress = json['permanent_address'] != null ? PermanentAddress.fromJson(json['permanent_address']) : null;
    _presentAddress = json['present_address'] != null ? PresentAddress.fromJson(json['present_address']) : null;
    _sameAddress = json['same_address'];
    _dldetails = json['dldetails'] != null ? Dldetails.fromJson(json['dldetails']) : null;
    _address = json['address'];
  }
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _aadharNumber;
  String? _panNumber;
  String? _emailId;
  String? _gender;
  String? _dob;
  String? _mobileNumber;
  String? _alternateContactNo;
  String? _emergencyContactNo;
  String? _profileImage;
  String? _maritalStatus;
  PermanentAddress? _permanentAddress;
  PresentAddress? _presentAddress;
  String? _sameAddress;
  Dldetails? _dldetails;
  String? _address;
UpdateProfileUpdateRequestBody copyWith({  String? userId,
  String? firstName,
  String? lastName,
  String? aadharNumber,
  String? panNumber,
  String? emailId,
  String? gender,
  String? dob,
  String? mobileNumber,
  String? alternateContactNo,
  String? emergencyContactNo,
  String? profileImage,
  String? maritalStatus,
  PermanentAddress? permanentAddress,
  PresentAddress? presentAddress,
  String? sameAddress,
  Dldetails? dldetails,
  String? address,
}) => UpdateProfileUpdateRequestBody(  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  aadharNumber: aadharNumber ?? _aadharNumber,
  panNumber: panNumber ?? _panNumber,
  emailId: emailId ?? _emailId,
  gender: gender ?? _gender,
  dob: dob ?? _dob,
  mobileNumber: mobileNumber ?? _mobileNumber,
  alternateContactNo: alternateContactNo ?? _alternateContactNo,
  emergencyContactNo: emergencyContactNo ?? _emergencyContactNo,
  profileImage: profileImage ?? _profileImage,
  maritalStatus: maritalStatus ?? _maritalStatus,
  permanentAddress: permanentAddress ?? _permanentAddress,
  presentAddress: presentAddress ?? _presentAddress,
  sameAddress: sameAddress ?? _sameAddress,
  dldetails: dldetails ?? _dldetails,
  address: address ?? _address,
);
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get aadharNumber => _aadharNumber;
  String? get panNumber => _panNumber;
  String? get emailId => _emailId;
  String? get gender => _gender;
  String? get dob => _dob;
  String? get mobileNumber => _mobileNumber;
  String? get alternateContactNo => _alternateContactNo;
  String? get emergencyContactNo => _emergencyContactNo;
  String? get profileImage => _profileImage;
  String? get maritalStatus => _maritalStatus;
  PermanentAddress? get permanentAddress => _permanentAddress;
  PresentAddress? get presentAddress => _presentAddress;
  String? get sameAddress => _sameAddress;
  Dldetails? get dldetails => _dldetails;
  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['aadhar_number'] = _aadharNumber;
    map['pan_number'] = _panNumber;
    map['email_id'] = _emailId;
    map['gender'] = _gender;
    map['dob'] = _dob;
    map['mobile_number'] = _mobileNumber;
    map['alternate_contact_no'] = _alternateContactNo;
    map['emergency_contact_no'] = _emergencyContactNo;
    map['profile_image'] = _profileImage;
    map['marital_status'] = _maritalStatus;
    map['address'] = _address;
    if (_permanentAddress != null) {
      map['permanent_address'] = _permanentAddress?.toJson();
    }
    if (_presentAddress != null) {
      map['present_address'] = _presentAddress?.toJson();
    }
    map['same_address'] = _sameAddress;
    if (_dldetails != null) {
      map['dldetails'] = _dldetails?.toJson();
    }
    return map;
  }

}

class Dldetails {
  Dldetails({
      String? dlNumber, 
      String? dlImage, 
      String? dlExpiryDate, 
      String? dlMobileNumber, 
      String? accidentalHistory, 
      String? accidentalDiscription, 
      String? available24by7, 
      String? shiftTimeFrom, 
      String? shiftTimeTo,}){
    _dlNumber = dlNumber;
    _dlImage = dlImage;
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
    _dlImage = json['dl_image'];
    _dlExpiryDate = json['dl_expiry_date'];
    _dlMobileNumber = json['dl_mobile_number'];
    _accidentalHistory = json['accidental_history'];
    _accidentalDiscription = json['accidental_discription'];
    _available24by7 = json['available24by7'];
    _shiftTimeFrom = json['shift_time_from'];
    _shiftTimeTo = json['shift_time_to'];
  }
  String? _dlNumber;
  String? _dlImage;
  String? _dlExpiryDate;
  String? _dlMobileNumber;
  String? _accidentalHistory;
  String? _accidentalDiscription;
  String? _available24by7;
  String? _shiftTimeFrom;
  String? _shiftTimeTo;
Dldetails copyWith({  String? dlNumber,
  String? dlImage,
  String? dlExpiryDate,
  String? dlMobileNumber,
  String? accidentalHistory,
  String? accidentalDiscription,
  String? available24by7,
  String? shiftTimeFrom,
  String? shiftTimeTo,
}) => Dldetails(  dlNumber: dlNumber ?? _dlNumber,
  dlImage: dlImage ?? _dlImage,
  dlExpiryDate: dlExpiryDate ?? _dlExpiryDate,
  dlMobileNumber: dlMobileNumber ?? _dlMobileNumber,
  accidentalHistory: accidentalHistory ?? _accidentalHistory,
  accidentalDiscription: accidentalDiscription ?? _accidentalDiscription,
  available24by7: available24by7 ?? _available24by7,
  shiftTimeFrom: shiftTimeFrom ?? _shiftTimeFrom,
  shiftTimeTo: shiftTimeTo ?? _shiftTimeTo,
);
  String? get dlNumber => _dlNumber;
  String? get dlImage => _dlImage;
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
    map['dl_image'] = _dlImage;
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

class PresentAddress {
  PresentAddress({
      String? address, 
      String? city, 
      String? state, 
      String? pincode,}){
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
  String? _city;
  String? _state;
  String? _pincode;
PresentAddress copyWith({  String? address,
  String? city,
  String? state,
  String? pincode,
}) => PresentAddress(  address: address ?? _address,
  city: city ?? _city,
  state: state ?? _state,
  pincode: pincode ?? _pincode,
);
  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get pincode => _pincode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['pincode'] = _pincode;
    return map;
  }

}

class PermanentAddress {
  PermanentAddress({
      String? address, 
      String? city, 
      String? state, 
      String? pincode,}){
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
  String? _city;
  String? _state;
  String? _pincode;
PermanentAddress copyWith({  String? address,
  String? city,
  String? state,
  String? pincode,
}) => PermanentAddress(  address: address ?? _address,
  city: city ?? _city,
  state: state ?? _state,
  pincode: pincode ?? _pincode,
);
  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get pincode => _pincode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['pincode'] = _pincode;
    return map;
  }

}