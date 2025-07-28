// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goosenews/CLasses/diohelper.dart';
import 'package:goosenews/WorkSpace/bussiness_screen.dart';
import 'package:goosenews/WorkSpace/home_screen.dart';
import 'package:goosenews/WorkSpace/SportSreen.dart';
import 'package:goosenews/cubit/goosenews_cubit.dart';

void main() {
  DioHelper.init();
  runApp(const GooseNew());
}

class GooseNew extends StatelessWidget {
  const GooseNew({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoosenewsCubit()
        ..getBussinessNews()
        ..getSportNews(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: HomeScreen()),
      ),
    );
  }
}
