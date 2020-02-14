import 'package:demo_salesman/locator_cust.dart';
import 'package:demo_salesman/locator_order.dart';
import 'package:demo_salesman/models/crud_cust.dart';
import 'package:demo_salesman/models/crud_order.dart';
import 'package:demo_salesman/screens/customer/customer_map.dart';
import 'package:demo_salesman/screens/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocatorCustomer();
  setupLocatorOrder();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator_order<CRUDModel>()),
        ChangeNotifierProvider(create: (_) => locator_cust<CRUDCustomer>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/dash',
        //home: CustomerMap(),
        title: 'DASHBOARD',
        theme: ThemeData(),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}