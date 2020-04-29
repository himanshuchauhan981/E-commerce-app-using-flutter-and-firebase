import 'package:flutter/material.dart';

enum CustomTransitionType {
  upToDown,
  downToUp
}

class CustomTransition <T> extends PageRouteBuilder<T>{
  final Widget child;
  final CustomTransitionType type;
  final Curve curve;
  final Alignment alignment;
  final Duration duration;

  CustomTransition({
    Key key,
    @required this.child,
    @required this.type,
    this.curve = Curves.linear,
    this.alignment,
    this.duration = const Duration(milliseconds: 500)
  }) :super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
      return child;
    },
    transitionDuration: duration,
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){
      switch(type){

        case CustomTransitionType.downToUp:
          return SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: new SlideTransition(
              position: new Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(0.0, -1.0),
              ).animate(secondaryAnimation),
              child: child,
            ),
          );
          break;

        case CustomTransitionType.upToDown:
          return SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: new SlideTransition(
              position: new Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(0.0, 1.0),
              ).animate(secondaryAnimation),
              child: child,
            ),
          );
          break;
        default:
          return FadeTransition(opacity: animation, child: child);
      }
    }
  );
}