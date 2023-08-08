import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sopping_app/layout/cubit/cubit.dart';
import 'package:sopping_app/shared/styles/colors.dart';

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        bool isPassword = false,
        ValueChanged<String>? onSbmitted,
        ValueChanged<String>? onChanged,
        GestureTapCallback? onTap,
        required FormFieldValidator<String>? validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        VoidCallback? suffixPressed,
        bool isClickable = true}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSbmitted,
      onChanged: onChanged,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback? function,
  required String? text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text!.toUpperCase()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void showToast({required String text, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WARRING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARRING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildListProduct(model, BuildContext context,
        {bool isOldPrice = true}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  fit: BoxFit.cover,
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8.0, color: Colors.white),
                    ),
                  )
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.3, fontSize: 14.0),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: const TextStyle(
                            fontSize: 12.0, color: defaultColor),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                          // log(model.id.toString());
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              ShopCubit.get(context).favorite[model.id]!
                                  ? defaultColor
                                  : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 17.0,
                            color: Colors.white,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
