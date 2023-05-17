import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const HelloRectangle());
}

class HelloRectangle extends StatelessWidget {
  const HelloRectangle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ShadedArea(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShadedArea extends StatelessWidget {
  ShadedArea({super.key});

  @override
  build(_) => FutureBuilder(
    future: FragmentProgram.fromAsset('shaders/all_blue.frag'),
    builder: (_, snapshot) {
      if(snapshot.hasData) {
        return CustomPaint(
          size: Size.square(double.infinity),
          painter: FragmentPainter(snapshot.data!.fragmentShader()),
        );
      }
      return Center(child: CircularProgressIndicator(),);
    },
  );
}

class FragmentPainter extends CustomPainter {
  final shader;
  FragmentPainter(this.shader);

  @override
  paint(canvas, size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader
    );
  }

  @override
  shouldRepaint(_) => false;
}