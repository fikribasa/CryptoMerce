import 'package:intl/intl.dart';

final currencyFormater = new NumberFormat("#,##0", "id_ID");

extension NumberFormater on double {
  String toCurrencyFormat() => currencyFormater.format(this);
}
