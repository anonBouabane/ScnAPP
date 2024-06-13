import 'package:get/get.dart';

import '../modules/buy_lottery/buy_lottery_binding.dart';
import '../modules/buy_lottery/buy_lottery_view.dart';
import '../modules/contact/contact_binding.dart';
import '../modules/contact/contact_view.dart';
import '../modules/dashboard/dashboard_binding.dart';
import '../modules/dashboard/dashboard_view.dart';
import '../modules/invoice_detail/invoice_detail_binding.dart';
import '../modules/invoice_detail/invoice_detail_view.dart';
import '../modules/invoice_lottery/invoice_result_binding.dart';
import '../modules/invoice_lottery/invoice_result_view.dart';
import '../modules/invoice_won/invoice_won_binding.dart';
import '../modules/invoice_won/invoice_won_view.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/notify/notify_binding.dart';
import '../modules/notify/notify_view.dart';
import '../modules/payment/payment_binding.dart';
import '../modules/payment/payment_view.dart';
import '../modules/referral/referral_binding.dart';
import '../modules/referral/referral_view.dart';
import '../modules/register/register_binding.dart';
import '../modules/register/register_view.dart';
import '../modules/reward_point/reward_point_binding.dart';
import '../modules/reward_point/reward_point_view.dart';
import '../modules/user_info/user_info_binding.dart';
import '../modules/user_info/user_info_view.dart';
import '../modules/verify_otp/verify_otp_binding.dart';
import '../modules/verify_otp/verify_otp_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;
  static const VERIFY_OTP = Routes.VERIFY_OTP;
  static const REGISTER = Routes.REGISTER;
  static const DASHBOARD = Routes.DASHBOARD;
  static const USER_INFO = Routes.USER_INFO;
  static const CONTACT = Routes.CONTACT;
  static const NOTIFY = Routes.NOTIFY;
  static const REFERRAL = Routes.REFERRAL;
  static const REWARD_POINT = Routes.REWARD_POINT;
  static const REWARD_DETAIL = Routes.REWARD_DETAIL;
  static const BUY_LOTTERY = Routes.BUY_LOTTERY;
  static const INVOICE_RESULT_HISTORY = Routes.INVOICE_RESULT_HISTORY;
  static const PAYMENT = Routes.PAYMENT;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => VerifyOtpView(),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.USER_INFO,
      page: () => const UserInfoView(),
      binding: UserInfoBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT,
      page: () => const ContactView(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFY,
      page: () => const NotifyView(),
      binding: NotifyBinding(),
    ),
    GetPage(
      name: _Paths.REFERRAL,
      page: () => const ReferralView(),
      binding: ReferralBinding(),
      fullscreenDialog: true,
    ),
    GetPage(
      name: _Paths.REWARD_POINT,
      page: () => const RewardPointView(),
      binding: RewardPointBinding(),
    ),
    GetPage(
      name: _Paths.BUY_LOTTERY,
      page: () => const BuyLotteryView(),
      binding: BuyLotteryBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.INVOICE_RESULT_HISTORY,
      page: () => const InvoiceResultView(),
      binding: InvoiceResultBinding(),
    ),
    GetPage(
      name: _Paths.INVOICE_DETAIL,
      page: () => const InvoiceDetailView(),
      binding: InvoiceDetailBinding(),
    ),
    GetPage(
      name: _Paths.INVOICE_WON,
      page: () => const InvoiceWonView(),
      binding: InvoiceWonBinding(),
    ),
  ];
}
