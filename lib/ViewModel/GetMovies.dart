import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hunelco_tesztfeladat_fazekas_balint/Model/Movie.dart';

class GetMovies{
  Future<http.Response> get(String searchTerm, int pageCount) async {
    final response = await http.get(
      Uri.parse("https://api.themoviedb.org/3/search/movie?query=$searchTerm&page=$pageCount"),
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYjJlYmVmMjRiNDJkYTJjMmViMTRiNjEzYWZhYWFlNyIsInN1YiI6IjYwNThlZDcyNDU1N2EwMDAzZGQ3NDRmNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BLW1e9C5Zk6cYy3Jc1D8YrmPpcuIczXd6zNP-mG5rmU'
      },
    );
    return response;
  }

}