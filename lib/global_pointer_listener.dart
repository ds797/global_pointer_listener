library global_pointer_listener;

import 'package:flutter/material.dart';

/// A widget that hooks into global pointer events.
///
/// If this widget has a child, it defers to that child for its sizing behavior.
/// If it does not have a child, it conforms to [SizedBox.shrink].
class GlobalPointerListener extends StatefulWidget {
  const GlobalPointerListener({
    super.key,
    this.child,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerMove,
    this.onPointerCancel,
  });

  /// The widget below this widget in the tree. If no child is provided,
  /// [SizedBox.shrink] is used.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// Called when a pointer makes contact with the device.
  final void Function(PointerDownEvent)? onPointerDown;

  /// Called when a pointer no longer makes contact with the device.
  ///
  /// This will be called even if the triggering pointer didn't make contact
  /// after the construction of this widget. In other words, [onPointerUp]
  /// will be called if the pointer was making contact with the device at the
  /// time this widget was created.
  final void Function(PointerUpEvent)? onPointerUp;

  /// Called when a pointer that is making contact with the device is moved.
  ///
  /// This will be called even if the triggering pointer didn't make contact
  /// after the construction of this widget. In other words, [onPointerMove]
  /// will be called if the pointer was making contact with the device at the
  /// time this widget was created.
  final void Function(PointerMoveEvent)? onPointerMove;

  /// Called when the input from a pointer is no longer directed towards this
  /// receiver. 
  ///
  /// This will be called even if the triggering pointer didn't make contact
  /// after the construction of this widget. In other words, [onPointerCancel]
  /// will be called if the pointer was making contact with the device at the
  /// time this widget was created.
  final void Function(PointerCancelEvent)? onPointerCancel;

  @override
  State<GlobalPointerListener> createState() => _GlobalPointerListenerState();
}

class _GlobalPointerListenerState extends State<GlobalPointerListener> {
  void handler(PointerEvent event) {
    if (event is PointerDownEvent) widget.onPointerDown?.call(event);
    if (event is PointerUpEvent) widget.onPointerUp?.call(event);
    if (event is PointerMoveEvent) widget.onPointerMove?.call(event);
    if (event is PointerCancelEvent) widget.onPointerCancel?.call(event);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.pointerRouter.addGlobalRoute(handler);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.pointerRouter.removeGlobalRoute(handler);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}