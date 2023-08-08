import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sopping_app/models/search_model.dart';
import 'package:sopping_app/modules/search/cubit/states.dart';
import 'package:sopping_app/shared/component/constants.dart';
import 'package:sopping_app/shared/network/end_point.dart';
import 'package:sopping_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {'text': text},
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error, stackTrac) {
      print(error.toString());
      print(stackTrac.toString());

      emit(SearchErrorState());
    });
  }
}
