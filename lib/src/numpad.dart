import 'package:custom_numpad/src/enums/num_key.dart';
import 'package:flutter/material.dart';

typedef OnNumKeyTap = void Function(NumKey key);

typedef NumButtonBuilder = Widget Function(BuildContext context, int number);
typedef DeleteButtonBuilder = WidgetBuilder;

class NumPad extends StatelessWidget {
  const NumPad({
    Key? key,
    required this.onNumKeyTap,
    required this.onDelete,
    this.textStyle,
    this.numButtonBuilder,
    this.deleteButtonBuilder,
  }) : super(key: key);

  final NumButtonBuilder? numButtonBuilder;
  final DeleteButtonBuilder? deleteButtonBuilder;

  final TextStyle? textStyle;

  final OnNumKeyTap onNumKeyTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: NumKey.values
                .sublist(0, 3)
                .map((numKey) => _buildNumButton(context, numKey))
                .toList(
                  growable: false,
                ),
          ),
        ),
        Expanded(
          child: Row(
            children: NumKey.values
                .sublist(3, 6)
                .map((numKey) => _buildNumButton(context, numKey))
                .toList(
                  growable: false,
                ),
          ),
        ),
        Expanded(
          child: Row(
            children: NumKey.values
                .sublist(6, 9)
                .map((numKey) => _buildNumButton(context, numKey))
                .toList(
                  growable: false,
                ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              const Expanded(
                child: SizedBox.shrink(),
              ),
              _buildNumButton(context, NumKey.zero),
              _buildDeleteButton(context),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildNumButton(BuildContext context, NumKey numKey) {
    if (numButtonBuilder != null) {
      return Expanded(
        child: numButtonBuilder!(
          context,
          numKey.number,
        ),
      );
    }

    return _NumPadButton.number(numKey, textStyle, () => onNumKeyTap(numKey));
  }

  Widget _buildDeleteButton(BuildContext context) {
    if (deleteButtonBuilder != null) {
      return Expanded(child: deleteButtonBuilder!(context));
    }

    return _NumPadButton.delete(() => onDelete());
  }
}

class _NumPadButton extends StatelessWidget {
  const _NumPadButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  factory _NumPadButton.number(
    NumKey numKey,
    TextStyle? textStyle,
    VoidCallback onTap,
  ) {
    return _NumPadButton(
      label: Text(
        numKey.label,
        style: textStyle ?? const TextStyle(fontSize: 20),
      ),
      onTap: onTap,
    );
  }

  factory _NumPadButton.delete(VoidCallback onTap) {
    return _NumPadButton(
      label: const Icon(Icons.backspace),
      onTap: onTap,
    );
  }

  final Widget label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(),
          child: Center(
            child: label,
          ),
        ),
      ),
    );
  }
}
