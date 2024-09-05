import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/models/Hospital/hospitalModel.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/diver_home_screen.dart';
import 'package:roaddoc/presentation/Driver/symtoms.dart';
import 'package:roaddoc/presentation/mechanic/hostipalList.dart';

class SymtomselectionScreen extends StatelessWidget {
  final UserModel driverUser;
  final List<Hospital> sortedHospitals;
  const SymtomselectionScreen({super.key, required this.driverUser, required this.sortedHospitals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Flex(
            direction:Axis.horizontal,
            children:[
               

            
                IconButton(
                    onPressed: () {
                      Routes.instance.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )), 
                    
              ],
            ),
          ),
        
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            children: [ 
              const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: SizedBox(width : 400,child: Text("Select symptom",style : TextStyle(fontSize:20))),
                    ),
                    Gap(20),
              PlusButtonWidget(
                buttonText: items[1],
                options: items,
              ),
              Primarybutton(
                size: 260   ,
                colors: Colors.black,
                label: "countinue",
                fontsize: 20,
                Textcolor: Colors.white,
                onpressed: () {
                  Routes.instance.push(
                      widget: HospitalListScreen(
                        userdata: driverUser,
                        list: sortedHospitals,
                      ),
                      context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
