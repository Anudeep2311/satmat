import 'package:flutter/material.dart';
import 'package:newapp/models/banking_model.dart';
import 'package:newapp/widgets/const_sizedbox.dart';

class GridItem extends StatelessWidget {
  final BankingModel item;
  const GridItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SmallSizedBoxHeight(),
          Image.asset(
            item.image,
            fit: BoxFit.cover,
            height: 36,
          ),
          Text(
            textAlign: TextAlign.center,
            item.title,
            style: const TextStyle(
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
