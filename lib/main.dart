import 'package:arc/Core/app_theme.dart';
import 'package:arc/Features/Posts/Persentation/Bloc/crud/crud_bloc.dart';
import 'package:arc/Features/Posts/Persentation/Bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Features/Posts/Persentation/Pages/splash.dart';
import 'injection_container/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvents())),
        BlocProvider(create: (_) => di.sl<CrudBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme(),
        home: const SplashPage(),
      ),
    );
  }
}
