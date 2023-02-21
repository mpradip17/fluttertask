import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'SectionHeaderDelegate.dart';
import 'ProductListPage.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeListPage extends StatefulWidget {
  const HomeListPage({super.key});

  @override
  HomeListPageState createState() => HomeListPageState();
}

class HomeListPageState extends State<HomeListPage> {
  List _items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await readJson();
    });
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/home_screen.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }
/**
 * Create a SliverList widget Without Header
 * */
  SliverList _getSlivers(List myList, BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int i) {
          return Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 10),
            child: Container(
              height: 200.0,
              width: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _items[i]['items'].length,
                itemBuilder: (context, index) {
                  int lastElement = myList.length - 1;
                  var item = _items[i]['items'];
                  var title = "";
                  var image = "";
                  var description = "";
                  var price = "";
                  var offer_price = "";
                  if (i == lastElement) {
                    title = item[index]['name'] as String;
                    image = item[index]['small_image']["url"] as String;
                    description =
                        item[index]['short_description']["html"] as String;
                    var regular_price_type = item[index]['price_range']
                            ["maximum_price"]["regular_price"]["currency"]
                        as String;
                    var regular_price_value = item[index]['price_range']
                        ["maximum_price"]["regular_price"]["value"] as int;
                    price = regular_price_type + regular_price_value.toString();
                    var final_price_type = item[index]['price_range']
                        ["maximum_price"]["final_price"]["currency"] as String;
                    var final_price_value = item[index]['price_range']
                        ["maximum_price"]["final_price"]["value"] as int;
                    offer_price =
                        "" + final_price_type + final_price_value.toString();
                  } else {
                    title = item[index]['title'] as String;
                    image = item[index]['image'] as String;
                    description = item[index]['description'] as String;
                    price = item[index]['price'] as String;
                    offer_price = item[index]['offer_price'] as String;
                  }
                  var productlabel = item[index]['productlabel'] as String;
                  if (productlabel.isEmpty) {
                    productlabel = "0%";
                  }
                  return Container(
                    width: 100,
                    height: 900,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () {},
                              child: GridTile(
                                child: Image.network(
                                  image,
                                  fit: BoxFit.fill,
                                ),
                                footer: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      textAlign: TextAlign.end,
                                      productlabel,
                                      style: TextStyle(
                                        backgroundColor: Colors.white,
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
                          flex: 1,
                          child: Text(
                            title,
                            textAlign: TextAlign.start,
                            style: new TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            description,
                            textAlign: TextAlign.start,
                            style: new TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0,
                              color: Color(0xffA9A9A9),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text.rich(
                            TextSpan(
                              text: '',
                              children: <TextSpan>[
                                new TextSpan(
                                  text: price,
                                  style: new TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.0,
                                    color: Color(0xffA9A9A9),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                new TextSpan(
                                  text: ' ' + offer_price,
                                  style: new TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffD92E20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
        childCount: myList.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: CustomScrollView(
            slivers: _sliverList(_items.length),
          ),
          /*CustomScrollView(slivers: <Widget>[
              _getSlivers(_items, context),
          ]),*/
        ));
  }
  /**
   * Create a Dynamic Widget with Header and SliverList
   * */
  List<Widget> _sliverList(int size) {
    var widgetList = <Widget>[];
    for (int z = 0; z < size; z++) {
      widgetList
        ..add( SliverAppBar(
          backgroundColor: Colors.transparent,
          pinned: false,
          snap: false,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              _items[z]['title'],
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Color(0xff000000),
                fontSize: 18.0,
              ),
            ),
            titlePadding: EdgeInsetsDirectional.only(
              start: 10.0,
              bottom: 0.0,
              top: 0.0,
            ),
          ),
        ))
        ..add(SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int i) {
              return Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 10),
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _items[z]['items'].length,
                    itemBuilder: (context, index) {
                      int lastElement = _items.length-1;
                      var item = _items[z]['items'];
                      var title = "";
                      var image = "";
                      var description = "";
                      var price = "";
                      var offer_price = "";
                      if (z == lastElement) {
                        title = item[index]['name'] as String;
                        image = item[index]['small_image']["url"] as String;
                        description =
                            item[index]['short_description']["html"] as String;
                        var regular_price_type = item[index]['price_range']
                                ["maximum_price"]["regular_price"]["currency"]
                            as String;
                        var regular_price_value = item[index]['price_range']
                            ["maximum_price"]["regular_price"]["value"] as int;
                        price =
                            regular_price_type + regular_price_value.toString();
                        var final_price_type = item[index]['price_range']
                                ["maximum_price"]["final_price"]["currency"]
                            as String;
                        var final_price_value = item[index]['price_range']
                            ["maximum_price"]["final_price"]["value"] as int;
                        offer_price = "" +
                            final_price_type +
                            final_price_value.toString();
                      } else {

                        title = item[index]['title'] as String;
                        image = item[index]['image'] as String;
                        description = item[index]['description'] as String;
                        price = item[index]['price'] as String;
                        offer_price = item[index]['offer_price'] as String;
                        print("title"+title+ " "+index.toString());
                        print("image"+image+ " "+index.toString());
                        print("description"+description+ " "+index.toString());
                        print("price"+price+ " "+index.toString());
                        print("offer_price"+offer_price+ " "+index.toString());

                      }
                      var productlabel = item[index]['productlabel'] as String;
                      if (productlabel.isEmpty) {
                        productlabel = "0%";
                      }
                      return Container(
                        width: 100,
                        height: 900,
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  onTap: () {},
                                  child: GridTile(
                                    child: Image.network(
                                      image,
                                      fit: BoxFit.fill,
                                    ),
                                    footer: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          textAlign: TextAlign.end,
                                          productlabel,
                                          style: TextStyle(
                                            backgroundColor: Colors.white,
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
                              flex: 1,
                              child: Text(
                                title,
                                textAlign: TextAlign.start,
                                style: new TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                description,
                                textAlign: TextAlign.start,
                                style: new TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.0,
                                  color: Color(0xffA9A9A9),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text.rich(
                                TextSpan(
                                  text: '',
                                  children: <TextSpan>[
                                    new TextSpan(
                                      text: price,
                                      style: new TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.0,
                                        color: Color(0xffA9A9A9),
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    new TextSpan(
                                      text: ' ' + offer_price,
                                      style: new TextStyle(
                                        fontSize: 10.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffD92E20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
           },
            childCount: 1,
          ),
        ));
    }
    return widgetList;
  }

}
