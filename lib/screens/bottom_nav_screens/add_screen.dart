import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/add_post_provider/add_pet_to_firestore_provider.dart';
import 'package:adoptionapp/widgets/custom_drop_down_textfield.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:adoptionapp/widgets/custom_textfield.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Consumer<AddPetToFireStoreProvider>(
          builder: (
            context,
            addPetToFireStoreProvider,
            child,
          ) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 30,
                  bottom: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 600),
                    childAnimationBuilder: (widget) {
                      return SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      );
                    },
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(

                              height: size.height * 0.40,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.secondaryColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    textAlign: TextAlign.start,
                                    'Upload an image to adopt your pets',
                                    maxLines: 2,
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
                                  SvgPicture.asset(
                                    "assets/images/svg/modal-sheet.svg",
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),

                                  /// pick image from camera
                                  CustomIconBtn(
                                    btnHeight: size.height * 0.05,
                                    btnWidth: size.width,
                                    btnText: "Pick image from camera",
                                    btnBorderRadius: 6,
                                    btnOnTap: () {
                                      addPetToFireStoreProvider.onImageTap(
                                        ImageSource.camera,
                                        context,
                                      );
                                    },
                                    btnIcon: Icons.camera,
                                    btnColor: AppColors.primaryColor,
                                    btnTextColor: AppColors.secondaryColor,
                                    btnIconColor: AppColors.secondaryColor,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),

                                  /// pick image from gallery
                                  CustomIconBtn(
                                    btnHeight: size.height * 0.05,
                                    btnWidth: size.width,
                                    btnText: "Pick image from gallery",
                                    btnBorderRadius: 6,
                                    btnOnTap: () {
                                      addPetToFireStoreProvider.onImageTap(
                                        ImageSource.gallery,
                                        context,
                                      );
                                    },
                                    btnIcon: Icons.photo,
                                    btnColor: AppColors.primaryColor,
                                    btnTextColor: AppColors.secondaryColor,
                                    btnIconColor: AppColors.secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: DottedBorder(
                          color: Colors.grey,
                          strokeWidth: 2,
                          dashPattern: const [8, 4],
                          borderType: BorderType.Rect,
                          child: Container(
                            height: size.height * 0.6,
                            width: size.width,
                            alignment: Alignment.center,
                            child: addPetToFireStoreProvider.petImages.isEmpty
                                ? Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          size: size.width * 0.04,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: size.width * 0.03),
                                        Text(
                                          'Add your pet image to adopt',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: size.width * 0.04,
                                            color: Colors.grey,
                                            fontFamily: "NunitoSans",
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : PageView.builder(
                                    itemCount: addPetToFireStoreProvider
                                        .petImages.length,
                                    onPageChanged: addPetToFireStoreProvider
                                        .updateCurrentIndex,
                                    itemBuilder: (context, index) {
                                      return Image.file(
                                        addPetToFireStoreProvider
                                            .petImages[index],
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      // Space between the DottedBorder and the indicator
                      SmoothPageIndicator(
                        controller: PageController(
                            initialPage: addPetToFireStoreProvider
                                .currentIndex), // Set the initial page
                        count: addPetToFireStoreProvider.petImages.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: AppColors.primaryColor,
                          dotColor: AppColors.subTitleColor,
                          dotHeight: 8.0,
                          dotWidth: 8.0,
                        ),
                      ),

                      AutoSizeText(
                        textAlign: TextAlign.start,
                        'Adopt your pet through posting in Rehome',
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: size.width * 0.06,
                          color: AppColors.blackColor,
                          fontFamily: "NunitoSans",
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),

                      /// pet name text field
                      CustomTextField(
                        textEditingController:
                            addPetToFireStoreProvider.petNameController,
                        textFieldIcon: Icons.pets,
                        textFieldName: "Pet Name",
                        textFieldInputType: TextInputType.name,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// pet breed name text field
                      CustomTextField(
                        textEditingController:
                            addPetToFireStoreProvider.petBreedController,
                        textFieldIcon: Icons.pets,
                        textFieldName: "Pet Breed Name",
                        textFieldInputType: TextInputType.name,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// pet age text field
                      CustomTextField(
                        textEditingController:
                            addPetToFireStoreProvider.petAgeController,
                        textFieldIcon: Icons.pets,
                        textFieldName: "Pet Age",
                        textFieldInputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// pet gender  text field
                      CustomDropdown<String>(
                        items: addPetToFireStoreProvider.listPetGender,
                        selectedItem: addPetToFireStoreProvider.valuePetGender,
                        hintText: "Select Pet Gender",
                        dropdownIcon: Icons.arrow_drop_down,
                        onChanged: (newValue) {
                          addPetToFireStoreProvider.setPetGender(newValue);
                        },
                      ),

                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      CustomDropdown<String>(
                        items: addPetToFireStoreProvider.listPetVaccinated,
                        selectedItem:
                            addPetToFireStoreProvider.valuePetVaccinated,
                        hintText: "Select Vaccination Status",
                        dropdownIcon: Icons.arrow_drop_down,
                        onChanged: (newValue) {
                          addPetToFireStoreProvider.setPetVaccinated(newValue);
                        },
                      ),

                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      CustomDropdown<String>(
                        items: addPetToFireStoreProvider.listPetCategory,
                        selectedItem:
                            addPetToFireStoreProvider.valuePetCategory,
                        hintText: "Select Pet Category",
                        dropdownIcon: Icons.arrow_drop_down,
                        onChanged: (newValue) {
                          addPetToFireStoreProvider.setPetCategory(newValue);
                        },
                      ),

                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// pet owner name text field
                      CustomTextField(
                        textEditingController:
                            addPetToFireStoreProvider.petOwnerNameController,
                        textFieldIcon: Icons.person,
                        textFieldName: "Pet Owner Name",
                        textFieldInputType: TextInputType.name,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// pet owner phone number  text field
                      CustomTextField(
                        textEditingController:
                            addPetToFireStoreProvider.petOwnerPhoneController,
                        textFieldIcon: Icons.call,
                        textFieldName: "Pet Owner Contact",
                        textFieldInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// pet location text field
                      CustomTextField(
                        textEditingController:
                            addPetToFireStoreProvider.petLocationController,
                        textFieldIcon: Icons.location_city,
                        textFieldName: "Pet Location",
                        textFieldInputType: TextInputType.streetAddress,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// pet description text field
                      CustomTextField(
                        textEditingController:
                            addPetToFireStoreProvider.petDescriptionController,
                        textFieldIcon: Icons.description,
                        textFieldName: "Pet Description",
                        textFieldInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),

                      /// add btn
                      CustomIconBtn(
                        btnHeight: size.height * 0.058,
                        btnWidth: size.width,
                        btnText: "Add post",
                        btnBorderRadius: 4,
                        btnOnTap: () {
                          /// add posting functionality in firebase
                        },
                        btnIcon: Icons.add,
                        btnColor: AppColors.primaryColor,
                        btnTextColor: AppColors.secondaryColor,
                        btnIconColor: AppColors.secondaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
