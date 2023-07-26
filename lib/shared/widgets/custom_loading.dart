import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/shared/assets/assets.dart';
import 'package:rick_and_morty_app/shared/widgets/separator.dart';

class CustomLoading {
  final BuildContext context;
  final String title;
  final bool? barrierDismissible;
  final TextStyle? textStyle;

  CustomLoading(this.context,
      {this.textStyle, required this.title, this.barrierDismissible}) {
    showLoadingDialog(context);
  }

  showLoadingDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            // Evitar que se cierre el diálogo si se presiona el botón "atrás" del dispositivo
            return false;
          },
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: BodyLoading(title: title, textStyle: textStyle),
          ),
        );
      },
    );
  }
}

class BodyLoading extends StatelessWidget {
  const BodyLoading({
    Key? key,
    required this.title,
    this.textStyle,
  }) : super(key: key);

  final String title;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Progress(),
            const Separator(size: 10),
            Text(
              title,
              // style: textStyle ??
              //     TextStyles.headlineStyle(
              //         isBold: true, color: Colores.whiteColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Progress extends StatefulWidget {
  const Progress({
    Key? key,
  }) : super(key: key);

  @override
  State<Progress> createState() => _ProgressAnimadoState();
}

class _ProgressAnimadoState extends State<Progress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat(reverse: true);

    rotation = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    // controller.addListener(() {
    //   if (controller.isCompleted) {
    //     controller.repeat();
    //   }
    // }
    //);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //controller.forward();
    return ScaleTransition(
      scale: rotation,
      child: Image.asset(
        Res.images.loading,
        fit: BoxFit.fitWidth,
      ),
      // builder: (BuildContext context, Widget? child) {
      //   return Transform.rotate(
      //     angle: rotation.value,
      //     child: child,
      //   );
      // },
    );
  }
}
