import 'package:flutter/material.dart';
import 'app_localization.dart';

String localeLocalize(BuildContext context) {
  return AppLocalizations.of(context).locale.toString();
}

String homeLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('home');
}

String noteLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('note');
}