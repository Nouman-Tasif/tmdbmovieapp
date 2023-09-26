import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:moviesapiflutterassesment/view/moviedetailscreen.dart';

import 'package:moviesapiflutterassesment/viewmodel/popularmovie_viewmodel.dart';

import 'package:provider/provider.dart';

class MovieApiListing extends StatefulWidget {
  const MovieApiListing({Key? key}) : super(key: key);

  @override
  State<MovieApiListing> createState() => _MovieApiListingState();
}

class _MovieApiListingState extends State<MovieApiListing> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ListingApiViewModel>(context, listen: false).callTheApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Consumer<ListingApiViewModel>(builder: (context, viewmodel, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const Padding(
            padding: EdgeInsets.only(top: 15, left: 15),
            child: Icon(Icons.menu_rounded, color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 15),
              child: Stack(
                children: [
                  const Icon(
                    Icons.add_alert,
                    size: 30,
                    color: Colors.black,
                  ),
                  Positioned(
                    top: 2.0,
                    right: 2.0,
                    child: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
          title: const Text(
            "FlimKu",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Now Showing",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 20,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2, color: Colors.black54)),
                    child: const Center(
                      child: Text(
                        "see more",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const SpinKitCircle(
                    color: Colors.red,
                    size: 40,
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: viewmodel.upComingMovie?.results?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 5, left: 15),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MovieDetailsScreen(data: index)));
                            },
                            child: Container(
                              height: height * .9,
                              width: width * .4,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 240,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://image.tmdb.org/t/p/w500/"
                                                "${viewmodel.upComingMovie?.results?[index].posterPath}"),
                                            fit: BoxFit.cover)),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10),
                                      child: Text(
                                        viewmodel.upComingMovie?.results?[index]
                                                .title
                                                .toString() ??
                                            "",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${viewmodel.upComingMovie?.results?[index].voteAverage}/10",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "IMDB",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Popular",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 20,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2, color: Colors.black54)),
                    child: const Center(
                      child: Text(
                        "see more",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const SpinKitCircle(
                    color: Colors.red,
                    size: 40,
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: viewmodel.upComingMovie?.results?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey,
                            ),
                            width: width * .9,
                            height: height * .16,
                            child: Row(
                              children: [
                                Container(
                                  width: width * .23,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w500/"
                                            "${viewmodel.upComingMovie?.results?[index].posterPath}" ),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        viewmodel.upComingMovie?.results?[index]
                                                .title
                                                .toString() ??
                                            "",
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 15,
                                          ),
                                          Text(
                                            "${viewmodel.upComingMovie?.results?[index].voteAverage}/10",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text(
                                            "IMDB",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.black54)),
                                            child: const Center(
                                              child: Text(
                                                "see more",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 20,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.black54)),
                                            child: const Center(
                                              child: Text(
                                                "see more",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 20,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.black54)),
                                            child: const Center(
                                              child: Text(
                                                "see more",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.timer,
                                              color: Colors.black,
                                              size: 10,
                                            ),
                                            Text(
                                              viewmodel.upComingMovie?.results?[index].releaseDate
                                                  .toString() ?? " ",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
            ),
          ],
        ),
      );
    });
  }
}

extension Sizedbox on num {
  SizedBox get heightSizedBox => SizedBox(height: toDouble());

  SizedBox get widthsizedbox => SizedBox(width: toDouble());
}
