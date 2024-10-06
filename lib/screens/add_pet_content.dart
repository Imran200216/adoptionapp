import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/add_post_provider/add_pet_to_firestore_provider.dart';
import 'package:adoptionapp/widgets/add_text_field.dart';
import 'package:adoptionapp/widgets/custom_radio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            addPetToFirebase,
            child,
          ) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            dashPattern: const [6, 6],
                            color: Colors.grey.shade300,
                            radius: const Radius.circular(12),
                            strokeWidth: 2,
                            child: Container(
                              width: size.width,
                              height: size.height * 0.40,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.grey.shade400,
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    "https://imgs.search.brave.com/G7EAKN2_tgpXRvp6SG9UP-WdSrIotMa3XzzGAZ29UCo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAwLzIzLzcyLzU5/LzM2MF9GXzIzNzI1/OTQ0X1cyYVNyZzNL/cXczbE9tVTRJQW43/aVhWODhSbm5mY2gx/LmpwZw",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.06,
                        ),
                        Container(
                          height: size.height,
                          width: size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                            color: Color(0xFFFFEDE9),
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                              margin: const EdgeInsets.all(20),
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
                                    height: size.height * 0.04,
                                  ),

                                  /// pet name text field
                                  const AddTextField(
                                    prefixIconPath: "pet-logo",
                                    hintText: "Pet name",
                                    keyboardTextInputType: TextInputType.name,
                                  ),

                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),

                                  Container(
                                    height: size.height * 0.20,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.secondaryColor,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(20),
                                      child: CustomRadio(
                                        options: const [
                                          'Dog',
                                          'Cat',
                                          'Bird',
                                          'Fish',
                                          'Others'
                                        ],
                                        selectedOption:
                                            addPetToFirebase.selectedPetType,
                                        onChanged: (value) {
                                          addPetToFirebase.setPetType(value!);
                                        },
                                        title: "Pet Type ",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
    );
  }
}
