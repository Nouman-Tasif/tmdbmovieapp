class PopularApiConstants {
  PopularApiConstants._();

  static PopularApiConstants? apiinstance;

  static PopularApiConstants get instance{
    if(apiinstance != null){
      return apiinstance!;
    }
    apiinstance = PopularApiConstants._();
    return apiinstance!;
  }

  final apiUrlUpcoming = 'https://api.themoviedb.org/3/movie/upcoming?api_key=df8f2d384e27871dacd96f49465a1d62&language=en-US&page=1';
 //final apiUrlPopular = 'https://api.themoviedb.org/3/movie/popular?api_key=df8f2d384e27871dacd96f49465a1d62&language=en-US&page=1';
}
