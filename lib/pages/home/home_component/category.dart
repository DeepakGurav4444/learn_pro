import 'package:flutter/material.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/dataClass/passDataToCoursePage.dart';
import 'package:learn_pro/pages/course/course.dart';
import 'package:learn_pro/services/networkHandler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category extends StatefulWidget {
  final String categoryName;
  Category({Key key, @required this.categoryName}) : super(key: key);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    String categoryName = widget.categoryName;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: textColor,
        titleSpacing: 0.0,
        title: Text(
          categoryName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Signika Negative',
            letterSpacing: 0.7,
            height: 1.5,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<List<Courses>>(
          future: loadProducts(categoryName),
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
                                  snapshot.data[index].courseNumberOfRating,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data[index].courseImage),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              Container(
                                width: width - 150.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          fontFamily: 'Signika Negative',
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
                                        snapshot.data[index].coursePrice + " ₹",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          height: 1.6,
                                          fontFamily: 'Signika Negative',
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
                                              fontFamily: 'Signika Negative',
                                              fontWeight: FontWeight.w700,
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
      ),
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

Future<List<Courses>> loadProducts(String categoryName) async {
  NetworkHandler networkHandler = NetworkHandler();
  var courseResponse = await networkHandler.get("/course");
  List<dynamic> data = courseResponse["data"];
  List<Courses> courses = [];
  int courcesNum = data.length;

  for (int i = 0; i < courcesNum; i++) {
    Map<String, dynamic> subData = data[i];
    var _list = subData.values.toList();
    if (categoryName == 'All') {
      Courses course = Courses(
          _list[3].toString(),
          _list[12].toString(),
          _list[4].toString(),
          _list[8].toString(),
          "4.0",
          "10",
          _list[6].toString());
      courses.add(course);
    } else if (categoryName == _list[8].toString()) {
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
