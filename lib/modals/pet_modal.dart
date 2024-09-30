class PetModels {
  final String petName;
  final String petBreed;
  final String petDescription;
  final int petAge;
  final int petWeight;
  final String petLocation;
  final String petOwnerPhoneNumber;
  final String petCategory;
  final bool isVaccinated;
  final List<String> petImages;

  PetModels({
    required this.petName,
    required this.petBreed,
    required this.petDescription,
    required this.petAge,
    required this.petWeight,
    required this.petLocation,
    required this.petOwnerPhoneNumber,
    required this.petCategory,
    required this.isVaccinated,
    required this.petImages,
  });

  /// Convert the PetModels instance to a JSON-friendly Map
  Map<String, dynamic> toJson() {
    return {
      'petName': petName,
      'petBreed': petBreed,
      'petDescription': petDescription,
      'petAge': petAge,
      'petWeight': petWeight,
      'petLocation': petLocation,
      'petOwnerPhoneNumber': petOwnerPhoneNumber,
      'petCategory': petCategory,
      'isVaccinated': isVaccinated,
      'petImages': petImages,
    };
  }
}
