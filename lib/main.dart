import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ntrivia/core/network/network_info.dart';
import 'package:ntrivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:ntrivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:ntrivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:ntrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:ntrivia/features/number_trivia/presentation/routes.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MainApp());
}

Future initDependencies() async {
  await Get.putAsync(() => SharedPreferences.getInstance());
  Get.lazyPut<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: http.Client()),
  );
  Get.lazyPut<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: Get.find<SharedPreferences>(),
    ),
  );
  Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(
        InternetConnectionChecker(),
      ));
  Get.lazyPut<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: Get.find<NumberTriviaRemoteDataSource>(),
      localDataSource: Get.find<NumberTriviaLocalDataSource>(),
      networkInfo: Get.find<NetworkInfo>(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return GetMaterialApp(
      title: "Number Trivia",
      getPages: [
        ...numberTriviaPages,
      ],
      initialRoute: NumberTriviaRoutes.homeRoute,
    );
  }
}
