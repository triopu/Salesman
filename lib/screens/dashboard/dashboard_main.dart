import 'package:demo_salesman/screens/customer/customer_screen.dart';
import 'package:demo_salesman/screens/order/order_screen.dart';
import 'package:demo_salesman/screens/sales/sales_screen.dart';
import 'package:flutter/material.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  String _textMain = 'DASHBOARD';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            title: Text(_textMain),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.monetization_on),
                color: Colors.white,
                onPressed: (){
                  print('I am clicked');
                },
              ),
            ],
            leading: Builder(
                builder: (BuildContext context){
                  return IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () async {
                      print("Go to dashboard");
                      dynamic result = await Navigator.pushNamed(context, '/dash');
                    },
                  );
                }),
            bottom: TabBar(
              indicatorPadding: EdgeInsets.all(5),
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab ,
              indicator: BoxDecoration(
                color: Colors.blue,
              ),
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('SALES'),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('CUSTOMER'),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('ORDER'),
                  ),
                )
            ]),
          ),
          body: TabBarView(
            children: <Widget>[
              SalesScreen(),
              CustomerScreen(),
              OrderScreen()
            ],
          ),
        ),
    );
  }
}

