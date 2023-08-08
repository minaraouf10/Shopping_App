import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sopping_app/layout/cubit/cubit.dart';
import 'package:sopping_app/layout/cubit/states.dart';
import 'package:sopping_app/shared/component/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          if (state is! ShopLoadingGetFavoritesState) {
            final favoritesModel = ShopCubit.get(context).favoritesModel;
            if (favoritesModel != null &&
                favoritesModel.data != null &&
                favoritesModel.data!.data != null &&
                favoritesModel.data!.data!.isNotEmpty) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final product = favoritesModel.data!.data![index].product;
                  if (product != null) {
                    return buildListProduct(product, context);
                  } else {
                    return Container(); // Replace with appropriate fallback widget
                  }
                },
                separatorBuilder: (context, index) => myDivider(),
                itemCount: favoritesModel.data!.data!.length,
              );
            } else {
              return const Center(child: Text('No favorites found.'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },

        listener: (context, state) {});
  }
}

// class FavoritesScreen extends StatelessWidget {
//   const FavoritesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ShopCubit, ShopStates>(
//       builder: (context, state) {
//         if (state is ShopLoadingGetFavoritesState) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           final favoritesModel = ShopCubit.get(context).favoritesModel;
//           if (favoritesModel != null && favoritesModel.data != null) {
//             return ListView.separated(
//               physics: const BouncingScrollPhysics(),
//               itemBuilder: (context, index) =>
//                   buildListProduct(favoritesModel.data!.data![index].product!, context),
//               separatorBuilder: (context, index) => myDivider(),
//               itemCount: favoritesModel.data!.data!.length,
//             );
//           } else {
//             return const Center(child: Text('No favorites found.'));
//           }
//         }
//       },
//       listener: (context, state) {},
//     );
//   }
// }
