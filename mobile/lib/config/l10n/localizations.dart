import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_en.dart';
import 'localizations_pl.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('pl'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In pl, this message translates to:
  /// **'Back Buddy'**
  String get appTitle;

  /// Welcome text
  ///
  /// In pl, this message translates to:
  /// **'Cześć, {name}!'**
  String homePageWelcomeText(String name);

  /// No description provided for @homePageTodaySession.
  ///
  /// In pl, this message translates to:
  /// **'Następna dawka:'**
  String get homePageTodaySession;

  /// No description provided for @homePageGoodPosture.
  ///
  /// In pl, this message translates to:
  /// **'Dobra postura'**
  String get homePageGoodPosture;

  /// No description provided for @homePageBadPosture.
  ///
  /// In pl, this message translates to:
  /// **'Zła postura'**
  String get homePageBadPosture;

  /// No description provided for @homePageBreakTime.
  ///
  /// In pl, this message translates to:
  /// **'Czas przerwy'**
  String get homePageBreakTime;

  /// No description provided for @homePageWidgetGood.
  ///
  /// In pl, this message translates to:
  /// **'Twoja postawa jest świetna, tak trzymaj!'**
  String get homePageWidgetGood;

  /// No description provided for @homePageWidgetBreakTime.
  ///
  /// In pl, this message translates to:
  /// **'Myślę, że to czas na kawę ☕'**
  String get homePageWidgetBreakTime;

  /// No description provided for @homePageWidgetBad.
  ///
  /// In pl, this message translates to:
  /// **'Twoja postawa wymaga poprawy. Spróbuj to zmienić!'**
  String get homePageWidgetBad;

  /// No description provided for @homePageWidgetSubTitle.
  ///
  /// In pl, this message translates to:
  /// **'Dzisiaj zdobyłeś już'**
  String get homePageWidgetSubTitle;

  /// Points
  ///
  /// In pl, this message translates to:
  /// **'{points} punktów'**
  String homePageWidgetPoints(int points);

  /// No description provided for @februaryShort.
  ///
  /// In pl, this message translates to:
  /// **'Lut'**
  String get februaryShort;

  /// No description provided for @marchShort.
  ///
  /// In pl, this message translates to:
  /// **'Mar'**
  String get marchShort;

  /// No description provided for @aprilShort.
  ///
  /// In pl, this message translates to:
  /// **'Kwi'**
  String get aprilShort;

  /// No description provided for @points.
  ///
  /// In pl, this message translates to:
  /// **'punkty'**
  String get points;

  /// No description provided for @infoText.
  ///
  /// In pl, this message translates to:
  /// **'Poznaj Back Buddy! Nasza aplikacja rewolucjonizuje pracę biurową, wspierając zdrowie psychiczne i fizyczne. To nie tylko monitorowanie postawy i przerw - Back Buddy to Twoje wsparcie, dbające o komfort i zdrowie.Dzięki zaawansowanej technologii rozpoznawania postawy, wspiera dobre nawyki siedzenia, a także dodaje odrobinę zabawy dzięki grywalizacji. Rywalizuj z kolegami, aby zobaczyć, kto utrzymuje najlepszą postawę i bierze najwięcej przerw. Back Buddy zamienia dbałość o zdrowie w grę, sprawiając, że stajesz się mistrzem ergonomii!Priorytetem jest dla nas także zdrowie psychiczne, dlatego wspieramy relacje między współpracownikami poprzez przyjazną rywalizację. Dołącz do nas i ciesz się produktywnym, wspierającym środowiskiem pracy z Back Buddy!'**
  String get infoText;

  /// No description provided for @logOut.
  ///
  /// In pl, this message translates to:
  /// **'Wyloguj się'**
  String get logOut;

  /// No description provided for @logIn.
  ///
  /// In pl, this message translates to:
  /// **'Zaloguj się'**
  String get logIn;

  /// No description provided for @invalidText.
  ///
  /// In pl, this message translates to:
  /// **'Nieprawidłowy login lub hasło'**
  String get invalidText;

  /// No description provided for @username.
  ///
  /// In pl, this message translates to:
  /// **'Nazwa użytkownika'**
  String get username;

  /// No description provided for @password.
  ///
  /// In pl, this message translates to:
  /// **'Hasło'**
  String get password;

  /// No description provided for @takenMeds.
  ///
  /// In pl, this message translates to:
  /// **'Leki zostały wzięte.'**
  String get takenMeds;

  /// No description provided for @medsToTake.
  ///
  /// In pl, this message translates to:
  /// **'Leki powinny zostać wzięte.'**
  String get medsToTake;

  /// No description provided for @nextDose.
  ///
  /// In pl, this message translates to:
  /// **'Następna dawka za'**
  String get nextDose;

  /// No description provided for @lateDose.
  ///
  /// In pl, this message translates to:
  /// **'Dawka jest opóźniona o:'**
  String get lateDose;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pl': return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
