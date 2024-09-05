 
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/avatarimageProvider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/images.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/core/themes.dart';
import 'package:roaddoc/core/url.dart';
import 'package:roaddoc/function/urlLauncher.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/profileScreen/profileScreen.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel userModel;
  UserDetailScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Routes.instance.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 70,
                  backgroundImage:
                    avatarImageProvider(model:userModel)),
              Gap(20),
              Center(
                child: Container(
                  height: 550,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: listoBoxshadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: TextConfortaa(text: "Details", size: 30)),
                      RowMaptile(
                        icon: Icons.person_3_outlined,
                        value: userModel.name!,
                        size: 18,
                      ),
                      RowMaptile(
                        icon: Icons.mail_outlined,
                        value: userModel.mailid!,
                        size: 18,
                      ),
                      RowMaptile(
                        icon: Icons.code,
                        value: userModel.id.toString(),
                        size: 18,
                      ),
                      detailstile(
                          "${userModel.phoneNumber}", Icons.call_outlined, () {
                        makePhoneCall(
                          userModel.phoneNumber.toString(),
                        );
                      }, true, false),
                       InkWell(
                        onTap: () {
                          launchGoogleMap(
                              latitude: userModel.latitude!,
                              longitude: userModel.longitude!);
                        },
                        child:  RowMaptile(
                                icon: Icons.location_on_outlined,
                                value: userModel.address.toString(),
                                size: 18,
                              ),
                      ),
                      RowMaptile(
                        icon: Icons.calendar_month,
                        value: userModel.date ?? "",
                        size: 18,
                      ),
                      RowMaptile(
                        icon: Icons.payment_outlined,
                        value: userModel.amount ?? "",
                        size: 18,
                      ),
                      userModel.inspectionCategory != ""
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width - 20,
                              child: RowMaptile(
                                icon: Icons.category_outlined,
                                value: userModel.inspectionCategory.toString(),
                                size: 18,
                              ),
                            )
                          : SizedBox(),
                      userModel.inspectionmessage != ""
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width - 20,
                              child: RowMaptile(
                                icon: Icons.message_outlined,
                                value: userModel.inspectionmessage.toString(),
                                size: 18,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class RowMaptile extends StatelessWidget {
  final IconData icon;
  final String value;
  final double size;
  const RowMaptile(
      {required this.icon, required this.value, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Gap(5),
        SizedBox(
            width: 290,
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 30,
              value,
              style: TextStyle(fontFamily: "Comfortaa", fontSize: size),
            )),
      ],
    );
  }
}

//  Primarybutton(
//                 size: 390,
//                 colors: Colors.white,
//                 label: "Navigate",
//                 onpressed: () {
//                   launchGoogleMap(
//                       latitude: userModel.latitude ?? 0,
//                       longitude: userModel.longitude ?? 0);
//                 },
//                 fontsize: 18,
//                 Textcolor: Colors.red,
//                 bordercolor: Colors.black,
//                 borderwidth: 2,
//                 height: 50,
//               ),
