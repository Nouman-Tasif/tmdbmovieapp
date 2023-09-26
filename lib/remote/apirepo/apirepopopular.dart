import 'package:moviesapiflutterassesment/constants/apiconstants.dart';
import 'package:moviesapiflutterassesment/remote/apiclient/apiclient.dart';
import 'package:moviesapiflutterassesment/remote/models/upcomingMoviesmodel.dart';

class ApiRepoUpcoming {
  getData({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    MovieApiClient(baseUrl: PopularApiConstants.instance.apiUrlUpcoming)
        .request(
      beforeSend: () {
        beforeSend!();
      },
      onSuccess: (data) {
        onSuccess!(UpComingMovie.fromJson(data));
      },
      onError: (error) {
        onError!(error);
      },
    );
  }
}
