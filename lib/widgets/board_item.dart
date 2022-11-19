import 'package:flutter/material.dart';
import 'package:shop_app/models/boarding_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class BoardingItem extends StatelessWidget {
  BoardingItem({Key? key, required this.boardingModel}) : super(key: key);

  BoardingModel? boardingModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Image.asset(boardingModel!.image),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            boardingModel!.title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: defaultColor, fontSize: 23),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            boardingModel!.body,
            style: TextStyle(color: miniTitleColor, fontSize: 18,height: 1.4),
          ),
        ],
      ),
    );
  }
}
