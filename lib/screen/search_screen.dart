import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  List<dynamic> country;
  List<String> countryByCode;
  SearchScreen(this.country, this.countryByCode);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchRes = '';

  searchFun(search) {
    if(widget.countryByCode.contains(search)) {
      for(int i = 0; i < widget.country.length; i++) {
        if(widget.country[i]['code'].contains(search)) {
          setState(() {
            searchRes = widget.country[i]['name'];
          });
        }
      }
    } else {
      Flushbar(
        message: 'Invalid Country Code',
        duration: const Duration(seconds: 3),
        icon: const Icon(CupertinoIcons.exclamationmark_circle, color: Colors.red, size: 20),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromRGBO(240, 241, 242, 1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: TextField(
              autofocus: true,
              cursorColor: Colors.black,
              cursorWidth: 1.5,
              textCapitalization: TextCapitalization.characters,
              style: TextStyle(color: Colors.black, fontSize: 17),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                hintText: ' Search country by country code',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                border: InputBorder.none,
                prefixIcon: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(CupertinoIcons.arrow_left, color: Colors.grey, size: 20),
                ),
                suffixIcon: Icon(CupertinoIcons.search, color: Colors.grey, size: 20),
              ),
              onChanged: (text) {
                setState(() {
                  searchRes = '';
                });
                if(text.length > 1) {
                  searchFun(text);
                }
              },
            ),
          ),
        ),
        body: searchRes != '' ? Container(
          color: Colors.white,
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: size.width - 60, child: Text(searchRes, style: TextStyle(fontSize: 17, color: Colors.black))),
              Icon(CupertinoIcons.arrow_up_right, color: Colors.black12),
            ],
          ),
        ) : Center(child: Text('No data found')),
      ),
    );
  }
}
