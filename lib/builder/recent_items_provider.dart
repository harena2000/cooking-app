import 'package:cooking_app/model/recipe.dart';
import 'package:cooking_app/web/request/get.dart';
import 'package:cooking_app/widget/card/column_description_card.dart';
import 'package:flutter/material.dart';

import '../widget/card/row_description_card.dart';

class RecentItemsProvider extends StatefulWidget {
  const RecentItemsProvider({Key? key}) : super(key: key);

  @override
  State<RecentItemsProvider> createState() => _RecentItemsProviderState();
}

class _RecentItemsProviderState extends State<RecentItemsProvider> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
        future: Get.getListRecipeMeal(),
        builder: (context, snapshot) {
          bool isLoading = false;

          if (!snapshot.hasData) {
            isLoading = true;
          } else {
            isLoading = false;
          }

          return !isLoading
              ? RecentItemsList(data: snapshot.data!)
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                      4,
                      (index) => RowDescriptionCard(
                            isLoading: isLoading,
                          )),
                );
        });
  }
}

class RecentItemsList extends StatefulWidget {
  final List<Recipe> data;

  const RecentItemsList({Key? key, required this.data}) : super(key: key);

  @override
  State<RecentItemsList> createState() => _RecentItemsListState();
}

class _RecentItemsListState extends State<RecentItemsList> {

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<int> _items = [];
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        initialItemCount: widget.data.length < 3 ? widget.data.length : 3,
        itemBuilder: (context, int index, animation) {
          
          _items.add(index);
          
          return SlideTransition(
            position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: const Offset(0,0)
            ).animate(animation),
            child: GestureDetector(
              onTap: () => {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: RowDescriptionCard(
                  urlImage: widget.data[index].strMealThumb!,
                  imageTitle: widget.data[index].strMeal!,
                  category: widget.data[index].strCategory!,
                  area: widget.data[index].strArea!,
                  position: index,
                ),
              ),
            ),
          );
        });
  }
}

