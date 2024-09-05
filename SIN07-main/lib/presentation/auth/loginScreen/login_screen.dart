import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/loadingindication.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/Widgets/showtext.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/core/verificationfunc.dart';
import 'package:roaddoc/presentation/auth/registerScreen/registerscreen.dart';
import 'package:roaddoc/presentation/auth/registerScreen/user_select-Screen.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/passwordtextfield.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/textfeildeditor.dart';
import 'package:roaddoc/presentation/splashScreen/splashScreen.dart';
import 'package:roaddoc/service/firebase/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController passwordTextEditingController = TextEditingController();

  TextEditingController mailIdTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextConfortaa(text: "Log in", size: 40),
              const Gap(10),
              textfieldeditor(
                  maxline: 1,
                  controller: mailIdTextEditingController,
                  hintlable: "Mail id"),
              const Gap(10),
              PasswordTextField(
                  passwordcontroller: passwordTextEditingController),
              Gap(20),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    showText(
                        //if Screen type == login  the Display "Don't have an account !"
                        label: "Don't have an account !",
                        size: 16,
                        color: Color.fromARGB(255, 73, 73, 73)),
                    const Gap(10),
                    InkWell(
                      onTap: () {
                        Routes.instance.pushreplace(
                            widget: usertypeSelectionScreen(),
                            context: context);
                      },
                      child: showText(
                          //if Screen type == login  the Display "Don't have an account !"
                          label: "SignUp here",
                          size: 16,
                          color: const Color.fromARGB(255, 1, 88, 202)),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Primarybutton(
                  onpressed: () async {
                    loaderIndicator(context);
                    bool isvalidated = loginvalidation(
                      mailIdTextEditingController.text,
                      passwordTextEditingController.text,
                    );

                    if (isvalidated) {
                      bool isregistered = await FireBaseAuthHelper.instance
                          .login(mailIdTextEditingController.text,
                              passwordTextEditingController.text, context);

                      if (isregistered) {
                        Routes.instance.pop(context);

                        Routes.instance.pushandRemoveUntil(
                            widget: const SplashScreen(), context: context);
                      }
                    } else {
                      Routes.instance.pop(context);
                    }

                    // }
                  },
                  height: 55,
                  size: double.infinity,
                  colors: Colors.black,
                  label: "LOG IN",
                  fontsize: 18,
                  Textcolor: Colors.white),
              Gap(20),
              Primarybutton(
                  onpressed: () async {
                    bool isregistered = await FireBaseAuthHelper.instance
                        .signInAnonymously(context);
                    if (isregistered != true) {
                      Routes.instance.pop(context);
                    } else {
                      Routes.instance.pop(context);

                      Routes.instance.pushandRemoveUntil(
                          widget: const SplashScreen(), context: context);
                    }
                  },
                  height: 55,
                  size: double.infinity,
                  colors: Colors.black,
                  label: "LOGIN AS GUEST ",
                  fontsize: 18,
                  Textcolor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
