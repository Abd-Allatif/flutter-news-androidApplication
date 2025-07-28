import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goosenews/CLasses/NewsModel.dart';
import 'package:goosenews/WorkSpace/web_view_screen.dart';
import 'package:goosenews/cubit/goosenews_cubit.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
                "Search",
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
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    onChanged: (search) {
                      GoosenewsCubit()
                          .get(context)
                          .getSearchResult(search: search);
                    },
                    decoration: InputDecoration(
                        labelText: "Seach",
                        labelStyle: const TextStyle(
                            color: Color(0xff241a17),
                            fontWeight: FontWeight.w300),
                        prefixIcon: const Icon(
                          CupertinoIcons.search,
                          color: Color(0xff241a17),
                        ),
                        focusColor: const Color(0xffd0c4bc),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(176, 36, 26, 23))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Color(0xff958b8d)))),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BuildCondition(
                    condition:
                        GoosenewsCubit().get(context).searchModel != null,
                    builder: (context) {
                      return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return buildnews(
                                GoosenewsCubit().get(context).searchModel!,
                                index,
                                context);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 1,
                            );
                          },
                          itemCount: GoosenewsCubit()
                              .get(context)
                              .searchModel!
                              .articles
                              .length);
                    },
                    fallback: (context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                          child: Center(
                            //Show Loading screen
                            child: state is LoadingSearchState
                                ? HeartbeatProgressIndicator(
                                    child: SvgPicture.asset(
                                      "images/Goose.svg",
                                      width: 30,
                                      height: 30,
                                      // ignore: deprecated_member_use
                                      color: const Color(0xff241a17),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
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
                      .bussinessModel!
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
