import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sopping_app/layout/cubit/cubit.dart';
import 'package:sopping_app/layout/cubit/states.dart';
import 'package:sopping_app/models/categories_model.dart';
import 'package:sopping_app/shared/component/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCatItem(
                  ShopCubit.get(context).categoriesModel!.data.data[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount:
                  ShopCubit.get(context).categoriesModel!.data.data.length);
        },
        listener: (context, state) {});
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              model.name,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
