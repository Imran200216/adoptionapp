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

  /// Factory constructor to create a PetModels instance from a Firestore document
  factory PetModels.fromFirestore(Map<String, dynamic> data) {
    return PetModels(
      petName: data['petName'] ?? '', // Provide default empty string if null
      petBreed: data['petBreed'] ?? '',
      petDescription: data['petDescription'] ?? '',
      petAge: (data['petAge'] ?? 0).toInt(), // Ensure it's an int
      petWeight: (data['petWeight'] ?? 0).toInt(),
      petLocation: data['petLocation'] ?? '',
      petOwnerPhoneNumber: data['petOwnerPhoneNumber'] ?? '',
      petCategory: data['petCategory'] ?? '',
      isVaccinated: (data['isVaccinated'] ?? false) as bool, // Ensure it's a bool
      petImages: List<String>.from(data['petImages'] ?? []), // Ensure it's a List<String>
    );
  }
}
