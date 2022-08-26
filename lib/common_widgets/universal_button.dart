import 'package:flutter/material.dart';

class UniversalButton extends StatelessWidget {
  final double radius;
  final VoidCallback action;
  // final ValueKey key;
  final String label;
  final double scale;
  final Widget child;
  final FontWeight weight;
  final double elevation;
  final double size;
  final Color color;
  final Color buttonColor;
  final double buttonHeight;
  final double buttonWidth;
  final double spacing;
  UniversalButton(
      {required this.action,
      this.radius = 80.0,
      this.elevation = 2,
      required this.buttonColor,
      this.spacing = 1,
      required this.child,
      // required this.key,
      this.buttonHeight = 40,
      required this.buttonWidth,
      this.color = Colors.white,
      this.size = 12,
      this.scale = 1,
      this.weight = FontWeight.bold,
      required this.label});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          elevation: elevation,
        ),
        onPressed: () => action(),
        child: Text(
              label,
              textScaleFactor: scale,
              style: TextStyle(
                  color: color,
                  letterSpacing: spacing,
                  fontWeight: weight,
                  fontSize: size),
            ),
      ),
    );
  }
}

class UniversalButtonGradient extends StatelessWidget {
  final Color shadow;
  final VoidCallback action;
  final double radius;
  final Widget child;
  final String label;
  final double scale;
  final Color splash;
  final FontWeight weight;
  final double elevation;
  final double size;
  final Color? color;
  final double buttonHeight;
  final double buttonWidth;
  final double spacing;
  UniversalButtonGradient(
      {required this.action,
      required this.shadow,
      this.elevation = 2,
      this.radius = 30,
      required this.child,
      this.spacing = 1,
      this.splash = Colors.white12,
      this.buttonHeight = 50,
      required this.buttonWidth,
      this.color = Colors.white,
      this.size = 12,
      this.scale = 1,
      this.weight = FontWeight.bold,
      required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: shadow,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          elevation: elevation,
          padding: EdgeInsets.all(0.0),
        ),
        onPressed: () => action(),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              // Theme.of(context).foregroundColor,
              Theme.of(context).backgroundColor
            ], 
            begin: Alignment.centerLeft, end: Alignment.centerRight),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Container(
            constraints:
                BoxConstraints(maxHeight: buttonHeight, maxWidth: buttonWidth),
            alignment: Alignment.center,
            child: child == null
                ? Text(
                    label,
                    textScaleFactor: scale,
                    style: TextStyle(
                        color: color,
                        letterSpacing: spacing,
                        fontWeight: weight,
                        fontSize: size),
                  )
                : child,
          ),
        ),
      ),
    );
  }
}

class UniversalFlatButton extends StatelessWidget {
  final ValueKey valueKey;
  final VoidCallback pressed;
  final Color color;
  final String label;
  final double scale;
  final Widget child;
  final TextStyle style;
  final ButtonStyle buttonStyle;
  final double buttonWidth;
  final double buttonHeight;
  final GlobalKey key;
  final BorderSide side;
  final double elevation;

  final ShapeBorder? shape;

  UniversalFlatButton(
      {
      required this.pressed,
      required this.style,
      required this.elevation,
      required this.buttonWidth,
      required this.side,
      required this.child,
      required this.key,
      required this.buttonHeight,
      required this.buttonStyle,
      required this.valueKey,
      this.scale = 1,
      required this.color,
      required this.shape,
      required this.label});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: TextButton(
        key: valueKey == null ? key : valueKey,
        style: TextButton.styleFrom(
            // shape: shape,
            backgroundColor: color,
            side: side,
            elevation: elevation),
        onPressed: () => pressed(),
        child: child == null
            ? Text(
                label,
                textScaleFactor: scale,
                style: style,
              )
            : child,
      ),
    );
  }
}