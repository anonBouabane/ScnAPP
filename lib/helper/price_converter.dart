import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PriceConverter {
  static String convertPriceNoCurrency(double price) {
    return '${(price).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  static String convertPriceCurrency(double price) {
    return '${(price).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} ${'kip'.tr}';
  }

  static String convertPriceNoCurrencyByThin(String price) {
    final f = NumberFormat.currency(
        locale: 'en_US', symbol: '', decimalDigits: 0, customPattern: '###.0#');
    return f.format(price);
  }
}
