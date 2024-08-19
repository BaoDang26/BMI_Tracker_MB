enum EBMIStatus { normal, obesity, deficit, weightOver, weightDeficit }

extension EBMIStatusExtension on EBMIStatus {
  static EBMIStatus fromString(String bmiStatus) {
    switch (bmiStatus) {
      case 'normal':
        return EBMIStatus.normal;
      case 'obesity':
        return EBMIStatus.obesity;
      case 'deficit':
        return EBMIStatus.deficit;
      case 'Weight Over':
        return EBMIStatus.weightOver;
      case 'Body weight deficit':
        return EBMIStatus.weightDeficit;
      default:
        throw Exception('Invalid bmi status: $bmiStatus');
    }
  }

  String get name {
    switch (this) {
      case EBMIStatus.normal:
        return 'Normal';
      case EBMIStatus.deficit:
        return 'Body mass deficit';
      case EBMIStatus.weightDeficit:
        return 'Body weight deficit';
      case EBMIStatus.obesity:
        return 'Obesity degree';
      case EBMIStatus.weightOver:
        return 'Weight over';
    }
  }
}
