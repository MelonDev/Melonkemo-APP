import 'package:intl/intl.dart';

extension DoubleX on double {

  String get toMoney => NumberFormat("#,##0.00").format(this);
  String get toShortMoney => NumberFormat("#,##0").format(this);


}