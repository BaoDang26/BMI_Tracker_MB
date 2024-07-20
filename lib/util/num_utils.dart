import 'package:intl/intl.dart';

extension NumberFormatting on num {
  String formatWithThousandSeparator() {
    final formatter = NumberFormat.decimalPattern();
    return formatter.format(this);
  }
}

extension CurrencyFormatting on num {
  String formatAsCurrency({String locale = 'en_US', String symbol = '\$'}) {
    final formatter = NumberFormat.currency(locale: locale, symbol: symbol);
    return formatter.format(this);
  }
}
