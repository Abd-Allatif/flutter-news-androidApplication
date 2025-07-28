// ignore_for_file: file_names, unnecessary_string_interpolations, unused_import

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goosenews/CLasses/NewsModel.dart';
import 'package:goosenews/WorkSpace/web_view_screen.dart';
import 'package:goosenews/cubit/goosenews_cubit.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class SportNews extends StatelessWidget {
  const SportNews({super.key});

  @override
  Widget build(BuildContext context) {
    //Calling the cubit for state mangement
    var goosecubit = GoosenewsCubit().get(context);

    //calling the blocCunsumer to listen and enable the all states in the cubit
    return BlocConsumer<GoosenewsCubit, GoosenewsState>(
      listener: (context, state) {},
      //building the state
      builder: (context, state) {
        //Adding condition widget
        return BuildCondition(
          //if bussinessModel != null
          condition: goosecubit.sportsModel != null,
          //then
          builder: (context) {
            // Generate all NewsScreens adn seperate them using a sizedBox
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildnews(goosecubit.sportsModel!, index, context),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 1,
                  );
                },
                itemCount: goosecubit.sportsModel!.articles.length);
          },
          //else
          fallback: (context) => Container(
            decoration: BoxDecoration(color: Colors.grey.shade300),
            child: Center(
              //Show Loading screen
              child: HeartbeatProgressIndicator(
                child: SvgPicture.asset(
                  "images/Goose.svg",
                  width: 30,
                  height: 30,
                  // ignore: deprecated_member_use
                  color: const Color(0xff241a17),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //building the screen where the news will be shown up
  Widget buildnews(NewsModel model, int index, BuildContext context) {
    return InkWell(
      splashColor: const Color.fromARGB(150, 149, 139, 141),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WebViewScreen(
                  url: GoosenewsCubit()
                      .get(context)
                      .sportsModel!
                      .articles[index]
                      .url,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xffd0c4bc),
              Color.fromARGB(150, 149, 139, 141)
            ])),
            child: Column(
              children: [
                BuildCondition(
                    condition: model.articles[index].urltoimage != null,
                    builder: (context) {
                      return Image(
                        image: NetworkImage(model.articles[index].urltoimage!),
                        errorBuilder: (context, error, stackTrace) {
                          return SvgPicture.asset(
                            "images/Goose.svg",
                            width: 30,
                            height: 30,
                            // ignore: deprecated_member_use
                            color: const Color(0xff241a17),
                          );
                        },
                      );
                    },
                    fallback: (context) => Container(
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                          child: Center(
                            //Show Loading screen
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: HeartbeatProgressIndicator(
                                child: SvgPicture.asset(
                                  "images/Goose.svg",
                                  width: 30,
                                  height: 30,
                                  // ignore: deprecated_member_use
                                  color: const Color(0xff241a17),
                                ),
                              ),
                            ),
                          ),
                        )),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4, right: 8, left: 8, bottom: 4),
                  child: Text(model.articles[index].title!),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
