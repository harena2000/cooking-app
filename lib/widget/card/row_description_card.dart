import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../const/color.dart';

class RowDescriptionCard extends StatefulWidget {
  final bool? isLoading;
  final String? urlImage;
  final String? imageTitle;
  final String? category;
  final String? area;
  final String? stars;
  final int? position;

  const RowDescriptionCard(
      {Key? key,
      this.isLoading = false,
      this.urlImage,
      this.imageTitle,
      this.category,
      this.area,
      this.stars, this.position})
      : super(key: key);

  @override
  State<RowDescriptionCard> createState() => _RowDescriptionCardState();
}

class _RowDescriptionCardState extends State<RowDescriptionCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Card(
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              child: !widget.isLoading!
                  ? Image(
                      image: NetworkImage(widget.urlImage ??
                          "https://www.themealdb.com/images/media/meals/wyxwsp1486979827.jpg"),
                      fit: BoxFit.cover,
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
            child: !widget.isLoading!
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TweenAnimationBuilder(
                          tween: Tween<double>(
                            begin: 20.0,
                            end: 0.0,
                          ),
                          duration: widget.position == 0 ? const  Duration(milliseconds: 500) : Duration(seconds: widget.position!),
                          builder: (BuildContext context, double value,
                              Widget? child) {
                            return Container(
                              margin: EdgeInsets.only(bottom: value),
                              child: CustomText(
                                text: widget.imageTitle ?? "Image Title",
                                size: 15,
                                color: Colors.white,
                                bold: true,
                                overflow: TextOverflow.fade,
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                  text: widget.category ?? "Dessert",
                                  size: 12,
                                  color: AppColor.grey),
                              const SizedBox(
                                width: 5,
                              ),
                              const CustomText(
                                text: " - ",
                                size: 10,
                                color: AppColor.orange,
                                bold: true,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                  text: widget.area ?? "Madagascar",
                                  size: 12,
                                  color: AppColor.grey),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                : const SizedBox()),
        !widget.isLoading! ? Row(
          children: [
            const FaIcon(FontAwesomeIcons.solidStar,
                color: AppColor.orange, size: 12),
            const SizedBox(
              width: 5,
            ),
            Container(
                margin: const EdgeInsets.only(top: 3),
                child: const CustomText(
                    text: "4.5", size: 12, color: AppColor.orange)),
          ],
        ) : const SizedBox()
      ],
    );
  }
}
