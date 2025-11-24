import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/providers/mode_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class CycleBtnWidget extends StatelessWidget {
  const CycleBtnWidget({super.key, required this.icon, required this.color});
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, ModeSelectorProvider modeSelectorProvider, child) =>
          IconButton(
            // child: AnimatedContainer(
            //   decoration: BoxDecoration(
            //     color: color,
            //     borderRadius: BorderRadius.circular(8.0),
            //   ),
            //   width: mediaQuery.width * 0.085,
            //   height: mediaQuery.height * 0.115,
            //   duration: const Duration(milliseconds: 100),
            //   curve: Curves.easeInOut,
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: mediaQuery.width * 0.01,
            //       vertical: mediaQuery.height * 0.01,
            //     ),
            //     child: Center(child: Icon(icon, size: 32)),
            //   ),
            // ),
            onPressed: () {},
            icon: Icon(icon, size: 24),
          ),
    );
  }
}
