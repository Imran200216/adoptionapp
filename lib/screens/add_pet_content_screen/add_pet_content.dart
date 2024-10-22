import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/add_post_provider/add_pet_to_firestore_provider.dart';
import 'package:adoptionapp/provider/app_required_providers/scroll_provider.dart';
import 'package:adoptionapp/provider/screen_provider/bottom_nav_provider.dart';
import 'package:adoptionapp/widgets/add_text_field.dart';
import 'package:adoptionapp/widgets/custom_alert_dialog.dart';
import 'package:adoptionapp/widgets/custom_description_text_field.dart';
import 'package:adoptionapp/widgets/custom_drop_down_textfield.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:adoptionapp/widgets/custom_image_picker_bottom_modal_sheet.dart';
import 'package:adoptionapp/widgets/custom_phone_text_field.dart';
import 'package:adoptionapp/widgets/custom_radio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddPetContent extends StatelessWidget {
  const AddPetContent({super.key});

  @override
  Widget build(BuildContext context) {
    /// media query
    final size = MediaQuery.of(context).size;

    /// provider
    var addPetToFireStoreProvider =
        Provider.of<AddPetToFireStoreProvider>(context);

    /// closing alert dailog box
    Future<bool> showExitConfirmationDialog(BuildContext context) async {
      return showDialog<bool>(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            title: "Exit without saving?",
            content:
                "You have unsaved changes. Do you want to exit without saving?",
            confirmText: "Exit",
            cancelText: "Cancel",
            onConfirm: () {
              // Clear all the text fields
              addPetToFireStoreProvider.clearForm();
              Navigator.of(context).pop(false); // User cancels
            },
            onCancel: () {
              // Close the dialog
              Navigator.of(context).pop(true); // User confirms exit
            },
          );
        },
      ).then(
          (value) => value ?? false); // Default to false if dialog is dismissed
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () async {
              // Check if there are unsaved changes
              bool hasUnsavedChanges =
                  addPetToFireStoreProvider.isFormPartiallyFilled();

              if (hasUnsavedChanges) {
                // Show confirmation dialog
                final shouldExit = await showExitConfirmationDialog(context);
                if (shouldExit) {
                  // Navigate to the specific tab using BottomNavProvider
                  final bottomNavProvider =
                      Provider.of<BottomNavProvider>(context, listen: false);
                  bottomNavProvider.navigateToIndex(
                      context, 0); // Navigate to Home tab
                }
              } else {
                // No unsaved changes, navigate directly
                final bottomNavProvider =
                    Provider.of<BottomNavProvider>(context, listen: false);
                bottomNavProvider.navigateToIndex(
                    context, 0); // Navigate to Home tab
              }
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: size.height * 0.026,
              color: AppColors.secondaryColor,
            ),
          ),
          title: const Text("Add details for adoption"),
          titleTextStyle: TextStyle(
            fontSize: size.width * 0.042,
            color: AppColors.secondaryColor,
            fontFamily: "NunitoSans",
            fontWeight: FontWeight.w800,
          ),
        ),
        body: SingleChildScrollView(
          // Add this line
          child: Consumer3<AddPetToFireStoreProvider, ScrollProvider,
              BottomNavProvider>(
            builder: (
              context,
              addPetToFirebase,
              scrollProvider,
              bottomNavProvider,
              child,
            ) {
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 12,
                      ),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return CustomImagePickerBottomSheet(
                                onImagePicked: (ImageSource source) {
                                  addPetToFirebase.pickImage(source, context);
                                  Navigator.pop(
                                      context); // Close the bottom sheet
                                },
                              );
                            },
                          );
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          dashPattern: const [6, 6],
                          color: Colors.grey.shade400,
                          radius: const Radius.circular(12),
                          strokeWidth: 2,
                          child: Container(
                            width: size.width,
                            height: size.height * 0.40,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.grey.shade200,
                            ),
                            child: PageView.builder(
                              controller: addPetToFirebase.pageController,
                              itemCount: addPetToFirebase.petImages.length + 1,
                              itemBuilder: (context, index) {
                                if (index ==
                                    addPetToFirebase.petImages.length) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(14),
                                      color: AppColors.transparentColor,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/svg/add-photo-icon.svg",
                                            height: size.height * 0.06,
                                            width: size.width * 0.06,
                                            fit: BoxFit.cover,
                                            color: AppColors.subTitleColor,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          Text(
                                            "Add more photos",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.subTitleColor,
                                              fontFamily: "NunitoSans",
                                              fontSize: size.width * 0.04,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  // Show picked images
                                  return InstaImageViewer(
                                    backgroundColor: AppColors.blackColor,
                                    disableSwipeToDismiss: true,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14),
                                      child: Image.file(
                                        addPetToFirebase.petImages[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (addPetToFirebase.petImages.isNotEmpty)
                    Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        SmoothPageIndicator(
                          controller: addPetToFirebase.pageController,
                          count: addPetToFirebase.petImages.length + 1,
                          // Add 1 for the DottedBorder page
                          effect: WormEffect(
                            activeDotColor: AppColors.primaryColor,
                            dotColor: AppColors.subTitleColor,
                            dotHeight: 10,
                            dotWidth: 10,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Container(
                    width: size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      color: Color(0xFFFFEDE9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Adopt your pet through posting in ReHome",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: size.width * 0.06,
                              color: AppColors.blackColor,
                              fontFamily: "NunitoSans",
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          /// pet name text field
                          AddTextField(
                            textEditingController:
                                addPetToFirebase.petNameController,
                            prefixIconPath: "pet-logo",
                            hintText: "Pet name",
                            keyboardTextInputType: TextInputType.name,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          /// pet type
                          Container(
                            height: size.height * 0.20,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.secondaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CustomRadio(
                                options: const [
                                  'Dogs',
                                  'Cats',
                                  'Birds',
                                  'Others'
                                ],
                                selectedOption:
                                    addPetToFirebase.selectedPetType,
                                onChanged: (value) {
                                  addPetToFirebase.setPetType(value!);
                                },
                                title: "Pet Type",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          /// pet breed name text field
                          AddTextField(
                            textEditingController:
                                addPetToFirebase.petBreedController,
                            prefixIconPath: "pet-logo",
                            hintText: "Pet breed name",
                            keyboardTextInputType: TextInputType.name,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          /// pet age drop down text field
                          CustomDropdown<int>(
                            items: List.generate(50, (index) => index + 1),
                            selectedItem: addPetToFirebase.selectedPetAge,
                            onChanged: (value) {
                              if (value != null) {
                                addPetToFirebase.setPetAge(value);
                              }
                            },
                            hintText: "Pet age",
                            prefixIconPath: "pet-age-icon",
                          ),

                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          /// pet weight check box
                          AddTextField(
                            textEditingController:
                                addPetToFirebase.petWeightController,
                            prefixIconPath: "pet-weight-icon",
                            hintText: "Pet weight in kg",
                            keyboardTextInputType: TextInputType.number,
                          ),

                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          /// pet gender check box
                          Container(
                            height: size.height * 0.14,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.secondaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CustomRadio(
                                options: const ['Male', 'Female'],
                                selectedOption: addPetToFirebase.selectedGender,
                                onChanged: (value) {
                                  addPetToFirebase.setGender(value!);
                                },
                                title: "Pet Gender",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          /// pet vaccinated status check box
                          Container(
                            height: size.height * 0.14,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.secondaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CustomRadio(
                                options: const ['Vaccinated', 'Not vaccinated'],
                                selectedOption:
                                    addPetToFirebase.vaccinationStatus,
                                onChanged: (value) {
                                  addPetToFirebase.setVaccinationStatus(value!);
                                },
                                title: "Pet Vaccination Status",
                              ),
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          /// pet owner name text field
                          AddTextField(
                            textEditingController:
                                addPetToFirebase.petOwnerNameController,
                            prefixIconPath: "profile-icon",
                            hintText: "Pet owner name",
                            keyboardTextInputType: TextInputType.name,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          /// pet owner contact text field
                          CustomPhoneTextField(
                            controller:
                                addPetToFirebase.petOwnerPhoneController,
                            hintText: "Pet owner contact",
                            initialCountryCode: 'IN',
                            // Set your initial country code
                            onChanged: (phone) {
                              addPetToFirebase.setCompletePhoneNumber(
                                  phone); // Save the complete phone number
                            },
                          ),

                          SizedBox(
                            height: size.height * 0.04,
                          ),

                          /// pet location text field
                          DescriptionTextField(
                            prefixIcon: Icons.location_city,
                            hintText: "Pet Location...",
                            controller: addPetToFirebase.petLocationController,
                            maxLines: 8,
                          ),

                          SizedBox(
                            height: size.height * 0.05,
                          ),

                          /// pet description text field
                          DescriptionTextField(
                            prefixIcon: Icons.description,
                            hintText: "Describe your pet...",
                            controller:
                                addPetToFirebase.petDescriptionController,
                            maxLines: 8,
                          ),

                          SizedBox(
                            height: size.height * 0.05,
                          ),

                          addPetToFirebase.isLoading
                              ? Center(
                                  child: LoadingAnimationWidget.discreteCircle(
                                    color: AppColors.primaryColor,
                                    size: size.width * 0.07,
                                  ),
                                )
                              : CustomIconBtn(
                                  btnHeight: size.height * 0.06,
                                  btnWidth: size.width,
                                  btnText: "Add adoption",
                                  btnBorderRadius: 6,
                                  btnOnTap: () {
                                    /// add post to the database
                                    addPetToFirebase.addPetToFireStore(context);
                                  },
                                  btnIcon: Icons.pets,
                                  btnColor: AppColors.primaryColor,
                                  btnTextColor: AppColors.secondaryColor,
                                  btnIconColor: AppColors.secondaryColor,
                                ),

                          SizedBox(
                            height: size.height * 0.05,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
