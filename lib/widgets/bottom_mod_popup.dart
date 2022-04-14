import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomModePopUp extends StatefulWidget {
  int selectedIndex;
  var setFilterData;
  BottomModePopUp(this.selectedIndex, this.setFilterData);
  @override
  _BottomModePopUpState createState() => _BottomModePopUpState();
}

class _BottomModePopUpState extends State<BottomModePopUp> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 100,
          margin: const EdgeInsets.only(top: 50),
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    widget.selectedIndex = 0;
                  });
                  widget.setFilterData(0);
                },
                child: Container(
                  width: size.width,
                  height: 50,
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(width: 0.5, color: Color.fromRGBO(232, 232, 232, 1))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order By Ascending', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black), textAlign: TextAlign.center),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: widget.selectedIndex == 0 ? Colors.black : Colors.black26,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: widget.selectedIndex == 0 ? Colors.black : Colors.black26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    widget.selectedIndex = 1;
                  });
                  widget.setFilterData(1);
                },
                child: Container(
                  width: size.width,
                  height: 50,
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(width: 0.5, color: Color.fromRGBO(232, 232, 232, 1))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order By Descending', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black), textAlign: TextAlign.center),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: widget.selectedIndex == 1 ? Colors.black : Colors.black26,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: widget.selectedIndex == 1 ? Colors.black : Colors.black26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: size.width,
          height: 50,
          padding: const EdgeInsets.only(left: 15),
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.filter_alt_rounded, color: Colors.white),
                  Text('   Filter', style: TextStyle(fontSize: 17, color: Colors.white)),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.clear, size: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
