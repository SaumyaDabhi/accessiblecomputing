// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:floatingbubble/constants/constants.dart';
import 'package:floatingbubble/utils/spaces.dart';

/// Abstracted Button Class for the all the buttons used across the application
///
/// 1. *onPressed* -> Used to handle clicks on the [CustomButton]
/// 2. *hasBorder* -> Used to set the border for [CustomButton] if set to `true`
/// 3. *hasBoxShadow* -> Used to set the box shadow for [CustomButton] if set to `true`
/// 4. *width* -> Used to set the width for [CustomButton]
/// 5. *height* -> Used to set the height for [CustomButton]
/// 6. *borderRadius* -> used to set the [BorderRadius] of [CustomButton]
/// 7. *title* -> Title displayed for [CustomButton]
/// 8. *color* -> The color set for background of the [CustomButton]
/// 9. *textColor* -> The color set for text of the [CustomButton]
/// 10. *iconData* -> Used to display the Icon for [CustomButton]
/// 11. *padding* -> Used to set the padding of [CustomButton]
/// 12. *textStyle* -> Used to set the [TextStyle] for the title of [CustomButton]
class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool hasBorder;
  final bool hasBoxShadow;
  final double width;
  final double height;
  final double borderRadius;
  final String title;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final Widget icon;
  final bool isLeftIcon;
  final bool isRightIcon;
  final EdgeInsets padding;
  final TextStyle textStyle;

  const CustomButton({
    @required this.title,
    @required this.onPressed,
    this.hasBorder = false,
    this.hasBoxShadow = true,
    this.width = Sizes.WIDTH_150,
    this.height = Sizes.HEIGHT_50,
    this.borderRadius = Sizes.RADIUS_10,
    this.color = AppColors.primaryGreenColor,
    this.borderColor = AppColors.primaryRedColor,
    this.textColor = AppColors.whiteColor,
    this.textStyle = const TextStyle(
      fontSize: Sizes.TEXT_SIZE_14,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.bold,
    ),
    this.icon,
    this.padding = const EdgeInsets.all(Sizes.PADDING_0),
    this.isLeftIcon = true,
    this.isRightIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,

      /// Wrapped the Complete object in a [Container] to add [Padding], [Color] and
      /// [BorderRadius] and [BoxShadow] to the body of [CustomButton]
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: color,

          /// If `hasBoxShadow` is `true`, then display the BoxShadow, otherwise display null
          boxShadow: hasBoxShadow
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.24),
                    spreadRadius: Sizes.RADIUS_4,
                    offset: const Offset(
                      Sizes.WIDTH_1,
                      Sizes.WIDTH_1,
                    ),
                    blurRadius: Sizes.RADIUS_10,
                  ),
                ]
              : null,
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius,
            ),
          ),

          /// If `hasBorder` is `true`, then display the Border on all sides, otherwise display null
          border: hasBorder
              ? Border.all(
                  color: borderColor,
                  width: 2,
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// If `icon` is not null and `isLeftIcon` is true, display the provided icon
            if (icon != null && isLeftIcon)
              Row(
                children: [
                  icon,
                  SpaceW4(),
                ],
              ),

            /// Title
            Text(
              title,
              style: textStyle.copyWith(
                color: textColor,
              ),
            ),

            /// If `icon` is not null and `isRightIcon` is true, display the provided icon
            if (icon != null && isRightIcon)
              Row(
                children: [
                  SpaceW10(),
                  icon,
                ],
              ),
          ],
        ),
      ),
    );
  }
}
