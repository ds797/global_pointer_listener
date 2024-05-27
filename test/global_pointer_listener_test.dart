import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:global_pointer_listener/global_pointer_listener.dart';

void main() {
  group('GlobalPointerListener', () {
    testWidgets('onPointerDown callback is called', (WidgetTester tester) async {
      PointerEvent? capturedEvent;
      await tester.pumpWidget(
        GlobalPointerListener(
          onPointerDown: (event) => capturedEvent = event,
          child: Container(),
        ),
      );

      await tester.tapAt(const Offset(100, 100));
      expect(capturedEvent, isA<PointerDownEvent>());
    });

    testWidgets('onPointerUp callback is called', (WidgetTester tester) async {
      PointerEvent? capturedEvent;
      await tester.pumpWidget(
        GlobalPointerListener(
          onPointerUp: (event) => capturedEvent = event,
          child: Container(),
        ),
      );

      await tester.tapAt(const Offset(100, 100));
      expect(capturedEvent, isA<PointerUpEvent>());
    });

    testWidgets('onPointerMove callback is called', (WidgetTester tester) async {
      PointerEvent? capturedEvent;
      await tester.pumpWidget(
        GlobalPointerListener(
          onPointerMove: (event) => capturedEvent = event,
          child: Container(),
        ),
      );

      await tester.dragFrom(const Offset(100, 100), const Offset(200, 200));
      expect(capturedEvent, isA<PointerMoveEvent>());
    });
  });
}
