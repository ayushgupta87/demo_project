import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';

class MainPageAnimation extends StatefulWidget {
  const MainPageAnimation({Key? key}) : super(key: key);

  @override
  State<MainPageAnimation> createState() => _MainPageAnimationState();
}

class _MainPageAnimationState extends State<MainPageAnimation> {
  late ScrollController _scrollController;

  var opacityValue = 1.0;
  var opacityValueOpposite = 0.0;
  var opacityValueOppositeActual = 0.0;
  var sigma = 0.0;
  bool isExtended = false;
  var showAnimation = 0.0;
  var valueData;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  getValue() {
    valueData = MediaQuery.of(context).size.width * 1.3107692307692307;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getValue();
    _scrollController.addListener(() {
      setState(() {
        var value = 0.0;
        var valueOpposite = 1.0;
        if ((1 - _scrollController.position.pixels / valueData) > 1) {
          value = 1;
          valueOpposite = 0.0;
          opacityValueOppositeActual = 0.0;
          sigma = 0;
        } else if ((1 - _scrollController.position.pixels / valueData) < 0) {
          value = 0;
          valueOpposite = 1.0;
          opacityValueOppositeActual = 1.0;
          sigma = 10;
        } else {
          value = 1 - _scrollController.position.pixels / valueData;
          valueOpposite = _scrollController.position.pixels / valueData;
          opacityValueOppositeActual =
              _scrollController.position.pixels / valueData;
          sigma = (_scrollController.position.pixels * 10) / valueData;
        }
        if (valueOpposite > 0.2) {
          showAnimation = 1.0;
        } else {
          showAnimation = 0.0;
        }
        if (valueOpposite > 0.9) {
          opacityValueOpposite = valueOpposite;
        } else {
          opacityValueOpposite = 0.0;
        }
        opacityValue = value;
      });
    });
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: opacityValue > 0.5
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.flight_takeoff,
                color: Colors.white.withOpacity(opacityValue),
              ),
              backgroundColor: Colors.blue[900]?.withOpacity(opacityValue),
              focusColor: Colors.blue[900]?.withOpacity(opacityValue),
              elevation: opacityValue,
            )
          : FloatingActionButton.extended(
              onPressed: () {},
              label: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  const Text(
                    "Search Flights",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.022,
                          horizontal: MediaQuery.of(context).size.width * 0.04),
                      child: Text(
                        "On Sale",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              icon: const Icon(Icons.flight_takeoff),
              backgroundColor:
                  Colors.blue[900]?.withOpacity(opacityValueOppositeActual),
              focusColor:
                  Colors.blue[900]?.withOpacity(opacityValueOppositeActual),
              elevation: opacityValueOppositeActual,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                  padding: EdgeInsets.only(
                      left: opacityValue > 0.02  ? MediaQuery.of(context).size.width * 0.04 : 0,
                      bottom: MediaQuery.of(context).size.width * 0.005),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(opacityValue),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.width * 0.005,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.015),
                          child: Text(
                            "On Sale",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                color: Colors.white.withOpacity(opacityValue)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Stack(
                        children: [
                          Text(
                            "Eiffel Tower",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.06,
                                color: Colors.white.withOpacity(opacityValue)),
                          ),
                          Center(
                            child: Text(
                              "Eiffel Tower",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  color: Colors.white
                                      .withOpacity(opacityValueOpposite)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Stack(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white54.withOpacity(opacityValue),
                                size: MediaQuery.of(context).size.width * 0.025,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                "Paris, France",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.025,
                                    color: Colors.white54
                                        .withOpacity(opacityValue)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white54
                                    .withOpacity(opacityValueOpposite),
                                size: MediaQuery.of(context).size.width * 0.035,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                "Paris, France",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                    color: Colors.white54
                                        .withOpacity(opacityValueOpposite)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
              background: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                child: Image.asset(
                  "images/asset_image.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
              expandedTitleScale: 1,
            ),
            pinned: true,
            floating: true,
            snap: true,
            actionsIconTheme: const IconThemeData(opacity: 0.0),
            backgroundColor: Colors.transparent,
            expandedHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    buildListViewBuilder(imageList: [
                      "images/image5.jpeg",
                      "images/image4.jpeg",
                      "images/image3.jpeg",
                      "images/asset_image.jpeg",
                      "images/image1.jpeg"
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedOpacity(
                      opacity: opacityValueOppositeActual,
                      duration: const Duration(microseconds: 100),
                      child: AnimatedSwitcher(
                        key: ValueKey<double>(showAnimation),
                        duration: const Duration(milliseconds: 10),
                        child: FadeInUp(
                            child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "Also known as the Latin Quarter, the 5th aggrandisement is home to the Sorbonne university and student-filled cafes. It's also known for its bookshops, including the famed Shakespeare & Company. Family-friendly attractions include the Jardin des Plantes botanical gardens and the National Museum of Natural History. The stately Panthéon building holds the remains of notables like Voltaire and Marie Curi",
                                style: TextStyle(color: Colors.grey[700]),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Read more",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[700]),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: AspectRatio(
                                aspectRatio: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.black,
                                      image: const DecorationImage(
                                          fit: BoxFit.fill,
                                          scale: 1,
                                          image: AssetImage(
                                              'images/banner_image.jpg'))),
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Top Sights",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.062,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.38,
                                      child: Image.asset("images/sights.png")),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Text(
                                              "What is Lorem?",
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04,
                                                  color: Colors.grey[700]),
                                            )),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.4,
                                          child: Text(
                                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(height: 60,),
                  ],
                ),
              ),
            ),
          ])),
        ],
      ),
    );
  }

  buildListViewBuilder1({required List imageList}){
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 110,
      child: GridView.count(
          crossAxisCount: 3,
          // shrinkWrap: true,
          children: List.generate(3, (i) => GridAnimatorWidget(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        scale: 1,
                        image: AssetImage(imageList[i]))),
                width: 90,
                height: 100,
              ),
            ),
          ),).toList()
      ),
    );
  }


  buildListViewBuilder({required List imageList}) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 100,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: imageList.length,
        itemBuilder: (context, i) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    scale: 1,
                    image: AssetImage(imageList[i]))),
            width: 90,
            height: 100,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 15,
          );
        },
      ),
    );
  }
}
