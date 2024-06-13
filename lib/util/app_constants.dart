import '../data/model/response/language_model.dart';
import 'images.dart';

class AppConstants {
  static const String APP_NAME = 'SCN Easy';

  // dynamic base url
  // static const String BASE_URL = kDebugMode
  //     ? 'https://uat-api.scnsoftware.la'
  //     : 'https://api.scnsoftware.la';

  // dynamic lottery url
  // static const String LOTTERY_PAYMENT = kDebugMode
  //     ? 'https://uat-pay.scnsoftware.la'
  //     : 'https://pay.scnsoftware.la';

  // Local
  // static const String BASE_URL = 'http://172.22.6.40:8089';
  // static const String LOTTERY_PAYMENT = 'http://172.22.41.57:8005';

  // Development
  // static const String BASE_URL = 'https://uat-api.scnsoftware.la';
  // static const String LOTTERY_PAYMENT = 'https://uat-pay.scnsoftware.la';

  // Production
  static const String BASE_URL = 'https://api.scnsoftware.la';
  static const String LOTTERY_PAYMENT = 'https://pay.scnsoftware.la';

  ///Auth
  static const String REGISTER_URI = '/api/v1/auth/sign-up';
  static const String LOGIN_URI = '/Api/Auth/Customer/Login';
  // static const String SEND_OTP_LOGIN = '/api/v1/auth/login/send-otp';
  static const String TOKEN_URI = '/api/Customer/CreateDeviceToken';
  // static const String TOKEN_URI = '/api/v1/device-token';

  ///User account
  static const String SEND_OTP = '/Api/Auth/OTP';
  // static const String VERIFY_OTP = '/api/v1/otp/verify';

  // ContactUs
  static const String CONTACT_US = '/Api/ContactUs';

  // Notification URI
  static const String NOTIFICATION_URI = '/Api/Customer/Notification';

  ///Customer
  static const String CUSTOMER_INFO_URI = '/Api/Customer/Profile';
  static const String UPDATE_CUSTOMER_PROFILE = '/Api/Customer/ProfileImage';

  ///Lottery Section
  static const String LOTTERY_HISTORY = "/Api/Lotto/UpdateWinHistory?";
  static const String LOTTERY_BUY = "/Api/Lotto/Buy";
  static const String LOTTERY_POINT = "/Api/Lotto/Points?limit=30&custPhone=";
  static const String LOTTERY_BONUS = "/Api/Lotto/Bonus?limit=30&custPhone=";
  static const String LOTTERY_BONUS_DETAILS =
      "/Api/Lotto/Bonus/Details?drawId=";
  static const String LOTTERY_INVOICE =
      "/Api/Lotto/invoice?limit=20&custPhone=";

  static const String LOTTERY_HISTORY_BY_THIN = '/Api/Lotto/UpdateWinHistory';
  static const String LOTTERY_INVOICE_BY_THIN = '/Api/Lotto/invoice';
  static const String LOTTERY_REWARD_DETAIL_BY_THIN =
      '/Api/Lotto/Bonus/Details';
  static const String LOTTERY_BONUS_POINT_REFERRAL_BY_THIN =
      '/Api/Lotto/Bonus/Referral';
  static const String LOTTERY_CHECK_REWARD_ID_BY_THIN =
      '/Api/Lotto/CustomerReward';
  static const String LOTTERY_REWARD_BY_THIN = "/Api/Lotto/Bonus";
  static const String LOTTERY_POINT_BY_THIN = "/Api/Lotto/Points";
  static const String LOTTERY_BUY_BY_THIN = "/Api/Lotto/Buy";
  static const String LOTTERY_PAY_WITH_POINT_BY_THIN = "/Api/Lotto/Payment";
  static const String LOTTERY_INVOICE_DETAIL_BY_THIN =
      "/Api/Lotto/Invoice/Details";

  /// Payment endpoint
  static const String PAYMENT_BANK_LIST_BY_THIN = "/api/v1/payment/banks";
  static const String PAYMENT_GET_PAYMENT_CODE_BY_THIN =
      "/api/v1/payment/get-payment-code";

  static const String LOTTERY_INVOICE_DETAIL =
      "/Api/Lotto/Invoice/Details?custPhone=";
  static const String LOTTERY_BONUS_POINT_REFERRAL =
      "/Api/Lotto/Bonus/Referral?custPhone=";
  static const String LOTTERY_DASHBOARD =
      "/Api/Lotto/UpdateWinHistory?limit=2&offset=0";
  static const String LOTTERY_POINT_PAYMENT = "/Api/Lotto/Payment?custPhone=";
  static const String LOTTERY_CHECK_REWARD_ID =
      "/Api/Lotto/CustomerReward?custPhone=";
  static const String CHECK_LOT_OPEN_CLOSE = "/Api/Lotto/RoundOpenCheck";

  /// Shared Key
  static const String THEME = 'scn_theme';
  static const String TOKEN = 'scn_token';
  static const String COUNTRY_CODE = 'scn_country_code';
  static const String LANGUAGE_CODE = 'scn_language_code';
  static const String USER_NUMBER = 'phone';

  ///M-Money
  static const String CONFIRM_CASH_OUT =
      "/api/v1/payment/confirm-mmoney-cash-out";

  ///Bank key and bank section
  static const String BANK_LIST = "/Api/Bank";
  static const String BCEL_SUBSCRIBE_KEY =
      "sub-c-91489692-fa26-11e9-be22-ea7c5aada356";
  static const String BCEL_USER_KEY = "BCELBANK";

  // static const String PUBLIC_KEY = "pub-c-ee6d64ab-a227-4994-aa5c-6f0b2995f167";
  // static const String SUBSCRIBE_KEY = "sub-c-3ca6b0bd-7419-4143-84c9-34878606f493";
  // static const String USER_KEY = "ef2bc377-97cf-42c5-882b-3b20e70ae96f";

  static const String GET_BANK_LIST = "/api/v1/payment/banks?company_id=";
  static const String LAO_VIET_PAYMENT = "/api/v1/payment/get-payment-code";
  static const String PAYMENT_KEY =
      "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRfbmFtZSI6IlNYQUxMIiwiaWF0IjoxNjgyMzI1NjgxLCJleHAiOjMyNTkxMjU2ODF9.J2qhnCfNvUt6EpR5b_PMqOdz1AMB23_Bq2HvA5KuUpdypc1LZg9k4EmO9BFamzrDw9PxvzVdiADkndiD5Ri81VaGddJabkt723tYcwb-xIWE31pbD1qDrcSIrzjERslqsIjmnlitabPjmSFqNpItayYbPS79RUXauC7tAQ5rZ5MP3qKbaAiDZU4EwBW7Z0mw8wFOpSfgxL6YeU0014L5aZcogMwkgaQklAfL8L21QjTue0FAAYuG__RGXpcfE0KnodKGBKETeNXPSuurKq5oWZn2xrPG6G4K4jRrutAitvaAqiRR1v2ygkohH-VqAMqlXKe7L6l-MvextTnR8Mzk9Q";

  // static const String API_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2NjY5MjkxMzUsImV4cCI6MzI0MzcyOTEzNX0.kLTl2knz1tHhACqOBWTpyvbk2J5btNsZPZW0oj4l794";

  /// LVB Pubnub Key
  // static const String LVB_PUBNUB_PUBLIC_KEY = "pub-c-ee6d64ab-a227-4994-aa5c-6f0b2995f167";
  // static const String LVB_PUBNUB_SUBSCRIBE_KEY = "sub-c-3ca6b0bd-7419-4143-84c9-34878606f493";
  // static const String LVB_PUBNUB_USER_ID = "ef2bc377-97cf-42c5-882b-3b20e70ae96f";

  /// Pubnub new Key
  static const String PUBNUB_PUBLIC_KEY =
      'pub-c-36a6c09c-2a9d-4725-9c4e-334f0ebd864b';
  static const String PUBNUB_SUBSCRIBE_KEY =
      'sub-c-2e823907-ca60-417f-b47a-b2fe0db3433a';
  static const String PUBNUB_USER_ID = "ef2bc377-97cf-42c5-882b-3b20e70ae96f";
  // static const String PUBNUB_SECRET_KEY = 'sec-c-Nzk0YTlhZDQtYjkzNC00MmI2LWI2ZmItNTIyYjZhMjA1ZDYw';

  /// Pubnub for JDB
  // static const String JDB_PUBNUB_SUBSCRIBE_KEY = 'sub-c-3014e386-6988-47bb-9fe0-2c5d7a61544c';
  // static const String JDB_PUBNUB_USER_ID = '0e177d4c-27kf-1269-8653-06bh98r8a4f8';
  // static const String JDB_DYNAMIC_QR_URL = 'https://dynamicqr.jdbbank.com.la:12000/api/uat/dynamic';

  //Lottery
  static const String NUMBER_LIST = 'scn_number_list';
  static const String TOPIC = 'scn';

  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: Images.laoFlag,
      languageName: 'lao',
      countryCode: 'LA',
      languageCode: 'lo',
    ),
    LanguageModel(
      imageUrl: Images.engFlag,
      languageName: 'english',
      countryCode: 'US',
      languageCode: 'en',
    ),
  ];
}
