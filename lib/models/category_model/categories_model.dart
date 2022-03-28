import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CategoryModel extends Equatable {
  final String imageName;
  final String imgUrl;
  CategoryModel({required this.imageName, required this.imgUrl});

  @override
  List<Object?> get props => [imageName, imgUrl];

  static List<CategoryModel> categoryModel = [
    CategoryModel(
      imageName: "Dry Fruits",
      imgUrl:
          "https://images.unsplash.com/photo-1595412017587-b7f3117dff54?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80",
    ),
    CategoryModel(
      imageName: "Vegetables",
      imgUrl:
          "https://images.unsplash.com/photo-1590779033100-9f60a05a013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    ),
    CategoryModel(
      imageName: "Fruits",
      imgUrl:
          "https://images.unsplash.com/photo-1573246123716-6b1782bfc499?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80",
    ),
  ];
}
