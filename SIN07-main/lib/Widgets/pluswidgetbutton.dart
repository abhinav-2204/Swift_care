import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/service/provider/provider.dart';

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

class _PlusButtonWidgetState extends State<PlusButtonWidget1> {
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
                    padding: const EdgeInsets.all(20),
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
                                        filteredOptions = [];
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
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 12),
                        child: ListView.separated(
                          itemCount: filteredOptions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  selectedOption = filteredOptions[index];
                                  print(
                                      "Selected Option: ${filteredOptions[index]}");
                                  isIconAdd = true;
                                  isContainerVisible = false;
                                  _searchController
                                      .clear(); // Clear search after selection
                                  UserModel userModel = appProvider
                                      .getuserInfromation
                                      .copyWith(issue: selectedOption);
                                  appProvider.updateuserinfo(userModel, null);
                                });
                              },
                              title: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    widget.isPrefIconWanted == true
                                        ? Container(
                                            margin: EdgeInsets.only(left: 25),
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQozgaX17jK7trBUQuiie0lyvIHn_INJrAmVA&s"),
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
 

 class PlusButtonWidget1 extends StatefulWidget {
  final String buttonText;
  final List options;
  String? prefiximage;
  bool? isPrefIconWanted = false;
  List? logos;

  PlusButtonWidget1({
    Key? key,
    this.isPrefIconWanted,
    this.prefiximage,
    this.logos,
    required this.buttonText,
    required this.options,
  }) : super(key: key);

  @override
  _PlusButtonWidget1State createState() => _PlusButtonWidget1State();
}

class _PlusButtonWidget1State extends State<PlusButtonWidget1> {
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
                    padding: const EdgeInsets.all(20),
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
                             
                          
                            // Expanded(
                            //   child: Padding(
                            //     padding:
                            //         const EdgeInsets.only(top: 6, bottom: 6),
                            //     child: TextField(
                            //       controller: _searchController,
                            //       onChanged: (value) {
                            //         setState(() {
                            //           if (value.isEmpty) {
                            //             filteredOptions =
                            //                 List.from(widget.options);
                            //           } else {
                            //             filteredOptions = [];
                            //             filteredOptions = widget.options
                            //                 .where((option) => option
                            //                     .toLowerCase()
                            //                     .contains(value.toLowerCase()))
                            //                 .toList();
                            //           }
                            //         });
                            //       },
                            //       decoration: InputDecoration(
                            //         hintText: 'Search',
                            //         border: InputBorder.none,
                            //         hintStyle: TextStyle(
                            //             fontSize: 16,
                            //             fontWeight: FontWeight.w600),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                             
                          ],
                        ),
                      ),
                      Container(
                        height: 275,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 12),
                        child: ListView.separated(
                          itemCount: filteredOptions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  selectedOption = filteredOptions[index];
                                  print(
                                      "Selected Option: ${filteredOptions[index]}");
                                  isIconAdd = true;
                                  isContainerVisible = false;
                                  _searchController
                                      .clear(); // Clear search after selection
                                  UserModel userModel = appProvider
                                      .getuserInfromation
                                      .copyWith(level: selectedOption);
                                  appProvider.updateuserinfo(userModel, null);
                                });
                              },
                              title: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    widget.isPrefIconWanted == true
                                        ? Container(
                                            margin: EdgeInsets.only(left: 25),
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQozgaX17jK7trBUQuiie0lyvIHn_INJrAmVA&s"),
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
 