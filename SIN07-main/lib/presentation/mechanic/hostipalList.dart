import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/core/themes.dart';
import 'package:roaddoc/models/Hospital/hospitalDetailsdumpdata.dart';
import 'package:roaddoc/models/Hospital/hospitalModel.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/mechanic/hospitaldetailsveiwpage.dart';


class HospitalListScreen extends StatefulWidget {
  final List<Hospital> list;
  final UserModel userdata;
  HospitalListScreen({
    super.key,
    required this.list,
    required this.userdata,
  });

  @override
  State<HospitalListScreen> createState() => _MechanicHomeScreenState();
}

class _MechanicHomeScreenState extends State<HospitalListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital List ${widget.userdata}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                final hospital = widget.list[index];
                return InkWell(
                    onTap: () {
                      Routes.instance.push(
                          widget: HospitalDetailsScreen(
                            hospital: hospital,
                          ),
                          context: context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        border: Border.all(
                            color: Colors.white,
                            width: 3), // White border with 3px width
                      ),
                      child: ListTile(
                        title: Text(
                          hospital.name,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          hospital.location.name,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final Function() onpress;
  final double radius;
  final Color color;
  final Widget child;
  const CircularButton({
    super.key,
    required this.onpress,
    required this.radius,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: child,
      ),
    );
  }
}
