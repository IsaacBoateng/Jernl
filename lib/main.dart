import 'package:flutter/material.dart';
import 'package:jernl/blocs/authentication_bloc.dart';
import 'package:jernl/blocs/authentication_bloc_provider.dart';
import 'package:jernl/blocs/home_bloc.dart';
import 'package:jernl/blocs/home_bloc_provider.dart';
import 'package:jernl/services/authentication.dart';
import 'package:jernl/services/db_firestore.dart';
import 'package:jernl/pages/home.dart';
import 'package:jernl/pages/login.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthenticationService _authenticationService = AuthenticationService();
    final AuthenticationBloc _authenticationBloc = AuthenticationBloc(_authenticationService);

    return AuthenticationBlocProvider(
      authenticationBloc: _authenticationBloc,
      child: StreamBuilder(
        initialData: null,
        stream: _authenticationBloc.user,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.lightBlue,
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return HomeBlocProvider(
              homeBloc: HomeBloc(DbFirestoreService(), _authenticationService), // Inject the DbFirestoreService() & AuthenticationService()
              uid: snapshot.data,
              child: _buildMaterialApp(Home()),
            );
          } else {
            return _buildMaterialApp(Login());
          }
        },
      ),
    );
  }

  MaterialApp _buildMaterialApp(Widget homePage) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jernl',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        canvasColor: Colors.lightBlue.shade50,
        bottomAppBarColor: Colors.lightBlue,
        platform: TargetPlatform.iOS,
      ),
      home: homePage,
    );
  }
}