import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goosenews/WorkSpace/search_creen.dart';
import 'package:goosenews/cubit/goosenews_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoosenewsCubit, GoosenewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: GradientAppBar(
            gradient: const LinearGradient(
                colors: [Color(0xff958b8d), Color(0xffd0c4bc)]),
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "GooseNews",
                style: TextStyle(
                    color: Color(0xff241a17),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                width: 2,
              ),
              SvgPicture.asset(
                "images/Goose.svg",
                width: 30,
                height: 30,
                // ignore: deprecated_member_use
                color: const Color(0xff241a17),
              )
            ]),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
                  },
                  icon: const Icon(
                    CupertinoIcons.search,
                    color: Color(0xff241a17),
                    size: 25,
                  ))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: GoosenewsCubit().get(context).tabindex,
            onTap: (value) {
              GoosenewsCubit().get(context).chagneindex(value);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.building_2_fill), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.speedometer), label: "")
            ],
            backgroundColor: const Color(0xffd0c4bc),
            selectedItemColor: const Color(0xff241a17),
            elevation: 10,
          ),
          body: GoosenewsCubit()
              .get(context)
              .screens[GoosenewsCubit().get(context).tabindex],
        );
      },
    );
  }
}
