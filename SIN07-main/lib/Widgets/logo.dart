import 'package:flutter/material.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';

class logoSection extends StatelessWidget {
  const logoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 300,
      child: Column(
        children: [
          Image.asset("assets/logo.png"),
           
          TextConfortaa(text: "Swift Care", size: 40)
        ],
      ),
    ); 
  }
}
