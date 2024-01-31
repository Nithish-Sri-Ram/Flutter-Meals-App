import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

final mealsProvider = Provider((ref) => dummyMeals);    //This normal provider can be used when the list is static and not changing