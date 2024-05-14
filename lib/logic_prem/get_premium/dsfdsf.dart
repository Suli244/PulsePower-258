class Lfsgs {
  final String asda1;
  final String asffaf2;
  final String asfsfaf3;
  final String afaf4;
  final bool adasdis;
  Lfsgs({
    required this.asda1,
    required this.asffaf2,
    required this.asfsfaf3,
    required this.afaf4,
    required this.adasdis,
  });

  factory Lfsgs.fromJson(Map<String, dynamic> map) {
    return Lfsgs(
      asda1: map['asda1'],
      asffaf2: map['asffaf2'],
      asfsfaf3: map['asfsfaf3'],
      afaf4: map['afaf4'],
      adasdis: map['adasdis'],
    );
  }

  @override
  String toString() {
    return 'Lfsgs(asda1: $asda1, asffaf2: $asffaf2, asfsfaf3: $asfsfaf3, afaf4: $afaf4, adasdis: $adasdis)';
  }
}
