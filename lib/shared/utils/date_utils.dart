import 'package:intl/intl.dart';

// Formate une date en jj/MM/yyyy
String formatDate(DateTime? d) {
  if (d == null) return '-';
  return DateFormat('dd/MM/yyyy').format(d);
}

// Statut d’expiration simple
enum ExpiryStatus { ok, soon, expired }

ExpiryStatus computeStatus(DateTime? expiry, {int warnDays = 2}) {
  if (expiry == null) return ExpiryStatus.ok;
  final now = DateTime.now();
  if (now.isAfter(expiry)) return ExpiryStatus.expired;
  final diffDays = expiry.difference(now).inDays;
  if (diffDays <= warnDays) return ExpiryStatus.soon;
  return ExpiryStatus.ok;
}