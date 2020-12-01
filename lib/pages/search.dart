import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_pro/dataClass/passDataToCoursePage.dart';
import 'package:learn_pro/services/networkHandler.dart';
import 'package:learn_pro/appTheme/appTheme.dart';

import 'course/course.dart';
import 'home/home_component/category.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    InkWell tagTile(String tag) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Category(categoryName: tag)));
        },
        child: Text(
          tag,
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Signika Negative',
            color: Colors.grey,
          ),
        ),
      );
    }

    nestedAppBar() {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 180,
              pinned: true,
              titleSpacing: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/appbar_bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    // width: width - 20.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (text) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Try "Easy ways write a novel"',
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
            ),
          ];
        },
        body: _searchController.text != ""
            ? Container(
                alignment: Alignment.center,
                child: FutureBuilder<List<Courses>>(
                  future: loadProducts(_searchController.text),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CoursePage(
                                        courseData: PassDataToCoursePage(
                                          snapshot.data[index].courseId,
                                          snapshot.data[index].courseImage,
                                          snapshot.data[index].courseName,
                                          snapshot.data[index].courseCategory,
                                          snapshot.data[index].courseRating,
                                          snapshot
                                              .data[index].courseNumberOfRating,
                                          snapshot.data[index].coursePrice,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: 15.0,
                                    left: 15.0,
                                    top: 10.0,
                                    bottom: 10.0,
                                  ),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        blurRadius: 1.5,
                                        spreadRadius: 1.5,
                                        color: Colors.grey[200],
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data[index].courseImage),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                      Container(
                                        width: width - 150.0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  bottom: 4.0,
                                                  right: 8.0,
                                                  left: 8.0),
                                              child: Text(
                                                snapshot.data[index].courseName,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily:
                                                      'Signika Negative',
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.7,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 0.0,
                                                  right: 8.0,
                                                  left: 8.0,
                                                  bottom: 8.0),
                                              child: Text(
                                                snapshot.data[index]
                                                        .coursePrice +
                                                    " ₹",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  height: 1.6,
                                                  fontFamily:
                                                      'Signika Negative',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0.0,
                                                  right: 8.0,
                                                  left: 8.0,
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data[index]
                                                        .courseNumberOfRating,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontFamily:
                                                          'Signika Negative',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 0.7,
                                                      color: headingColor,
                                                    ),
                                                  ),
                                                  SizedBox(width: 3.0),
                                                  Icon(Icons.star, size: 14.0),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.heartBroken,
                                  color: Colors.grey,
                                  size: 60.0,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  'No Item in Courses list',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                    fontFamily: 'Signika Negative',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                ),
              )
            : ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Popular Tags',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'Signika Negative',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        tagTile('Academics'),
                        Divider(),
                        SizedBox(height: 5.0),
                        tagTile('Science and Technology'),
                        Divider(),
                        SizedBox(height: 5.0),
                        tagTile('Finance and Accounting'),
                        Divider(),
                        SizedBox(height: 5.0),
                        tagTile('Development and Programming'),
                        Divider(),
                        SizedBox(height: 5.0),
                        tagTile('IT and Software'),
                        Divider(),
                        SizedBox(height: 5.0),
                        tagTile('Design'),
                        Divider(),
                        SizedBox(height: 5.0),
                        tagTile('Marketing'),
                        Divider(),
                        SizedBox(height: 5.0),
                        tagTile('Photography'),
                        Divider(),
                      ],
                    ),
                  )
                ],
              ),
      );
    }

    return Scaffold(
      body: nestedAppBar(),
    );
  }
}

class Courses {
  String courseId;
  String courseImage;
  String courseName;
  String courseCategory;
  String courseRating;
  String courseNumberOfRating;
  String coursePrice;

  Courses(this.courseId, this.courseImage, this.courseName, this.courseCategory,
      this.courseRating, this.courseNumberOfRating, this.coursePrice);
}

Future<List<Courses>> loadProducts(String searchText) async {
  NetworkHandler networkHandler = NetworkHandler();
  var courseResponse = await networkHandler.get("/course");
  List<dynamic> data = courseResponse["data"];
  List<Courses> courses = [];
  int courcesNum = data.length;

  for (int i = 0; i < courcesNum; i++) {
    Map<String, dynamic> subData = data[i];
    var _list = subData.values.toList();
    String _category = _list[8].toString().toLowerCase();
    String _name = _list[4].toString().toLowerCase();
    if (_category.startsWith(searchText.toLowerCase()) ||
        _name.startsWith(searchText.toLowerCase())) {
      Courses course = Courses(
          _list[3].toString(),
          _list[12].toString(),
          _list[4].toString(),
          _list[8].toString(),
          "4.0",
          "10",
          _list[6].toString());
      courses.add(course);
    }
  }
  return courses;
}
