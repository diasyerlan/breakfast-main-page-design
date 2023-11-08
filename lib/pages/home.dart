import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp5/models/category_model.dart';
import 'package:temp5/models/diet_model.dart';
import 'package:temp5/models/popular_model.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  void initState() {
    // TODO: implement initState
    _getInitialInfo();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            _searchFIeld(),
            SizedBox(height: 40),
            _categoriesSection(),
            SizedBox(height: 40),
            _dietsSection(),
            SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Popular',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: popularDiets[index].boxIsSelected
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: popularDiets[index].boxIsSelected
                                ? [
                                    BoxShadow(
                                        color:
                                            Color(0xff1d1617).withOpacity(0.07),
                                        offset: Offset(0, 10),
                                        blurRadius: 40,
                                        spreadRadius: 0)
                                  ]
                                : []),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              popularDiets[index].iconPath,
                              height: 65,
                              width: 65,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  popularDiets[index].name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                Text(
                                  popularDiets[index].level +
                                      ' | ' +
                                      popularDiets[index].duration +
                                      ' | ' +
                                      popularDiets[index].calorie,
                                  style: TextStyle(
                                      color: Color(0xff7b6f72),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  'assets/icons/button.svg',
                                  height: 30,
                                  width: 30,
                                ))
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 25,
                        ),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    itemCount: popularDiets.length),
              ],
            ),
          ],
        ));
  }

  Column _dietsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text('Recommendation for Diet',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: 15),
        Container(
          height: 240,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                    color: diets[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(diets[index].iconPath),
                    Column(
                      children: [
                        Text(
                          diets[index].name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          diets[index].level +
                              ' | ' +
                              diets[index].duration +
                              ' | ' +
                              diets[index].calorie,
                          style: TextStyle(
                              color: Color(0xff7b6f72),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'View',
                          style: TextStyle(
                              color: diets[index].viewIsSelected
                                  ? Colors.white
                                  : Color(0xffc58bf2),
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      width: 130,
                      height: 45,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            diets[index].viewIsSelected
                                ? Color(0xff9dceef)
                                : Colors.transparent,
                            diets[index].viewIsSelected
                                ? Color(0xff92a3fd)
                                : Colors.transparent
                          ]),
                          borderRadius: BorderRadius.circular(50)),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 25),
            itemCount: diets.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20, right: 20),
          ),
        )
      ],
    );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Category',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 15),
        Container(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => Container(
              width: 25,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                    color: categories[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(categories[index].iconPath),
                      ),
                    ),
                    Text(
                      categories[index].name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Container _searchFIeld() {
    return Container(
      margin: EdgeInsets.only(top: 40, right: 20, left: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0)
      ]),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            filled: true,
            hintText: 'Search Pancake',
            hintStyle: TextStyle(
              color: Color(0xffDDDADA),
              fontSize: 14,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset('assets/icons/Search.svg'),
            ),
            suffixIcon: Container(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VerticalDivider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black,
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/icons/Filter.svg'),
                    ),
                  ],
                ),
              ),
            ),
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Breakfast',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      leading: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            width: 20,
            height: 20,
          ),
          decoration: BoxDecoration(
              color: Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
      actions: [
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            width: 37,
            margin: EdgeInsets.all(10),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
            decoration: BoxDecoration(
                color: Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
