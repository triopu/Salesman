import 'package:get_it/get_it.dart';

import 'package:demo_salesman/services/api.dart';
import 'package:demo_salesman/models/crud_order.dart';

GetIt locator_order = GetIt();

void setupLocatorOrder() {
  locator_order.registerLazySingleton(() => Api('orders'));
  locator_order.registerLazySingleton(() => CRUDModel()) ;
}