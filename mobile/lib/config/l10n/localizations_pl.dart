import 'localizations.dart';

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Back Buddy';

  @override
  String homePageWelcomeText(String name) {
    return 'Cześć, $name!';
  }

  @override
  String get homePageTodaySession => 'Następna dawka:';

  @override
  String get homePageGoodPosture => 'Dobra postura';

  @override
  String get homePageBadPosture => 'Zła postura';

  @override
  String get homePageBreakTime => 'Czas przerwy';

  @override
  String get homePageWidgetGood => 'Twoja postawa jest świetna, tak trzymaj!';

  @override
  String get homePageWidgetBreakTime => 'Myślę, że to czas na kawę ☕';

  @override
  String get homePageWidgetBad => 'Twoja postawa wymaga poprawy. Spróbuj to zmienić!';

  @override
  String get homePageWidgetSubTitle => 'Dzisiaj zdobyłeś już';

  @override
  String homePageWidgetPoints(int points) {
    return '$points punktów';
  }

  @override
  String get februaryShort => 'Lut';

  @override
  String get marchShort => 'Mar';

  @override
  String get aprilShort => 'Kwi';

  @override
  String get points => 'punkty';

  @override
  String get infoText => 'Poznaj Back Buddy! Nasza aplikacja rewolucjonizuje pracę biurową, wspierając zdrowie psychiczne i fizyczne. To nie tylko monitorowanie postawy i przerw - Back Buddy to Twoje wsparcie, dbające o komfort i zdrowie.Dzięki zaawansowanej technologii rozpoznawania postawy, wspiera dobre nawyki siedzenia, a także dodaje odrobinę zabawy dzięki grywalizacji. Rywalizuj z kolegami, aby zobaczyć, kto utrzymuje najlepszą postawę i bierze najwięcej przerw. Back Buddy zamienia dbałość o zdrowie w grę, sprawiając, że stajesz się mistrzem ergonomii!Priorytetem jest dla nas także zdrowie psychiczne, dlatego wspieramy relacje między współpracownikami poprzez przyjazną rywalizację. Dołącz do nas i ciesz się produktywnym, wspierającym środowiskiem pracy z Back Buddy!';

  @override
  String get logOut => 'Wyloguj się';

  @override
  String get logIn => 'Zaloguj się';

  @override
  String get invalidText => 'Nieprawidłowy login lub hasło';

  @override
  String get username => 'Nazwa użytkownika';

  @override
  String get password => 'Hasło';

  @override
  String get takenMeds => 'Leki zostały wzięte.';

  @override
  String get medsToTake => 'Leki powinny zostać wzięte.';

  @override
  String get nextDose => 'Następna dawka za';

  @override
  String get lateDose => 'Dawka jest opóźniona o:';
}
