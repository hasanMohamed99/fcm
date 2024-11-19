String getFlagEmoji(String countryCode) {
  countryCode = countryCode.toUpperCase();

  if (countryCode.length != 2) {
    throw ArgumentError('Country code must be exactly 2 letters');
  }

  int firstLetter = countryCode.codeUnitAt(0) + 0x1F1E6 - 'A'.codeUnitAt(0);
  int secondLetter = countryCode.codeUnitAt(1) + 0x1F1E6 - 'A'.codeUnitAt(0);

  return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
}