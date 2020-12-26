import 'package:flutter/material.dart';

const BASE_URL = 'http://maxroof.theiis.com/api';

const loginapi = BASE_URL + '/loginapi';
const companyapi = BASE_URL + '/CompanyAPI';
const projectlistapi = BASE_URL + '/ProjectListAPI?';
const employelist = BASE_URL + '/EmployeesListAPI?';
const AttendanceTypeAPI =
    BASE_URL + '/AttendanceTypeAPI?DatabaseName=IIERPSystem';
const Attendancepostapi = BASE_URL + '/AttendancePostAPI';

const baseURL = '';
const noInternetMsg = 'Oops No Internet';

const msg = 'message';
const status = 'status';
const int timeoutDuration = 30;

// list of colors that we use in our app
const kBackgroundColor = Color(0xFFFEFFFF); //White Background
const kPrimaryColor = Color(0xFF035AA6);
const kSecondaryColor = Color(0xFF95A5A6);
const kTextColor = Color(0xFF273242); //Black Color
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xFF3862FD);
const kLightBlueColor = Color(0xFFE7EEFE);
const kGreyColor = Color(0xFFE7EAF1);
const kDarkGreyColor = Color(0xFF757575);
const kSelectItemColor = Color(0xFF35485d);
const kDeepBlueColor = Color(0xFF594CF5);
const kRedColor = Color(0xFFF65054);
const kGreenColor = Color(0xFF2BD0A8);
const kDarkButtonBg = Color(0xFF273546);
const kTabBarBg = Color(0xFFEEEEEE);
const kTextBlueColor = Color(0xFF5594bf);
const kFormInputColor = Color(0xFFc7c8ca);
const kSectionTileColor = Color(0xFFdddcdd);

const kDefaultPadding = 20.0;

const kDefaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
  borderSide: BorderSide(color: kFormInputColor),
);

const kDefaultFocusInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
  borderSide: BorderSide(color: kBlueColor),
);
const kDefaultFocusErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
  borderSide: BorderSide(color: kRedColor),
);

// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(20, 10),
  blurRadius: 20,
  color: Colors.black12, // Black color with 12% opacity
);
