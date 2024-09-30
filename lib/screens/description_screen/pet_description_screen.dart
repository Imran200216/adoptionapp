import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/widgets/pet_description_content.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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
                    Container(
                      height: size.height * 0.062,
                      width: size.width * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryLightShapeColor,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            size: size.height * 0.03,
                            color: AppColors.failureToastColor,
                          ),
                        ),
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
