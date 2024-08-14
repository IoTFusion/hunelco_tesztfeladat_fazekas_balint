import 'package:json_annotation/json_annotation.dart';
import 'Result.dart';

part 'Generated/Movie.g.dart';

@JsonSerializable()
class Movie
{
  int page;
  List<Result> results;
  @JsonKey(name: "total_pages")
  int totalPages;
  @JsonKey(name: "total_results")
  int totalResults;

  Movie(this.page, this.results, this.totalPages, this.totalResults);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}