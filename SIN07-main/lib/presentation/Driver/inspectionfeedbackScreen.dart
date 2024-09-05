import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/diver_home_screen.dart';
import 'package:roaddoc/presentation/Driver/paymentScreen.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/textfeildeditor.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';
import 'package:roaddoc/service/provider/provider.dart';

class FeedbackScreenDriver extends StatelessWidget {
  final UserModel MechUser;
  FeedbackScreenDriver({
    super.key,
    required this.MechUser,
  });
  TextEditingController inspectionCatogoryController = TextEditingController();
  TextEditingController inspectionMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(listen: false, context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               
             TextConfortaa(text: "Inspection report", size: 40),
              Gap(30),
              textfieldeditor(
                controller: inspectionCatogoryController,
                hintlable: "Problem Category",
              ),
              Gap(30),
              textfieldeditor(
                  controller: inspectionMessageController,
                  hintlable: "Message",
                  maxline: 8),
              Gap(30),
              Center(
                child: Primarybutton(
                  size: 390,
                  colors: Colors.white,
                  label: "Payment",
                  onpressed: () {
                    if (inspectionMessageController.text.isEmpty ||
                        inspectionCatogoryController.text.isEmpty) {
                      showMessage("fill the feedback");
                    } else {
                    Routes.instance.push(
                        widget: PaymentScreen(
                          inceptioncategory: inspectionCatogoryController.text,
                          inspectionMessage: inspectionMessageController.text,
                        ),
                        context: context);
                }
                  },
                  fontsize: 18,
                  Textcolor: Colors.black,
                  bordercolor: Colors.black,
                  borderwidth: 2,
                  height: 80,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
