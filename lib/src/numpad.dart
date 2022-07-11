import 'package:custom_numpad/src/enums/num_key.dart';
import 'package:flutter/material.dart';

typedef OnNumKeyTap = void Function(NumKey key);

class NumPad extends StatelessWidget {
  const NumPad({
    Key? key,
    required this.onNumKeyTap,
    required this.onDelete,
  }) : super(key: key);

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
                .map((type) => NumPadButton(
                      type: type,
                      onTap: () => onNumKeyTap(type),
                    ))
                .toList(
                  growable: false,
                ),
          ),
        ),
        Expanded(
          child: Row(
            children: NumKey.values
                .sublist(3, 6)
                .map((type) => NumPadButton(
                      type: type,
                      onTap: () => onNumKeyTap(type),
                    ))
                .toList(
                  growable: false,
                ),
          ),
        ),
        Expanded(
          child: Row(
            children: NumKey.values
                .sublist(6, 9)
                .map((type) => NumPadButton(
                      type: type,
                      onTap: () => onNumKeyTap(type),
                    ))
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
              NumPadButton(
                type: NumKey.zero,
                onTap: () => onNumKeyTap(NumKey.zero),
              ),
              _DeleteButton(onTap: () => onDelete()),
            ],
          ),
        )
      ],
    );
  }
}

class NumPadButton extends StatelessWidget {
  const NumPadButton({
    Key? key,
    required this.type,
    required this.onTap,
  }) : super(key: key);

  final NumKey type;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(),
        child: Center(
          child: Text(
            type.label,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(),
        child: const Center(
          child: Icon(Icons.backspace),
        ),
      ),
    );
  }
}
