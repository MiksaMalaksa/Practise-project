import 'package:dead_notes/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ColorSwitcher extends StatefulWidget {
  Function(Color)? onChange;

   ColorSwitcher({super.key, this.onChange});

  @override
  ColorSwitcherState createState() => ColorSwitcherState();
}

class ColorSwitcherState extends State<ColorSwitcher> {
  int _selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: AppColors.primaryColors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: _selectedColorIndex == index ? null : () => setState(() {
              _selectedColorIndex = index;
              widget.onChange?.call(AppColors.primaryColors[_selectedColorIndex]);
            }),
            child: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: AppColors.primaryColors[index],
                borderRadius: BorderRadius.circular(10),
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _selectedColorIndex == index ? 1 : 0,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}