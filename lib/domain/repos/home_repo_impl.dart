// ignore_for_file: avoid_print

import 'package:movies/core/string_constants.dart';
import 'package:movies/data/api/api_constants.dart';
import 'package:movies/data/api/api_error_handler.dart';
import 'package:movies/data/api/api_result.dart';
import 'package:movies/data/api/api_service.dart';
import 'package:movies/domain/entities/popular_movies_entity.dart';
import 'package:movies/domain/entities/recommendation_movies_entity.dart';
import 'package:movies/domain/entities/upcoming_movies_entity.dart';

class HomeRepoImpl{
  final ApiService apiService;

  HomeRepoImpl({required this.apiService});

  Future<ApiResult<List<PopularMoviesEntity>>> getPopularMovies() async {
    try {
      final response = await apiService.getPopularMovies(ApiConstants.apiToken);
      List<PopularMoviesEntity> popularMovies = response.results!
          .map((movie) => PopularMoviesEntity(
                id: movie.id!,
                title: movie.title!,
                year: movie.releaseDate!.year.toString(),
                poster: '${StringConstants.imageBaseUrl}${movie.posterPath!}',
        backgroundPoster: '${StringConstants.imageBaseUrl}${movie.backdropPath!}',
              ),)
          .toList();
      return ApiResult.success(popularMovies);
    } catch (error) {
      print(error.toString());
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<UpcomingMoviesEntity>>> getUpcomingMovies() async {
    try {
      final response = await apiService.getUpcomingMovies(ApiConstants.apiToken);
      List<UpcomingMoviesEntity> upcomingMovies = response.results!
          .map((movie) => UpcomingMoviesEntity(
                id: movie.id!,
                poster: '${StringConstants.imageBaseUrl}${movie.posterPath!}',
              ),)
          .toList();
      return ApiResult.success(upcomingMovies);
    } catch (error) {
      print(error.toString());
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<RecommendationMoviesEntity>>> getRecommendationMovies() async {
    try {
      final response = await apiService.getRecommendationMovies(ApiConstants.apiToken);
      List<RecommendationMoviesEntity> recommendationMovies = response.results!
          .map((movie) => RecommendationMoviesEntity(
                id: movie.id!,
                title: movie.title!,
                year: movie.releaseDate!.year.toString(),
                poster: '${StringConstants.imageBaseUrl}${movie.posterPath!}',
                voteAverage: movie.voteAverage!.toString(),
              ),)
          .toList();
      return ApiResult.success(recommendationMovies);
    } catch (error) {
      print(error.toString());
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}