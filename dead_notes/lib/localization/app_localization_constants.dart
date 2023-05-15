import 'package:flutter/material.dart';
import 'app_localization.dart';

String localeLocalize(BuildContext context) {
  return AppLocalizations.of(context).locale.toString();
}

String homeLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('home');
}

String overviewLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('overview');
}

String finishedInTimeLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('finished_in_time');
}

String deadlinesFailedLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('deadlines_failed');
}

String successRateLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('success_rate');
}

String averageTimeLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('average_time');
}

String pinnedLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('pinned');
}

String daysLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('days');
}

String themeLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('theme');
}

String colorLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('color');
}

String languageLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('language');
}

String settingsLocalize(BuildContext context) {
  return AppLocalizations.of(context).translate('settings');
}