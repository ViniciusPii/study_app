import 'package:flutter/material.dart';
import 'package:superapp_my_bloc/src/modules/counter/counter_home_page.dart';
import 'package:superapp_my_bloc/src/modules/crud/home/list_user_page.dart';
import 'package:superapp_my_bloc/src/modules/details/details/details_result_page.dart';
import 'package:superapp_my_bloc/src/modules/details/home/details_home_page.dart';
import 'package:superapp_my_bloc/src/modules/home/home_page.dart';
import 'package:superapp_my_bloc/src/modules/imc/imc_home_page.dart';

class Routes {
  static String home = '/';

  static String counterHome = '/counter';

  static String imcHome = '/imc';

  static String detailsHome = '/details';
  static String detailsResult = '/details/result';

  static String listUser = '/list';

  final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    counterHome: (context) => const CounterHomePage(),
    imcHome: (context) => const ImcHomePage(),
    detailsHome: (context) => const DetailsHomePage(),
    detailsResult: (context) => const DetailsResultPage(),
    listUser: (context) => const ListUserPage(),
  };
}
