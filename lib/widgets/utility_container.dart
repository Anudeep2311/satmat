import 'package:flutter/material.dart';
import 'package:newapp/pages/home_screen.dart';
import 'package:newapp/widgets/utility_grid.dart';

class UtilityContainer extends StatelessWidget {
  const UtilityContainer({
    super.key,
    required this.height,
    required this.utilityTitleHeader,
  });

  final double height;
  final String utilityTitleHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.42,
      margin: EdgeInsets.only(
        top: height * 0.85,
        right: 8,
        left: 8,
      ),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: BorderSide.strokeAlignOutside,
            offset: Offset(0, 1.5),
            spreadRadius: BorderSide.strokeAlignOutside,
            blurStyle: BlurStyle.solid,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Text(
              utilityTitleHeader,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemCount: utilityModel.length,
                      itemBuilder: (context, index) {
                        final item = utilityModel[index];
                        return SizedBox(
                          height: 70,
                          width: 70,
                          child: Column(
                            children: [
                              UtilityGrid(item: item),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
