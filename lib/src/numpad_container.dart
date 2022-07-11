import 'package:custom_numpad/src/enums/num_key.dart';
import 'package:custom_numpad/src/numpad.dart';
import 'package:flutter/material.dart';

typedef OnNumInput = void Function(int number);

class NumpadContainer extends StatefulWidget {
  const NumpadContainer({
    Key? key,
    required this.child,
    required this.show,
    required this.onNumInput,
    required this.onDelete,
    this.keyboardHeight = 300,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final Widget child;

  /// Set `true` to show numpad.
  final bool show;

  /// The height of numpad.
  /// Default is [300].
  ///
  final double keyboardHeight;

  /// Animation duration of show/hide numpad.
  /// Default is 300ms.
  ///
  final Duration duration;

  /// Callback for when [number] key tapped.
  ///
  final OnNumInput onNumInput;

  /// Callback for delete key tapped.
  ///
  final VoidCallback onDelete;

  @override
  State<NumpadContainer> createState() => _NumpadContainerState();
}

class _NumpadContainerState extends State<NumpadContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant NumpadContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.show != widget.show) {
      if (widget.show) {
        if (!_animationController.isCompleted) {
          _animationController.forward();
        }
      } else {
        if (_animationController.isCompleted) {
          _animationController.reverse();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: widget.child),
          SlideTransition(
            position: _animation,
            child: SizedBox(
              height: widget.show ? widget.keyboardHeight : 0,
              child: SafeArea(
                top: false,
                child: NumPad(
                  onNumKeyTap: (numKey) => widget.onNumInput(numKey.number),
                  onDelete: () => widget.onDelete(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
