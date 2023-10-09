import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sized_context/sized_context.dart';
import 'package:win_music/core/theme/theme.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.padding});
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? mediumPaddingInset,
      child: LoadingAnimationWidget.threeArchedCircle(
        color: Theme.of(context).iconTheme.color ?? lightThemeColors.iconColor,
        size: 50,
      ),
    );
  }
}
