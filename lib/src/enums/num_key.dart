enum NumKey {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  zero,
}

extension NumKeysEx on NumKey {
  int get number {
    if (this == NumKey.zero) {
      return 0;
    }

    return index + 1;
  }

  String get label {
    return number.toString();
  }
}
