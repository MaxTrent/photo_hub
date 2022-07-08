import 'package:wallpaper_app/models/category_model.dart';

String apiKEY = "563492ad6f91700001000001fa02f2f4fe3541a59cbcac24c6198a46";

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.imgUrl = 'https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  categoryModel.categoryName = 'Food';
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.imgUrl = 'https://images.pexels.com/photos/682933/pexels-photo-682933.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  categoryModel.categoryName = 'Gadgets';
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.imgUrl = 'https://images.pexels.com/photos/1122462/pexels-photo-1122462.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  categoryModel.categoryName = 'Life';
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.imgUrl = 'https://images.pexels.com/photos/1185433/pexels-photo-1185433.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  categoryModel.categoryName = 'People';
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.imgUrl = 'https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  categoryModel.categoryName = 'Nature';
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.imgUrl = 'https://images.pexels.com/photos/734973/pexels-photo-734973.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  categoryModel.categoryName = 'Water';
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.imgUrl = 'https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  categoryModel.categoryName = 'Cityscape';
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.imgUrl = 'https://images.pexels.com/photos/1413412/pexels-photo-1413412.jpeg?auto=compress&cs=tinysrgb&w=400';
  categoryModel.categoryName = 'Bikes';
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.imgUrl = 'https://images.pexels.com/photos/164634/pexels-photo-164634.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  categoryModel.categoryName = 'Cars';
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  return categories;
}