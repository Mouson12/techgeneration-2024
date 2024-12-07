import 'localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Back Buddy';

  @override
  String homePageWelcomeText(String name) {
    return 'Hello, $name!';
  }

  @override
  String get homePageTodaySession => 'Next dose in:';

  @override
  String get homePageGoodPosture => 'Good posture';

  @override
  String get homePageBadPosture => 'Bad posture';

  @override
  String get homePageBreakTime => 'Break time';

  @override
  String get homePageWidgetGood => 'Your posture is great, keep it up!';

  @override
  String get homePageWidgetBreakTime => 'I think it\'s time for a coffee ☕';

  @override
  String get homePageWidgetBad => 'Your posture needs improvement. Try to fix it!';

  @override
  String get homePageWidgetSubTitle => 'Today you\'ve already earned';

  @override
  String homePageWidgetPoints(int points) {
    return '$points points';
  }

  @override
  String get februaryShort => 'Feb';

  @override
  String get marchShort => 'Mar';

  @override
  String get aprilShort => 'Apr';

  @override
  String get points => 'points';

  @override
  String get infoText => 'Dive into Back Buddy! Our app revolutionizes office life, supporting mental and physical well-being. It\'s not just about monitoring posture and breaks - Back Buddy is your ultimate ally, ensuring comfort and health.With cutting-edge posture recognition, it fosters good sitting habits and even adds a fun twist with gamification. Compete with colleagues to see who maintains the best posture and takes the most breaks. Back Buddy turns health care into a game, making you an ergonomic pro!We prioritize mental health too, fostering coworker relationships through friendly competition. Join us and enjoy a productive, supportive work environment with Back Buddy!';

  @override
  String get logOut => 'Log Out';

  @override
  String get logIn => 'Log In';

  @override
  String get invalidText => 'Invalid login or password';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get takenMeds => 'Meds have been taken.';

  @override
  String get medsToTake => 'Meds need to be taken.';

  @override
  String get nextDose => 'Next dose in:';

  @override
  String get lateDose => 'The dose is delayed by:';
}
