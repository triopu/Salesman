import 'package:get_it/get_it.dart';

import 'package:demo_salesman/services/api.dart';
import 'package:demo_salesman/models/crud_cust.dart';

GetIt locator_cust = GetIt();

void setupLocatorCustomer() {
  locator_cust.registerLazySingleton(() => Api('customers'));
  locator_cust.registerLazySingleton(() => CRUDCustomer()) ;
}