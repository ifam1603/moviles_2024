class MoviesDAO {
  //cuando vemos atributos con ? es que pueden ser propensos a ser nulos 

  int? idmovie;
  String? namemovie;
  String?overview;
  String? idgenero;
  String? imgMovie;
  String? releaseDate;

  MoviesDAO({this.idmovie,this.namemovie,this.overview,this.idgenero,this.imgMovie,this.releaseDate});

//constructor nombrado
factory MoviesDAO.fromMap(Map<String,dynamic> movie){
  return MoviesDAO(
    idgenero: movie['idenero'],
    idmovie: movie['idmovie'],
    imgMovie: movie['imgmovie'],
    namemovie: movie['namemovie'],
    overview: movie['overview'],
    releaseDate: movie['releasedate']
  );
 }
}