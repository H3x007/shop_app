import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/bloc_cubit/search_cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/helper/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  search(String text) {
    emit(LoadingSearchState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessSearchState());
    }).catchError((e){
      emit(ErorrSearchState());
    });
  }
}
