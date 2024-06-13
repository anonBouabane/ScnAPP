class ApiEndpoint {
  static const Duration receiveTimeout = Duration(seconds: 6000);
  static const Duration connectTimeout = Duration(seconds: 6000);

  // static String getBaseUrl() {
  //   String debugEndpoint = 'https://uat-api.scnsoftware.la';
  //   String releaseEndpoint = 'https://api.scnsoftware.la';
  //   return kDebugMode ? debugEndpoint : releaseEndpoint;
  // }

  // static String getPayUrl() {
  //   String debugEndpoint = 'https://uat-pay.scnsoftware.la';
  //   String releaseEndpoint = 'https://pay.scnsoftware.la';
  //   return kDebugMode ? debugEndpoint : releaseEndpoint;
  // }

  // static String getImageUrl() {
  //   String debugEndpoint = 'https://api.scnsoftware.la/images';
  //   String releaseEndpoint = 'https://api.scnsoftware.la/images';
  //   return kDebugMode ? debugEndpoint : releaseEndpoint;
  // }
}
