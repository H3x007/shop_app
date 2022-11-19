import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app/shared/bloc_cubit/search_cubit/cubit.dart';
import 'package:shop_app/shared/bloc_cubit/search_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/widgets/my_form_field.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text('Search Products', style: TextStyle(color: defaultColor),),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    MyFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      label: 'Search',
                      suffix: Icons.search,
                      onSubmit: (text){
                        SearchCubit.get(context).search(text);
                      },
                    ),
                    if(state is LoadingSearchState)
                      LinearProgressIndicator(),
                    if(state is SuccessSearchState)
                      AnimationLimiter(
                        child: Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: buildListProduct(SearchCubit.get(context).searchModel!.data!.data![index], context, isOldPrice: false,),
                                ),
                              ),
                            ),
                            itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
