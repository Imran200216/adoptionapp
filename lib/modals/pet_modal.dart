class PetModels {
  final String userUid;
  final String petId;
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
  final String petGender;
  final String petOwnerName;

  PetModels(
    this.userUid, {
    required this.petId,
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
    required this.petGender,
    required this.petOwnerName,
  });

  /// Convert the PetModels instance to a JSON-friendly Map
  Map<String, dynamic> toJson() {
    return {
      'userUid': userUid,
      'petId': petId,
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
      'petGender': petGender,
      'petOwnerName': petOwnerName,
    };
  }

  /// Factory constructor to create a PetModels instance from a Firestore document
  factory PetModels.fromFirestore(Map<String, dynamic> data) {
    return PetModels(
      data['userUid'] ?? '',
      petId: data['petId'] ?? '',
      petName: data['petName'] ?? '',
      petBreed: data['petBreed'] ?? '',
      petDescription: data['petDescription'] ?? '',
      petAge: (data['petAge'] ?? 0).toInt(),
      petWeight: (data['petWeight'] ?? 0).toInt(),
      petLocation: data['petLocation'] ?? '',
      petOwnerPhoneNumber: data['petOwnerPhoneNumber'] ?? '',
      petCategory: data['petCategory'] ?? '',
      isVaccinated: data['isVaccinated'] == true,
      petImages: List<String>.from(data['petImages'] ?? []),
      petGender: data['petGender'] ?? '',
      petOwnerName: data['petOwnerName'] ?? '',
    );
  }
}
