import 'package:arc/Features/Posts/Data/DataSource/posts_local_datasource.dart';
import 'package:arc/Features/Posts/Data/DataSource/posts_remote_datasource.dart';
import 'package:arc/Features/Posts/Data/Repository/posts_repository.dart';
import 'package:arc/Features/Posts/Domain/Repository/base_posts_repository.dart';
import 'package:arc/Features/Posts/Domain/UseCase/add_posts_usecase.dart';
import 'package:arc/Features/Posts/Domain/UseCase/delete_posts_usecase.dart';
import 'package:arc/Features/Posts/Domain/UseCase/get_all_posts_usecase.dart';
import 'package:arc/Features/Posts/Domain/UseCase/update_posts_usecase.dart';
import 'package:arc/Features/Posts/Persentation/Bloc/crud/crud_bloc.dart';
import 'package:arc/Features/Posts/Persentation/Bloc/posts_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Core/Network/network.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// features * posts
  // Bloc **
  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(() => CrudBloc(
        addPostsUseCase: sl(),
        deletePostsUseCase: sl(),
        updatePostsUseCase: sl(),
      ));
  // UseCase **
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostsUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostsUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostsUseCase(sl()));

  // Repository **
  sl.registerLazySingleton<BasePostsRepository>(() => PostsRepository(
        postsRemoteDataSource: sl(),
        postsLocalDataSource: sl(),
        networkInfo: sl(),
      ));
  // Data Sources **
  sl.registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<PostsLocalDataSource>(
      () => PostsLocalDataSourceImpl(sharedPreferences: sl()));

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
