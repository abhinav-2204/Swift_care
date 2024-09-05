import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/logo.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/type_of_users.dart';

import 'package:roaddoc/presentation/auth/registerScreen/registerscreen.dart';

class usertypeSelectionScreen extends StatelessWidget {
  const usertypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios))),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            logoSection(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Primarybutton(
                    bordercolor: Colors.black,
                    borderwidth: 2,
                    size: 180,
                    colors: Colors.white,
                    label: "As A Patient",
                    onpressed: () {
                      Routes.instance.push(
                          widget: RegisterScreen(type: usertype.DRIVER),
                          context: context);
                    },
                    fontsize: 18,
                    Textcolor: Colors.black),
                Gap(50),
                Primarybutton(
                    bordercolor: Colors.black,
                    borderwidth: 2,
                    size: 180,
                    colors: Colors.white,
                    label: "As A Driver",
                    onpressed: () {
                      Routes.instance.push(
                          widget: RegisterScreen(type: usertype.MECHANIC),
                          context: context);
                    },
                    fontsize: 18,
                    Textcolor: Colors.black),
              ],
            ),
            const Gap(40),
          ],
        ),
      ),
    );
  }
}
