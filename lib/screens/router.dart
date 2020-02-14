import 'package:demo_salesman/screens/customer/add_customer.dart';
import 'package:demo_salesman/screens/customer/customer_map.dart';
import 'package:demo_salesman/screens/customer/customer_screen.dart';
import 'package:demo_salesman/screens/customer/edit_customer.dart';
import 'package:demo_salesman/screens/dashboard/dashboard.dart';
import 'package:demo_salesman/screens/dashboard/dashboard_main.dart';
import 'package:demo_salesman/screens/order/add_order.dart';
import 'package:demo_salesman/screens/order/order_screen.dart';
import 'package:demo_salesman/screens/sales/sales_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return  MaterialPageRoute(
            builder: (_)=> MainDashboard()
        );
      case '/dash' :
        return MaterialPageRoute(
            builder: (_)=> Dashboard()
        ) ;
      case '/customer' :
        return MaterialPageRoute(
            builder: (_)=> CustomerScreen()
        ) ;
      case '/order' :
        return MaterialPageRoute(
            builder: (_)=> OrderScreen()
        ) ;
      case '/customeredit' :
        return MaterialPageRoute(
            builder: (_)=> EditCustomer()
        ) ;
      case '/customeradd' :
        return MaterialPageRoute(
            builder: (_)=> AddCustomer()
        ) ;
      case '/customermap' :
        return MaterialPageRoute(
            builder: (_)=> CustomerMap()
        ) ;
      case '/orderadd' :
        return MaterialPageRoute(
            builder: (_)=> AddOrder()
        ) ;
      case '/sales' :
        return MaterialPageRoute(
            builder: (_)=> SalesScreen()
        ) ;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}