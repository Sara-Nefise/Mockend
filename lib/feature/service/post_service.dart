import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mockend/consts/appString.dart';

import '../model/postModel.dart';

abstract class IPostService {
  // Future<bool> addItemToService(PostModel postModel);
  // Future<bool> putItemToService(PostModel postModel, int id);
  // Future<bool> deleteItemToService(int id);
  Future<List<PostModel>?> fetchPostItems();
}

class PostService implements IPostService {
  final Dio _dio;
  // localhost
  // http://127.0.0.1:3000/
  PostService() : _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000/'));
  @override
  Future<List<PostModel>?> fetchPostItems() async {
    try {
      final response = await _dio.get(_PostServicePaths.posts.name);

      if (response.statusCode == HttpStatus.ok) {
        final _datas = response.data;

        if (_datas is List) {
          return _datas.map((e) => PostModel.fromJson(e)).toList();
        }
      }
    } on DioError catch (exception) {
      _ShowDebug.showDioError(exception, this);
    }
    return null;
  }

  // @override
  // Future<bool> putItemToService(PostModel postModel, int id) {
  //   throw UnimplementedError();
  // }
}

enum _PostServicePaths { posts, comments }

enum _PostQueryPaths { postId }

class _ShowDebug {
  static void showDioError<T>(DioError error, T type) {
    if (kDebugMode) {
      print(error.message);
      print(type);
      print('-----');
    }
  }
}
