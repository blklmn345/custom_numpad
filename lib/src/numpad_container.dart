import 'package:custom_numpad/src/enums/num_key.dart';
import 'package:custom_numpad/src/numpad.dart';
import 'package:flutter/material.dart';

typedef OnNumInput = void Function(int number);

class NumpadContainer extends StatefulWidget {
  const NumpadContainer({
    Key? key,
    required this.child,
    required this.show,
    required this.onDelete,
    this.textStyle,
    this.onNumInput,
    this.numButtonBuilder,
    this.deleteButtonBuilder,
    this.backgroundColor = Colors.white,
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

  /// Background color of keyboard area.
  ///
  final Color backgroundColor;

  /// Button text style.
  /// 
  final TextStyle? textStyle;

  /// Animation duration of show/hide numpad.
  /// Default is 300ms.
  ///
  final Duration duration;

  /// Builder for num buttons.
  ///
  final NumButtonBuilder? numButtonBuilder;

  /// Builder for delete button.
  ///
  final DeleteButtonBuilder? deleteButtonBuilder;

  /// Callback for when [number] key tapped.
  ///
  final OnNumInput? onNumInput;

  /// Callback for delete key tapped.
  ///
  final VoidCallback onDelete;

  @override
  State<NumpadContainer> createState() => _NumpadContainerState();
}

class _NumpadContainerState extends State<NumpadContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _slideAnimation = Tween<Offset>(
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(child: widget.child),
                AnimatedContainer(
                  duration: widget.duration,
                  height: widget.show ? widget.keyboardHeight : 0,
                ),
              ],
            ),
          ),
          SlideTransition(
            position: _slideAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                  ),
                  height: widget.keyboardHeight,
                  child: SafeArea(
                    top: false,
                    child: NumPad(
                      onNumKeyTap: (numKey) =>
                          widget.onNumInput?.call(numKey.number),
                      onDelete: () => widget.onDelete(),
                      numButtonBuilder: widget.numButtonBuilder,
                      deleteButtonBuilder: widget.deleteButtonBuilder,
                      textStyle: widget.textStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
