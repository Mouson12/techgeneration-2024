import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/l10n/localizations.dart';
import 'package:office_app/config/theme.dart';
import 'package:office_app/features/application/users/cubit/ranking_cubit.dart';
import 'package:office_app/features/common/widgets/splash_screen.dart';
import 'package:office_app/features/data/cubit/alarm_cubit.dart';
import 'package:office_app/features/data/cubit/medication_cubit.dart';
import 'package:office_app/features/data/cubit/sensor_cubit.dart';
import 'package:office_app/features/http_header/header_cubit.dart';
import 'package:office_app/features/languages/cubit/language_cubit.dart';
import 'package:office_app/features/languages/data/languages.dart';
import 'package:office_app/views/login_page.dart';
import 'package:office_app/views/main_page.dart';

void main() {
  runApp(const MainApp());

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => RankingCubit(),
        ),
        BlocProvider(
          create: (context) => HeaderCubit(),
        ),
        BlocProvider(
          create: (context) => MedicationCubit()..loadData(),
        ),
        BlocProvider(
          create: (context) => SensorCubit()..loadData(),
        ),
        BlocProvider(
          create: (context) => AlarmCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(320, 568),
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocBuilder<LanguageCubit, BBLanguages>(
          builder: (context, state) {
            return MaterialApp(
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: state == BBLanguages.en
                  ? const Locale('en')
                  : const Locale('pl'),
              home: const SplashScreen(), // Show SplashScreen first
              theme: BBTheme.theme,
              routes: {
                '/login-page': (context) => const LoginPage(),
                '/main-page': (context) => const MainPage(),
              },
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
