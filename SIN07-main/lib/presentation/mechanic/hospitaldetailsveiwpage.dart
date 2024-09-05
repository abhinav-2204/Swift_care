import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/function/urlLauncher.dart';
import 'package:roaddoc/models/Hospital/hospitalModel.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/presentation/Driver/acceptedMechuserDetailScreen.dart';

class HospitalDetailsScreen extends StatelessWidget {
  final Hospital hospital;

  const HospitalDetailsScreen({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Routes.instance.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text('Hospital Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           
          Expanded(
            child: Center(
              child: Container(
                height: 650,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Center(
                          child: Text("Hospital Details",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold))),
                    ),
                    RowMaptile(
                      icon: Icons.local_hospital,
                      value: hospital.name,
                      size: 25,
                    ),
                    RowMaptile(
                      icon: Icons.location_on_outlined,
                      value: hospital.location.name,
                      size: 25,
                    ),
                    RowMaptile(
                      icon: Icons.phone,
                      value: hospital.contact.phone,
                      size: 25,
                    ),
                    RowMaptile(
                      icon: Icons.email,
                      value: hospital.contact.email,
                      size: 25,
                    ),
                    RowMaptile(
                      icon: Icons.web,
                      value: hospital.contact.website,
                      size: 25,
                    ),
                    RowMaptile(
                      icon: Icons.hotel,
                      value: 'Beds: ${hospital.beds}',
                      size: 25,
                    ),
                    RowMaptile(
                      icon: Icons.medical_services,
                      value: 'Facilities: ${hospital.facilities.join(', ')}',
                      size: 25,
                    ),
                    RowMaptile(
                      icon: Icons.grade,
                      value: 'Accreditation: ${hospital.accreditation}',
                      size: 25,
                    ),
                    Primarybutton(
                      size: 390,
                      colors: Colors.white,
                      label: "Call Hospital",
                      onpressed: () {
                        makePhoneCall(hospital.contact.phone);
                      },
                      fontsize: 18,
                      Textcolor: Colors.red,
                      bordercolor: Colors.black,
                      borderwidth: 2,
                      height: 50,
                    ),
                    Gap(30),
                     Primarybutton(
                      size: 390,
                      colors: Colors.white,
                      label: "Navigate Hospital",
                      onpressed: () {
                          launchGoogleMap(
                            latitude: hospital.location.latitude, longitude: hospital.location.longitude);
                      },
                      fontsize: 18,
                      Textcolor: Colors.red,
                      bordercolor: Colors.black,
                      borderwidth: 2,
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
