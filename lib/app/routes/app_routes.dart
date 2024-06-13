part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const LOGIN = _Paths.LOGIN;
  static const VERIFY_OTP = _Paths.VERIFY_OTP;
  static const REGISTER = _Paths.REGISTER;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const USER_INFO = _Paths.USER_INFO;
  static const CONTACT = _Paths.CONTACT;
  static const NOTIFY = _Paths.NOTIFY;
  static const REFERRAL = _Paths.REFERRAL;
  static const REWARD_POINT = _Paths.REWARD_POINT;
  static const REWARD_DETAIL = _Paths.REWARD_DETAIL;
  static const BUY_LOTTERY = _Paths.BUY_LOTTERY;
  static const INVOICE_RESULT_HISTORY = _Paths.INVOICE_RESULT_HISTORY;
  static const INVOICE_DETAIL = _Paths.INVOICE_DETAIL;
  static const INVOICE_WON = _Paths.INVOICE_WON;
  static const PAYMENT = _Paths.PAYMENT;
}

abstract class _Paths {
  _Paths._();

  static const LOGIN = '/login';
  static const VERIFY_OTP = '/verify-otp';
  static const REGISTER = '/register';
  static const DASHBOARD = '/dashboard';
  static const USER_INFO = '/user-info';
  static const CONTACT = '/contact';
  static const NOTIFY = '/notify';
  static const REFERRAL = '/referral';
  static const REWARD_POINT = '/reward-point';
  static const REWARD_DETAIL = '/reward-detail';
  static const BUY_LOTTERY = '/buy-lottery';
  static const INVOICE_RESULT_HISTORY = '/invoice-result-history';
  static const INVOICE_DETAIL = '/invoice-detail';
  static const INVOICE_WON = '/invoice-won';
  static const PAYMENT = '/payment';
}
