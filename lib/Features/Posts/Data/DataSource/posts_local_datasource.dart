import 'dart:convert';

import 'package:arc/Core/Failure/exception.dart';
import 'package:arc/Features/Posts/Data/Models/posts_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSource {
  Future<List<PostsModel>> getCachePosts();

  Future<Unit> cachePosts(List<PostsModel> postModel);
}

const String Key = "Cache_Posts";

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostsModel> postModel) {
    List postModelToJson = postModel
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(Key, jsonEncode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostsModel>> getCachePosts() {
    final jsonString = sharedPreferences.get(Key);
    if (jsonString != null) {
      List decodeJson = json.decode("$jsonString");
      List<PostsModel> jsonToPostModel = decodeJson
          .map<PostsModel>(
              (jsonPostModel) => PostsModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
