import 'package:arc/Features/Posts/Data/Models/posts_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../Core/Failure/exception.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostsModel>> getAllPosts();

  Future<Unit> addPosts(PostsModel postsModel);

  Future<Unit> updatePosts(PostsModel postsModel);

  Future<Unit> deletePosts(int id);
}

const String BaseUrl = "https://jsonplaceholder.typicode.com";

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final Dio dio;

  PostsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PostsModel>> getAllPosts() async {
    dio.options.headers = {
      "Content-Type": "application/json",
    };
    final response = await dio.get("$BaseUrl/posts/");
    if (response.statusCode == 200) {
      // final List decodeJson = json.decode("${response.data}") as List;
      final List decodeJson = response.data;
      final List<PostsModel> postModels = decodeJson
          .map<PostsModel>(
              (jsonPostModel) => PostsModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPosts(PostsModel postsModel) async {
    final data = {
      "title": postsModel.title,
      "body": postsModel.body,
    };
    final response = await dio.post("$BaseUrl/posts/", data: data);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePosts(int id) async {
    dio.options.headers = {
      "Content-Type": "application/json",
    };
    final response = await dio.delete("$BaseUrl/posts/${id.toString()}");
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePosts(PostsModel postsModel) async {
    final postId = postsModel.id.toString();
    final data = {
      "title": postsModel.title,
      "body": postsModel.body,
    };
    final response = await dio.put("$BaseUrl/posts/$postId", data: data);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
