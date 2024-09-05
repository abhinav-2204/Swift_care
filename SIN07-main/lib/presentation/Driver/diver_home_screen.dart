import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/loadingindication.dart';
import 'package:roaddoc/Widgets/pluswidgetbutton.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/Widgets/simpletext.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:roaddoc/function/getlocation.dart';
import 'package:roaddoc/models/locationModel/location_model/location_model.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/StatusScreen.dart';
import 'package:roaddoc/presentation/Driver/symtoms.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';
import 'package:roaddoc/service/https/httpsCall.dart';
import 'package:roaddoc/service/provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';

class DriverHomeScreen extends StatelessWidget {
  DriverHomeScreen({super.key});

  String titlelable = "Locate";

  bool isloading = true;

  List<UserModel> listofrequest = [];

// @override
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(listen: true, context);
    appProvider.getCurrentAcceptedMech(
        driverUser: appProvider.getuserInfromation);
    appProvider.getHistoryList(appProvider.getuserInfromation);
    Position position = appProvider.getUserlocation;
    print(position); 

    position.latitude == 0.0 ? isloading = true : isloading = false;
    DateTime now = DateTime.now();

    String hour = (now.hour % 12).toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');

    String period = now.hour >= 12 ? 'PM' : 'AM';
    String currentTime = '$hour:$minute:$period';

    final size = MediaQuery.of(context).size;
    void requestbuttom(String? id) async {
      UserModel userModel = UserModel(id: "");
      if (listofrequest.isNotEmpty) {
        userModel =
            listofrequest.firstWhere((element) => element.id == id, orElse: () {
          listofrequest.add(UserModel(id: ""));
          return UserModel();
        });
      }

      Routes.instance.pop(context);

      if (userModel.id == "") {
        bool uploaded =
            await FirebasefirestoreHelper.instance.uploadRequest(context, id);
        uploaded == true
            ? Routes.instance.push(widget: StatusScreen(), context: context)
            : null;
      } else {
        showMessage("Already requested routing to the status page.");
        Routes.instance.pop(context);
        Routes.instance.push(widget: StatusScreen(), context: context);
      }
    }

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            toolbarHeight: 37,
            title: TextConfortaa(text: "swift care", size: 20),
          ),
          TextConfortaa(text: titlelable, size: 40),
          const SimpleText(lable: "Available drivers Around"),
          Gap(size.height / 5),
          PlusButtonWidget(
            buttonText: items[0], 
            options: items,
          ),
          Gap(20),
          //  PlusButtonWidget1(
          //   buttonText: "Risk level" , 
          //   options: ["hight","medium","low"],
          // ),
          Gap(100),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Primarybutton(
                  Textcolor: Colors.black,
                  height: 60,
                  size: 189,
                  colors: Colors.white,
                  label: "REQUEST AMUBALNCE",
                  onpressed: () async {
                    loaderIndicator(context);
                    appProvider.getUserloaction();
                    Placemark placemark = await getPlaceName(
                        latitude: position.latitude,
                        longitude: position.longitude);

                    LocationModel locationModel = await getLocationDetails(
                        placemark.postalCode.toString());

                    String address =
                        "${placemark.locality}_${locationModel.postOffice?[0].district}_${locationModel.postOffice?[0].state}_${placemark.postalCode}";

                    if (position.altitude == 0 &&
                        position.longitude == 0 &&
                        address.isEmpty) {
                      showMessage("Hold on, setting things up...");
                      Routes.instance.pop(context);
                    } else {
                      appProvider.getCurrentAcceptedMech(
                          driverUser: appProvider.getuserInfromation);
                      listofrequest = appProvider.getDriverRequestlist;

                      UserModel userModel = appProvider.getuserInfromation
                          .copyWith(
                              issue: appProvider.getuserInfromation.issue,
                              time: currentTime,
                              address: address,
                              latitude: position.latitude,
                              longitude: position.longitude);

                      appProvider.updateuserinfo(userModel, null); 

                      if (appProvider.currentAvailableMechUser.id == null) {
                        requestbuttom(appProvider.getuserInfromation.id);
                      } else {
                        Routes.instance.pop(context);

                        showMessage("driver has accepted your request.");
                        Routes.instance
                            .push(widget: StatusScreen(), context: context);
                      }
                    }
                  },
                  bordercolor: Colors.black,
                  borderwidth: 3,
                  fontsize: 18),
              Gap(10),
              Primarybutton(
                  fontsize: 18,
                  Textcolor: Colors.white,
                  height: 60,
                  size: 189,
                  colors: Colors.black,
                  label: "CANCEL REQUEST",
                  onpressed: () {
                    loaderIndicator(context);
                    if (appProvider.currentAvailableMechUser.id == null) {
                      FirebasefirestoreHelper.instance
                          .removeRequest(id: appProvider.getuserInfromation.id);
                      showMessage("Your request has been cancelled.");
                    } else {
                      showMessage("driver has accepted your request.");
                    }

                    Routes.instance.pop(context);
                  })
            ],
          )
        ],
      ),
    ));

    // Gap(size.height / 23),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: [
    //     Primarybutton(
    //         Textcolor: Colors.black,
    //         height: 60,
    //         size: 189,
    //         colors: Colors.white,
    //         label: "REQUEST MECHANIC",
    //         onpressed: () async {
    //           loaderIndicator(context);
    //           appProvider.getUserloaction();
    //           Placemark placemark = await getPlaceName(
    //               latitude: position.latitude,
    //               longitude: position.longitude);

    //           LocationModel locationModel = await getLocationDetails(
    //               placemark.postalCode.toString());

    //           String address =
    //               "${placemark.locality}_${locationModel.postOffice?[0].district}_${locationModel.postOffice?[0].state}_${placemark.postalCode}";

    //           if (position.altitude == 0 &&
    //               position.longitude == 0 &&
    //               address.isEmpty) {
    //             showMessage("Hold on, setting things up...");
    //             Routes.instance.pop(context);
    //           } else {
    //             appProvider.getCurrentAcceptedMech(
    //                 driverUser: appProvider.getuserInfromation);
    //             listofrequest = appProvider.getDriverRequestlist;

    //             UserModel userModel = appProvider.getuserInfromation
    //                 .copyWith(
    //                     time: currentTime,
    //                     address: address,
    //                     latitude: position.latitude,
    //                     longitude: position.longitude);

    //             appProvider.updateuserinfo(userModel, null);

    //             if (appProvider.currentAvailableMechUser.id == null) {
    //               requestbuttom(appProvider.getuserInfromation.id);
    //             } else {
    //               Routes.instance.pop(context);

    //               showMessage("driver has accepted your request.");
    //               Routes.instance
    //                   .push(widget: StatusScreen(), context: context);
    //             }
    //           }
    //         },
    //         bordercolor: Colors.black,
    //         borderwidth: 3,
    //         fontsize: 18),
    //     Primarybutton(
    //         fontsize: 18,
    //         Textcolor: Colors.white,
    //         height: 60,
    //         size: 189,
    //         colors: Colors.black,
    //         label: "CANCEL REQUEST",
    //         onpressed: () {
    //           loaderIndicator(context);
    //           if (appProvider.currentAvailableMechUser.id == null) {
    //             FirebasefirestoreHelper.instance.removeRequest(
    //                 id: appProvider.getuserInfromation.id);
    //             showMessage("Your request has been cancelled.");
    //           } else {
    //             showMessage("driver has accepted your request.");
    //           }

    //           Routes.instance.pop(context);
    //         })
    //   ],
    // )
  }
}

class PlusButtonWidget extends StatefulWidget {
  final String buttonText;
  final List options;
  String? prefiximage;
  bool? isPrefIconWanted = false;
  List? logos;

  PlusButtonWidget({
    Key? key,
    this.isPrefIconWanted,
    this.prefiximage,
    this.logos,
    required this.buttonText,
    required this.options,
  }) : super(key: key);

  @override
  _PlusButtonWidgetState createState() => _PlusButtonWidgetState();
}

class _PlusButtonWidgetState extends State<PlusButtonWidget> {
  bool isIconAdd = true;
  bool isContainerVisible = false;
  late TextEditingController _searchController;
  List filteredOptions = [];
  String selectedOption = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    filteredOptions = List.from(widget.options);
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = isIconAdd ? Colors.black : Colors.white;
    AppProvider appProvider = Provider.of(listen: false, context);
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 13),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isIconAdd = !isIconAdd;
            isContainerVisible = !isContainerVisible;
          });
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    child: Text(
                      selectedOption.isNotEmpty
                          ? selectedOption
                          : widget.buttonText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 21),
                    child: Icon(isIconAdd ? Icons.add : Icons.remove,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isContainerVisible,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff0000000).withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xff2C3E5033).withOpacity(0.2),
                              width: 1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 6, left: 21, bottom: 6),
                              child: Icon(Icons.search,
                                  color: Colors.grey.withOpacity(0.5)),
                            ),
                            const Spacer(),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 6, bottom: 6),
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isEmpty) {
                                        filteredOptions =
                                            List.from(widget.options);
                                      } else {
                                        filteredOptions = widget.options
                                            .where((option) => option
                                                .toLowerCase()
                                                .contains(value.toLowerCase()))
                                            .toList();
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer()
                          ],
                        ),
                      ),
                      Container(
                        height: 275,
                        // height: filteredOptions.length.toDouble() * 40,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 12),
                        child: ListView.separated(
                          itemCount: filteredOptions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  selectedOption = widget.options[index];
                                  isIconAdd = true;
                                  isContainerVisible = false;
                                  UserModel userModel = appProvider
                                      .getuserInfromation
                                      .copyWith(issue: selectedOption);
                                  print(selectedOption);
                                  appProvider.updateuserinfo(userModel, null);
                                });
                              },
                              title: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    widget.isPrefIconWanted == true
                                        ? Container(
                                            margin: EdgeInsets.only(left: 25),
                                            height: 15,
                                            width: 15,
                                            //  color: Colors.red,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQozgaX17jK7trBUQuiie0lyvIHn_INJrAmVA&s"), // dumpy google image
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    Center(
                                      child: Text(
                                        filteredOptions[index],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    widget.isPrefIconWanted == true
                                        ? SizedBox(
                                            height: 10,
                                            width: 10,
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        ),
                      ),
                    ],
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
