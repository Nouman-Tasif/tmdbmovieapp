import 'package:flutter/material.dart';

import 'package:moviesapiflutterassesment/viewmodel/popularmovie_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class MovieDetailsScreen extends StatefulWidget {
  int data;
  MovieDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )..initialize().then((_) {
        setState(() {});
      });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ListingApiViewModel>(context, listen: false).callTheApi();
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Consumer<ListingApiViewModel>(builder: (context, viewmodel, _) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Container(
                  width: width * 1,
                  height: height * .3,
                  color: Colors.red,
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
                ),
                Positioned(
                  top: 50,
                  bottom: 50,
                  left: 150,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                      iconSize: 40,
                      color: Colors.grey),
                ),
                Positioned(
                  top: 30,
                  right: 3,
                  left: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        const Icon(
                          Icons.linear_scale,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            viewmodel.upComingMovie!.results![widget.data].title
                                .toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Icon(
                            Icons.bookmark_border,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      10.heightSizedBox,
                      const Text(
                        "Home",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      10.heightSizedBox,
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          5.widthsizedbox,
                          Text(
                            "${viewmodel.upComingMovie!.results![widget.data].voteAverage}/10",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          5.widthsizedbox,
                          const Text(
                            "IMDB",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      10.heightSizedBox,
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 2, color: Colors.black54)),
                            child: const Center(
                              child: Text(
                                "see more",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              ),
                            ),
                          ),
                          10.widthsizedbox,
                          Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 2, color: Colors.black54)),
                            child: const Center(
                              child: Text(
                                "see more",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              ),
                            ),
                          ),
                          10.widthsizedbox,
                          Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 2, color: Colors.black54)),
                            child: const Center(
                              child: Text(
                                "see more",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      10.heightSizedBox,
                      Row(
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Length",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                              ),
                              5.heightSizedBox,
                              const Text(
                                "2h 28min ",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          15.widthsizedbox,
                          Column(
                            children: [
                              const Text(
                                "Length",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                              ),
                              5.heightSizedBox,
                              const Text(
                                "2h 28min ",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          15.widthsizedbox,
                          Column(
                            children: [
                              const Text(
                                "Length",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                              ),
                              5.heightSizedBox,
                              const Text(
                                "2h 28min ",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                      20.heightSizedBox,
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      10.heightSizedBox,
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            viewmodel
                                .upComingMovie!.results![widget.data].overview
                                .toString(),
                            maxLines: 5,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.red),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Cast",
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
                                  border: Border.all(
                                      width: 2, color: Colors.black54)),
                              child: const Center(
                                child: Text(
                                  "see more",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.heightSizedBox,
                      Container(
                        height: 100,
                        width: double.maxFinite,
                        margin: const EdgeInsets.only(left: 1),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/moviepic.jpg"),
                                            fit: BoxFit.cover)),
                                  ),
                                  10.heightSizedBox,
                                  const Text(
                                    "Movie name",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  )
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
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
