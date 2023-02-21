import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List _items = [];
  List<int> _index = [];

  int countValue = 2;

  int aspectWidth = 2;

  int aspectHeight = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await readJson();
    });
  }

// Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/products_listing.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["data"]["products"]["items"];
      for (var i = 0; i < _items.length; i++) {
        _index.add(i);
      }
    });
  }
  changeLinear() {
    setState(() {
      countValue = 1;
      aspectWidth = 3;
      aspectHeight = 1;
    });
  }

  changeGrid() {
    setState(() {
      countValue = 2;
      aspectWidth = 2;
      aspectHeight = 1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => changeGrid(),
            child: Text("GridView"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.red))),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          TextButton(
            onPressed: () => changeLinear(),
            child: Text("ListView"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.red),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.red))),
            ),
          ),
        ],
      ),
      Expanded(
        child: GridView.count(
          crossAxisCount: countValue,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: (aspectWidth / aspectHeight),
          children: _index
              .map((data) => GestureDetector(
                  onTap: () {},
                  child:Column(
                    children: [
                      Expanded(
                        flex: 25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1),
                          child: InkWell(
                            onTap: () {},
                            child: GridTile(
                              child: Image.network(
                                _items[data]["small_image"]["url"].toString(),
                                fit: BoxFit.fill,
                              ),
                              footer: Container(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(8.0),
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    _items[data]["price_range"]["maximum_price"]["discount"]["percent_off"].toString()+"%",
                                    style: TextStyle(
                                      backgroundColor:
                                      Colors.white,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          _items[data]["name"].toString(),
                          textAlign: TextAlign.start,
                          style: new TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
            /*   Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(_items[data]["small_image"]["url"].toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                              child: Text(
                                _items[data]["name"].toString(),
                                textAlign: TextAlign.start,
                                style: new TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  color: Color(0xff000000),
                                ),
                              ),
                          ),
                        ),
                      ),
                    ),
                  ),*/
                     /* Expanded(
                        flex: 25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1),
                          child: InkWell(
                            onTap: () {},
                            child: GridTile(
                              child: Image.network(
                                _items[data]["small_image"]["url"].toString(),
                                fit: BoxFit.fill,
                              ),
                              footer: Container(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(8.0),
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    _items[data]["price_range"]["maximum_price"]["discount"]["percent_off"].toString()+"%",
                                    style: TextStyle(
                                      backgroundColor:
                                      Colors.white,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          _items[data]["name"].toString(),
                          textAlign: TextAlign.start,
                          style: new TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),*/
                      ],
                  ),
          )).toList(),
        ),
      ),
    ]));
  }

}