import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/add_post_provider/add_pet_to_firestore_provider.dart';
import 'package:adoptionapp/widgets/custom_drop_down_textfield.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:adoptionapp/widgets/custom_image_picker_bottom_modal_sheet.dart';
import 'package:adoptionapp/widgets/custom_textfield.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddPetContent extends StatelessWidget {
  const AddPetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
                              height: size.height * 0.20,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.secondaryColor,
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 20,
                                  bottom: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    /// Take photo
                                    InkWell(
                                      onTap: () {
                                        addPetToFireStoreProvider.pickImage(
                                          ImageSource.camera,
                                          context,
                                        );
                                        Navigator.pop(
                                            context); // Close the bottom sheet
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.camera,
                                            size: size.height * 0.036,
                                            color: AppColors.blackColor,
                                          ),
                                          SizedBox(width: size.width * 0.03),
                                          AutoSizeText(
                                            textAlign: TextAlign.start,
                                            'Take photo',
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: size.width * 0.046,
                                              color: AppColors.blackColor,
                                              fontFamily: "NunitoSans",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.02),

                                    /// Choose from gallery
                                    InkWell(
                                      onTap: () {
                                        addPetToFireStoreProvider.pickImage(
                                          ImageSource.gallery,
                                          context,
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.photo,
                                            size: size.height * 0.036,
                                            color: AppColors.blackColor,
                                          ),
                                          SizedBox(width: size.width * 0.03),
                                          AutoSizeText(
                                            textAlign: TextAlign.start,
                                            'Pick image from gallery',
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: size.width * 0.046,
                                              color: AppColors.blackColor,
                                              fontFamily: "NunitoSans",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                  ],
                                ),
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
                                            .petImages.length +
                                        1,
                                    // +1 for "Add Image" DottedBorder
                                    onPageChanged: addPetToFireStoreProvider
                                        .updateCurrentIndex,
                                    itemBuilder: (context, index) {
                                      // If it's the last index, show the "Add Image" option
                                      if (index ==
                                          addPetToFireStoreProvider
                                              .petImages.length) {
                                        return InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  CustomImagePickerBottomSheet(
                                                onImagePicked:
                                                    (ImageSource source) {
                                                  addPetToFireStoreProvider
                                                      .pickImage(
                                                    source,
                                                    context,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: DottedBorder(
                                            color: Colors.grey,
                                            strokeWidth: 2,
                                            dashPattern: const [8, 4],
                                            borderType: BorderType.Rect,
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.add_a_photo,
                                                    size: size.width * 0.04,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                      width: size.width * 0.03),
                                                  Text(
                                                    'Add another image',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize:
                                                          size.width * 0.04,
                                                      color: Colors.grey,
                                                      fontFamily: "NunitoSans",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        // Show the picked image
                                        return Image.file(
                                          addPetToFireStoreProvider
                                              .petImages[index],
                                          fit: BoxFit.cover,
                                        );
                                      }
                                    },
                                  ),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),

                      addPetToFireStoreProvider.petImages.isNotEmpty
                          ? Center(
                              child: SmoothPageIndicator(
                                controller: PageController(
                                  initialPage:
                                      addPetToFireStoreProvider.currentIndex,
                                ),
                                count:
                                    addPetToFireStoreProvider.petImages.length +
                                        1,
                                // +1 for "Add Image" page
                                effect: ExpandingDotsEffect(
                                  activeDotColor: AppColors.primaryColor,
                                  dotColor: AppColors.subTitleColor,
                                  dotHeight: 8.0,
                                  dotWidth: 8.0,
                                ),
                              ),
                            )
                          : const SizedBox(),

                      SizedBox(
                        height: size.height * 0.03,
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
