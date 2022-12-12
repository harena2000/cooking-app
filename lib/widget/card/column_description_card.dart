import 'dart:convert';

import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../const/color.dart';

class ColumnDescriptionCard extends StatefulWidget {
  final bool? isLoading;
  final String? urlImage;
  final String? imageTitle;
  final String? category;
  final String? area;
  final String? stars;

  const ColumnDescriptionCard(
      {Key? key,
      this.isLoading = false,
      this.urlImage,
      this.imageTitle,
      this.category,
      this.area,
      this.stars})
      : super(key: key);

  @override
  State<ColumnDescriptionCard> createState() => _ColumnDescriptionCardState();
}

class _ColumnDescriptionCardState extends State<ColumnDescriptionCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: 250,
            child: Card(
              elevation: 8,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                child: !widget.isLoading!
                    ? Image(
                        image: NetworkImage(widget.urlImage!),
                        fit: BoxFit.cover,
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: 210,
            margin: const EdgeInsets.only(left: 10),
            child: !widget.isLoading!
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: widget.imageTitle!,
                        size: 15,
                        color: Colors.white,
                        bold: true,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                  text: widget.category!,
                                  size: 12,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
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
                                  text: widget.area!,
                                  size: 12,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                  color: AppColor.grey),
                            ],
                          ),
                          Row(
                            children: [
                              const FaIcon(FontAwesomeIcons.solidStar,
                                  color: AppColor.orange, size: 12),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  child: const CustomText(
                                      text: "4.5",
                                      size: 12,
                                      color: AppColor.orange)),
                            ],
                          )
                        ],
                      )
                    ],
                  )
                : const LinearProgressIndicator(),
          )
        ],
      ),
    );
  }
}
