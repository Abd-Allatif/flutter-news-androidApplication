// ignore_for_file: unnecessary_import, depend_on_referenced_packages, unused_local_variable, unused_element

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goosenews/CLasses/NewsModel.dart';
import 'package:goosenews/CLasses/diohelper.dart';
import 'package:goosenews/WorkSpace/bussiness_screen.dart';
import 'package:goosenews/WorkSpace/SportSreen.dart';

import 'package:meta/meta.dart';

part 'goosenews_state.dart';

class GoosenewsCubit extends Cubit<GoosenewsState> {
  GoosenewsCubit() : super(GoosenewsInitial());

  GoosenewsCubit get(context) => BlocProvider.of(context);
  List screens = const [BussnessNews(), SportNews()];
  int tabindex = 0;
  chagneindex(int index) {
    tabindex = index;
    emit(ChangeIndexState());
  }

  //defining the news model
  NewsModel? bussinessModel;
  getBussinessNews() {
    emit(LoadingBussinessNewsState());
    //Calling the Dio and Intializing the path and the query params
    DioHelper.get(path: "top-headlines", query: {
      "country": "us",
      "category": "business",
      "apiKey": "87248cf35df34c46abdecf5149790b9f"
    }).then((value) {
      //Then represents Try to try and catch the Error
      bussinessModel = NewsModel.fromJson(value?.data);

      emit(GetBussinessNewsSuccessState());
    }).catchError((error) {
      //It represents the catch to cathc the error
      print(error.toString());
      emit(GetBussinessNewsFailurState());
    });
  }

  NewsModel? sportsModel;
  getSportNews() {
    emit(LoadingSportsNewsState());
    //Calling the Dio and Intializing the path and the query params
    DioHelper.get(path: "top-headlines", query: {
      "country": "us",
      "category": "sports",
      "apiKey": "87248cf35df34c46abdecf5149790b9f"
    }).then((value) {
      //Then represents Try to try and catch the Error
      sportsModel = NewsModel.fromJson(value?.data);

      emit(GetSportsNewsSuccessState());
    }).catchError((error) {
      //It represents the catch to cathc the error
      print(error.toString());
      emit(GetSportsNewsFailurState());
    });
  }

  NewsModel? searchModel;
  getSearchResult({required String search}) {
    emit(LoadingSearchState());
    //Calling the Dio and Intializing the path and the query params
    DioHelper.get(path: "top-headlines", query: {
      "country": "us",
      "category": search,
      "apiKey": "87248cf35df34c46abdecf5149790b9f"
    }).then((value) {
      //Then represents Try to try and catch the Error
      searchModel = NewsModel.fromJson(value?.data);

      emit(GetSearchSuccessState());
    }).catchError((error) {
      //It represents the catch to cathc the error
      print(error.toString());
      emit(GetSearchFailurState());
    });
  }
}
