import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_app/features/languages/data/languages.dart';

class LanguageCubit extends Cubit<BBLanguages> {
  LanguageCubit() : super(BBLanguages.en);

  void switchLanguage() {
    state == BBLanguages.pl ? emit(BBLanguages.en) : emit(BBLanguages.pl);
  }
}
