import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String?) onChanged;
  final String title;

  const CustomRadio({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          textAlign: TextAlign.start,
          title,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: size.width * 0.040,
            color: Colors.black,
            fontFamily: "NunitoSans",
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: options.map((option) {
            return InkWell(
              onTap: () {
                onChanged(option);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                  horizontal: size.width * 0.05,
                ),
                decoration: BoxDecoration(
                  color: selectedOption == option
                      ? Colors.orangeAccent
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: selectedOption == option
                        ? Colors.orangeAccent
                        : Colors.grey,
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color:
                        selectedOption == option ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.035,
                    fontFamily: "NunitoSans",
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
