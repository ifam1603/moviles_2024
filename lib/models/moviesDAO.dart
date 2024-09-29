class MoviesDAO {
  //cuando vemos atributos con ? es que pueden ser propensos a ser nulos 

   int? idMovie;
  String? nameMovie;
  String? overview;
  //String? idGenre;
  String? imgMovie;
  String? releaseDate; 

  MoviesDAO({this.idMovie,this.nameMovie,this.overview,/*this.idGenre,*/this.imgMovie,this.releaseDate});

//constructor nombrado
  factory MoviesDAO.fromMap(Map<String,dynamic> movie){
    return MoviesDAO(
      //idGenre: movie['idGenre'],
      idMovie: movie['idMovie'],
      imgMovie: movie['imgMovie'],
      nameMovie: movie['nameMovie'],
      overview: movie['overview'],
      releaseDate: movie['releaseDate']
    );
  }
}