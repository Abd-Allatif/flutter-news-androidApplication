part of 'goosenews_cubit.dart';

@immutable
abstract class GoosenewsState {}

class GoosenewsInitial extends GoosenewsState {}

class LoadingBussinessNewsState extends GoosenewsState {}

class GetBussinessNewsSuccessState extends GoosenewsState {}

class GetBussinessNewsFailurState extends GoosenewsState {}

class LoadingSportsNewsState extends GoosenewsState {}

class GetSportsNewsSuccessState extends GoosenewsState {}

class GetSportsNewsFailurState extends GoosenewsState {}

class ChangeIndexState extends GoosenewsState {}

class LoadingSearchState extends GoosenewsState {}

class GetSearchSuccessState extends GoosenewsState {}

class GetSearchFailurState extends GoosenewsState {}
