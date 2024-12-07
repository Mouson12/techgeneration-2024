import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';
import 'package:office_app/config/l10n/extensions.dart';
import 'package:office_app/features/application/core/user_client.dart';
import 'package:office_app/features/http_header/header_cubit.dart';
import 'package:office_app/views/main_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  static logIn(String username, String password, BuildContext context) async {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    Map<String, String> headers = {
      'Authorization': basicAuth,
    };
    UserClient client = UserClient();

    final response = await client.logIn(headers);
    print(response);
    context.read<HeaderCubit>().addHeader(headers);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(
          top: 60,
          bottom: 30,
          left: 30.w,
          right: 30.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 100.sp,
                child: Image.asset("assets/img/main-logo.png"),
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              runSpacing: 10,
              children: [
                TextFormField(
                  controller: usernameController,
                  cursorColor: AUColors.lightGreen,
                  style: TextStyle(color: AUColors.white),
                  decoration: InputDecoration(hintText: context.text.username),
                ),
                TextFormField(
                  controller: passwordController,
                  cursorColor: AUColors.lightGreen,
                  style: TextStyle(color: AUColors.white),
                  decoration: InputDecoration(hintText: context.text.password),
                  obscureText: true,
                ),
              ],
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: 200.w,
              child: ElevatedButton(
                onPressed: () async {
                  final response = await logIn(
                    usernameController.text,
                    passwordController.text,
                    context,
                  );
                  if (response == 200) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Future.delayed(Duration(milliseconds: 800));
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: MainPage(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  } else {
                    usernameController.text = "";
                    passwordController.text = "";
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          context.text.invalidText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AUColors.mainGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: AUColors.white,
                      ),
                    );
                  }
                },
                child: Text(
                  context.text.logIn,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
