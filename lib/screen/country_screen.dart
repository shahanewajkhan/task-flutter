import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/screen/search_screen.dart';
import 'package:task/services/api_services.dart';
import 'package:task/services/custom_progress_circular.dart';
import 'package:task/widgets/bottom_mod_popup.dart';

class CountryScreen extends StatefulWidget {
  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  ApiServices myApi = ApiServices();
  late DialogBuilder _dialogBuilder;
  List<dynamic> country = [];
  List<String> countryByCode = [];
  int selectedIndex = 0;

  getCountries() async{
    try {
      _dialogBuilder.showLoadingIndicator('Loading...');
      var server = await myApi.getCountries('https://api.printful.com/countries');
      _dialogBuilder.hideOpenDialog();
      if(server['code'] == 200) {
        setState(() {
          country = server['result'];
        });
        for(int i = 0; i < country.length; i++) {
          countryByCode.add(country[i]['code']);
        }
        sortFun('ascending');
      } else {
        Flushbar(
          message: 'Internal Server Error!',
          duration: const Duration(seconds: 3),
          icon: const Icon(CupertinoIcons.exclamationmark_circle, color: Colors.red, size: 20),
        ).show(context);
      }
    } catch(e) {
      _dialogBuilder.hideOpenDialog();
      Flushbar(
        message: e.toString(),
        duration: const Duration(seconds: 3),
        icon: const Icon(CupertinoIcons.exclamationmark_circle, color: Colors.red, size: 20),
      ).show(context);
    }
  }

  sortFun(type) {
    if(type == 'ascending') {
      country.sort((a, b) => a["name"].compareTo(b["name"]));
    } else {
      country.sort((a, b) => b["name"].compareTo(a["name"]));
    }
  }

  setFilterData(result) {
    setState(() {
      selectedIndex = result;
    });
    if(result == 0) {
      sortFun('ascending');
    } else {
      sortFun('descending');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    _dialogBuilder = DialogBuilder(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(232, 232, 232, 1),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(country, countryByCode))),
          child: Container(
            height: 40,
            padding: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              color: Color.fromRGBO(240, 241, 242, 1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              children: [
                Icon(CupertinoIcons.search, color: Colors.grey, size: 20),
                Text('    Search country by country code', style: TextStyle(color: Colors.grey, fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
      body: country.isNotEmpty ? ListView.builder(
        itemCount: country.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(bottom: i == country.length - 1 ? 90 :  1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: size.width - 60, child: Text(country[i]['name'], style: TextStyle(fontSize: 17, color: Colors.black))),
                Icon(CupertinoIcons.arrow_up_right, color: Colors.black12),
              ],
            ),
          );
        },
      ) : Center(child: Text('No data found')),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => bottomModSheet(),
        elevation: 0.0,
        child: Icon(Icons.filter_alt_rounded, color: Colors.white),
        backgroundColor: Colors.black,
      ),
    );
  }
  bottomModSheet() {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      isScrollControlled: true,
      builder: (_) => BottomModePopUp(selectedIndex, setFilterData),
    );
  }
}
