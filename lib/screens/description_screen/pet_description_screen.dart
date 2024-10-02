import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/widgets/circular_icon_btn.dart';
import 'package:adoptionapp/widgets/custom_btn.dart';
import 'package:adoptionapp/widgets/pet_description_content.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PetDescriptionScreen extends StatelessWidget {
  const PetDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: size.height * 0.03,
                        color: AppColors.subTitleColor,
                      ),
                    ),

                    /// favorite btn
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        size: size.height * 0.03,
                        color: AppColors.failureToastColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),

              /// pet image
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                height: size.height * 0.24,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1422565096762-bdb997a56a84?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.04,
              ),

              /// Expanded section to make it scrollable
              Expanded(
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 26,
                        bottom: 20,
                        right: 20,
                        left: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// pet name
                          AutoSizeText(
                            textAlign: TextAlign.start,
                            'Dubby',
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: size.width * 0.06,
                              color: AppColors.petDescriptionTitleColor,
                              fontFamily: "NunitoSans",
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.001,
                          ),

                          /// pet breed name
                          AutoSizeText(
                            textAlign: TextAlign.start,
                            'German Shepherd',
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: size.width * 0.04,
                              color: AppColors.petDescriptionSubTitleColor,
                              fontFamily: "NunitoSans",
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// pet gender
                              PetDescriptionContent(
                                dividerColor: Color(0xFFFFE7A9),
                                petDescriptionContentTitle: "Male",
                                petDescriptionContentSubTitle: "Gender",
                              ),

                              /// pet age
                              PetDescriptionContent(
                                dividerColor: Color(0xFFFFDFDF),
                                petDescriptionContentTitle: "2 Months",
                                petDescriptionContentSubTitle: "Age",
                              ),

                              /// pet weight
                              PetDescriptionContent(
                                dividerColor: Color(0xFFEEDFFF),
                                petDescriptionContentTitle: "8 kg",
                                petDescriptionContentSubTitle: "Weight",
                              ),
                            ],
                          ),

                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          /// vaccinated or not
                          Container(
                            height: size.height * 0.05,
                            width: size.width * 0.44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFF7ED596),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    textAlign: TextAlign.start,
                                    'Vaccinated',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: size.width * 0.04,
                                      color: const Color(0xFF445549),
                                      fontFamily: "NunitoSans",
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  SvgPicture.asset(
                                    "assets/images/svg/correct-icon.svg",
                                    height: size.height * 0.03,
                                    fit: BoxFit.cover,
                                    color: const Color(0xFF445549),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          /// address
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // To ensure alignment at the top
                            children: [
                              Container(
                                height: size.height * 0.12,
                                width: size.width * 0.12,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFE5F3F8),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.location_on,
                                    size: size.height * 0.03,
                                    color: const Color(0xFF85C1E1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.04,
                              ),
                              Expanded(
                                // Allowing the text to expand within available space
                                child: AutoSizeText(
                                  "No 35, 1st cross thendral nagar, new saram, puducherry - 605013",
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  // Add ellipsis if the text overflows
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width * 0.04,
                                    color:
                                        AppColors.petDescriptionSubTitleColor,
                                    fontFamily: "NunitoSans",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// pet description
                          AutoSizeText(
                            textAlign: TextAlign.start,
                            'About Buddy',
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: size.width * 0.054,
                              color: AppColors.petDescriptionTitleColor,
                              fontFamily: "NunitoSans",
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.01,
                          ),

                          AutoSizeText(
                            textAlign: TextAlign.start,
                            '''Buddy is a playful, loyal, and affectionate Golden Retriever who's ready to find his forever home! At just 2 years old, Buddy has the energy of a puppy but with the charm and manners of a mature dog. He's the perfect companion for someone who enjoys outdoor activities, long walks, or simply snuggling on the couch.''',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: size.width * 0.042,
                              color: AppColors.petDescriptionSubTitleColor,
                              fontFamily: "NunitoSans",
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          Row(
                            children: [
                              Row(
                                children: [
                                  /// calling phone number functionality
                                  CircularIconBtn(
                                    onTap: () {
                                      FlutterPhoneDirectCaller.callNumber(
                                          "+919677588696");
                                    },
                                    btnIcon: Icons.phone,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                  CircularIconBtn(
                                    onTap: () {},
                                    btnIcon: Icons.chat,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: size.width * 0.08,
                              ),
                              Expanded(
                                child: CustomBtn(
                                  btnHeight: size.height * 0.052,
                                  btnWidth: size.width,
                                  btnText: "Adopt Buddy",
                                  btnBorderRadius: 6,
                                  btnOnTap: () {
                                    /// adopt functionality
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
