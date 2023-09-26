import 'package:flutter/material.dart';
import 'package:moviesapiflutterassesment/remote/apirepo/apirepopopular.dart';
import 'package:moviesapiflutterassesment/remote/models/upcomingMoviesmodel.dart';

class ListingApiViewModel with ChangeNotifier {
  UpComingMovie? upComingMovie;

  callTheApi() {
    ApiRepoUpcoming().getData(
      beforeSend: () {
        const CircularProgressIndicator();
        notifyListeners();
      },
      onSuccess: (data) {
        upComingMovie = data;
        notifyListeners();
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }
}
