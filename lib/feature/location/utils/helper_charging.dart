class Charging {
  String connectorType({required String type}) {
    switch (type) {
      case 'GB_T':
        return 'GB/T DC';
      case 'CCS2':
        return 'CCS2 DC';
      default:
        return 'NOT FOUND';
    }
  }

  String maskNumber(String? originalNumber) {
    if (originalNumber!.length <= 4) {
      return originalNumber; // Если номер слишком короткий, возвращаем как есть
    }

    // Оставляем первые 3 и последние 4 символа, остальное заменяем на ***
    String prefix = originalNumber.substring(0, 7);
    String suffix = originalNumber.substring(originalNumber.length - 2);

    return '$prefix***$suffix';
  }
}
