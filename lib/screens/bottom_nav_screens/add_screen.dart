import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:adoptionapp/widgets/custom_textfield.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                height: size.height * 0.42,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.zero,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://images.unsplash.com/photo-1570122734014-386e3ef867cc?q=80&w=1936&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    placeholder: (context, url) {
                      return Center(
                        child: LoadingAnimationWidget.newtonCradle(
                          color: AppColors.primaryColor,
                          size: size.width * 0.3,
                        ),
                      );
                    },
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: AppColors.primaryColor,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 30,
                  left: 20,
                  right: 20,
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
                      const CustomTextField(
                        textFieldIcon: Icons.pets,
                        textFieldName: "Pet Name",
                        textFieldInputType: TextInputType.name,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// pet age text field
                      const CustomTextField(
                        textFieldIcon: Icons.pets,
                        textFieldName: "Pet Age",
                        textFieldInputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// pet gender  text field
                      const CustomTextField(
                        textFieldIcon: Icons.pets,
                        textFieldName: "Pet Gender",
                        textFieldInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// pet owner name text field
                      const CustomTextField(
                        textFieldIcon: Icons.person,
                        textFieldName: "Pet Owner Name",
                        textFieldInputType: TextInputType.name,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// pet owner phone number  text field
                      const CustomTextField(
                        textFieldIcon: Icons.call,
                        textFieldName: "Pet Owner Contact",
                        textFieldInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// pet description text field
                      const CustomTextField(
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
            ],
          ),
        ),
      ),
    );
  }
}
