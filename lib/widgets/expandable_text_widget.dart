import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.21; //781/5.21 = ~150

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.bottomHeight5),
      child: secondHalf.isEmpty
          ? SmallText(
              height: 1.4,
              color: AppColors.paraColor,
              size: Dimensions.fontSize15,
              text: firstHalf)
          : Column(
              children: [
                SmallText(
                    height: 1.4,
                    color: AppColors.paraColor,
                    size: Dimensions.fontSize15,
                    text: hiddenText
                        ? (firstHalf + "...")
                        : firstHalf + secondHalf),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: hiddenText
                      ? Row(
                          children: [
                            SmallText(
                                text: "Daha fazla göster",
                                color: AppColors.mainColor),
                            Icon(Icons.arrow_drop_down,
                                color: AppColors.mainColor)
                          ],
                        )
                      : Row(
                          children: [
                            SmallText(
                                text: "Daha az göster",
                                color: AppColors.mainColor),
                            Icon(Icons.arrow_drop_up,
                                color: AppColors.mainColor)
                          ],
                        ),
                )
              ],
            ),
    );
  }
}
