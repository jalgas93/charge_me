import 'dart:math';

import 'package:flutter/services.dart';

class MoneyInputFormatterWithDecimal extends TextInputFormatter {
  static final _nonDigitsRegex = RegExp(r'[^\d.]');
  static final _multipleDotsRegex = RegExp(r'\.{2,}');
  static final _leadingZerosRegex = RegExp(r'^0+(?=\d)');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Если текст не изменился - ничего не делаем
    if (newValue.text == oldValue.text) return newValue;

    // Если текст пустой - разрешаем
    if (newValue.text.isEmpty) return newValue;

    // Обрабатываем вставку текста
    final newText = _formatText(newValue.text);

    // Вычисляем новую позицию курсора
    final selectionOffset = _calculateCursorPosition(
      oldValue: oldValue,
      newValue: newValue,
      formattedText: newText,
    );

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionOffset),
    );
  }

  String _formatText(String text) {
    // Заменяем запятые на точки (для iOS Decimal Pad)
    String cleanedText = text.replaceFirst(',', '.');

    // Удаляем все нецифровые символы, кроме точек
    cleanedText = cleanedText.replaceAll(_nonDigitsRegex, '');

    // Удаляем лишние точки
    cleanedText = cleanedText.replaceAll(_multipleDotsRegex, '.');

    // Удаляем ведущие нули
    cleanedText = cleanedText.replaceFirst(_leadingZerosRegex, '');

    // Если строка начинается с точки - добавляем ноль
    if (cleanedText.startsWith('.')) {
      cleanedText = '0$cleanedText';
    }

    // Разделяем на целую и дробную части
    final parts = cleanedText.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // Ограничиваем дробную часть до 2 знаков
    if (decimalPart.length > 2) {
      decimalPart = decimalPart.substring(0, 2);
    }

    // Форматируем целую часть с разделителями
    if (integerPart.isNotEmpty) {
      integerPart = _formatIntegerPart(integerPart);
    } else {
      integerPart = '0';
    }

    // Собираем результат
    return decimalPart.isEmpty
        ? integerPart
        : '$integerPart.${decimalPart == '.' ? '' : decimalPart}';
  }

  String _formatIntegerPart(String integerPart) {
    // Преобразуем в число для удаления возможных ведущих нулей
    final number = int.tryParse(integerPart) ?? 0;
    final reversed = number.toString().split('').reversed.join();

    // Добавляем пробелы каждые 3 цифры
    final buffer = StringBuffer();
    for (int i = 0; i < reversed.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(reversed[i]);
    }

    return buffer.toString().split('').reversed.join();
  }

  int _calculateCursorPosition({
    required TextEditingValue oldValue,
    required TextEditingValue newValue,
    required String formattedText,
  }) {
    // Если курсор был в конце - оставляем в конце
    if (oldValue.selection.baseOffset >= oldValue.text.length) {
      return formattedText.length;
    }

    // Если текст стал короче - оставляем курсор на том же месте
    if (formattedText.length < oldValue.text.length) {
      return min(oldValue.selection.baseOffset, formattedText.length);
    }

    // Вычисляем смещение курсора на основе добавленных разделителей
    final oldOffset = oldValue.selection.baseOffset;
    final newOffset = newValue.selection.baseOffset;
    final diff = newOffset - oldOffset;

    // Если пользователь просто печатает цифры
    if (diff == 1 && newValue.text.length > oldValue.text.length) {
      final addedChar = newValue.text[newOffset];
      if (RegExp(r'\d').hasMatch(addedChar)) {
        // Позиция, где должна быть вставлена цифра с учетом разделителей
        final digitsBefore = oldValue.text.substring(0, oldOffset).replaceAll(RegExp(r'[^\d]'), '');
        final newDigits = digitsBefore + addedChar;
        final newFormatted = _formatIntegerPart(newDigits);
        return newFormatted.length;
      }
    }

    // По умолчанию - оставляем курсор на той же позиции
    return min(oldOffset, formattedText.length);
  }
}