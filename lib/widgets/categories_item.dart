import 'package:flutter/material.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/styles/styles.dart';

class CategoriesItem extends StatelessWidget {
  CategoriesItem({Key? key, required this.dataModel}) : super(key: key);
  DataModel? dataModel;
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.only(left: 8,top: 8, bottom: 8),
      margin: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(24)
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('${dataModel!.image}'),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            '${dataModel!.name}',
            style: categoryStyle,
          ),
        ],
      ),
    );
  }
}
