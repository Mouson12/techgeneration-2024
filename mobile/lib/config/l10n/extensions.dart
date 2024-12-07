import 'package:office_app/config/l10n/localizations.dart';
import 'package:flutter/widgets.dart';

extension BuildContextLocalizations on BuildContext {
  AppLocalizations get text => AppLocalizations.of(this)!;
}
