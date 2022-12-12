import 'package:cooking_app/model/recipe.dart';
import 'package:cooking_app/web/request/get.dart';
import 'package:cooking_app/widget/card/column_description_card.dart';
import 'package:flutter/material.dart';

class BestFoodProvider extends StatefulWidget {
  const BestFoodProvider({Key? key}) : super(key: key);

  @override
  State<BestFoodProvider> createState() => _BestFoodProviderState();
}

class _BestFoodProviderState extends State<BestFoodProvider> {
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
              ? BestFoodList(data: snapshot.data!)
              : ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      5,
                      (index) => ColumnDescriptionCard(
                            isLoading: isLoading,
                          )),
                );
        });
  }
}

class BestFoodList extends StatelessWidget {
  final List<Recipe> data;

  const BestFoodList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => {},
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: ColumnDescriptionCard(
                urlImage: data[index].strMealThumb!,
                imageTitle: data[index].strMeal!,
                category: data[index].strCategory!,
                area: data[index].strArea!,
              ),
            ),
          );
        });
  }
}
