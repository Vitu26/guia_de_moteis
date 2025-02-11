import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_de_moteis/blocs/motel_event.dart';
import 'blocs/motel_bloc.dart';
import 'repositories/motel_repository.dart';
import 'services/api_service.dart';
import 'pages/motel_list_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motéis Disponíveis',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BlocProvider(
        create: (context) =>
            MotelBloc(MotelRepository(ApiService()))..add(LoadMotels()),
        child: MotelListPage(),
      ),
    );
  }
}
