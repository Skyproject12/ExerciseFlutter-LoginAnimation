import 'package:flutter/cupertino.dart';

class CustomGestureDetector extends StatelessWidget{

  static const int AXIS_X = 0;
  static const int AXIS_Y = 1;
  static const int AXIS_BOTH = 2;

  final int axis;
  final Widget child;
  final double velocity;
  final Function onSwipeUp;
  final Function onSwipeDown;
  final Function onSwipeLeft;
  final Function onSwipeRight;

  CustomGestureDetector({@required this.child,@required this.velocity,this.onSwipeLeft,this.onSwipeRight,this.onSwipeUp,this.onSwipeDown,@required this.axis});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onPanEnd: (details){
          // menhgambil pexel persecond 
           Offset v = details.velocity.pixelsPerSecond;

          try { 
            // mengecek axis 
            if((axis == AXIS_Y) || axis == AXIS_BOTH){
              if(v.dy>velocity){
                onSwipeDown();
              } else if(v.dy<-velocity){
                onSwipeUp();
              }
            }
            // melakukan pengecekan axis untuk mengatur status swife 
            if((axis == AXIS_X )  || axis == AXIS_BOTH){
              if(v.dx>velocity){
                onSwipeRight();
              } else if(v.dx<-velocity) {
                onSwipeLeft();
              }
            }
          } catch (e){
           
          }

        },
        child: child);
  }

}