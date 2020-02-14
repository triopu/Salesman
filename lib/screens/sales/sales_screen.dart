import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_salesman/models/crud_order.dart';
import 'package:demo_salesman/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  List<Order> _order = [];

  var data = [];
  String chartType = 'pie';
  String startDate = '0000-00-00';
  String endDate = '0000-00-00';

  int omset = 0;
  int acv = 0;

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectStart(BuildContext context) async{
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2016,1),
        lastDate: DateTime(2021,1));
    if(picked != null && picked != selectedDate){
      setState(() {
        startDate = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<Null> _selectEnd(BuildContext context) async{
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2016,1),
        lastDate: DateTime(2021,1));
    if(picked != null && picked != selectedDate){
      setState(() {
        endDate = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<CRUDModel>(context);
    int totOrder = 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 5,),
            Container(
              child: StreamBuilder(
                stream: orderProvider.fetchOrdersAsStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData) {
                    _order = snapshot.data.documents
                        .map((doc) => Order.fromMap(doc.data, doc.documentID))
                        .toList();

                    return LayoutBuilder(
                      builder:(context,constraints) => Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                    onPressed:(){
                                      setState(() {
                                        chartType = 'bar';
                                      });
                                    }, icon:Icon(Icons.insert_chart)),
                                IconButton(
                                    onPressed:(){
                                      setState(() {
                                        chartType = 'horBar';
                                      });
                                    }, icon:Icon(Icons.panorama_horizontal)),
                                IconButton(
                                    onPressed:(){
                                      setState(() {
                                        chartType = 'pie';
                                      });
                                    }, icon:Icon(Icons.show_chart)),
                                IconButton(
                                    onPressed:(){
                                      calculate(_order);
                                    }, icon:Icon(Icons.attach_money)),
                              ],
                            ),
                          ),
                          getBarChart(_order,chartType),
                        ],
                      ),
                    );
                  } else {
                    return Text('fetching');
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DataTable(
                columnSpacing: 0,
                columns: [
                  DataColumn(label: Text('From')),
                  DataColumn(label: Text('To'))
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Row(
                      children: <Widget>[
                        Text('$startDate'),
                        IconButton(
                          onPressed: ()async{
                            await _selectStart(context);
                          },icon: Icon(Icons.arrow_drop_up),
                        )
                      ],
                    )
                    ),
                    DataCell(Row(
                      children: <Widget>[
                        Text('$endDate'),
                        IconButton(
                          onPressed: ()async{
                            await _selectEnd(context);
                          },icon: Icon(Icons.arrow_drop_down),
                        )
                      ],
                    ))
                  ]),DataRow(cells: [
                    DataCell(Row(
                      children: <Widget>[
                        Text('Omset: Rp. $omset'),
                      ],
                    )
                    ),
                    DataCell(Row(
                      children: <Widget>[
                        Text('ACV: $acv %'),
                      ],
                    ))
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculate(List<Order> orders){
    int totOrder = 0;
    orders.forEach((val){
      totOrder = totOrder + int.parse(val.tot);
    });

    omset = totOrder*100;
    double varacv = ((omset - totOrder*80)/omset)*100.0;
    acv = varacv.round();

    setState(() {
      omset = omset;
      acv = acv;
    });
  }

  Widget getBarChart(List<Order> orders, String chartType){
    Widget chart;

    List<Order> pickedOrder = [];

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime after = dateFormat.parse(startDate);
    DateTime before = dateFormat.parse(endDate);

    for(int i = 0; i < orders.length; i++){
      if( dateFormat.parse(orders[i].date).isAfter(after) &&
          dateFormat.parse(orders[i].date).isBefore(before)){
        pickedOrder.add(orders[i]);
      }
    }

    if(pickedOrder.length < 1){
      return Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          height: 200, width: 500,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.bubble_chart, size: 100,
                  color: Colors.blue,
                ),
                Text("Data Tidak Ada\nSilakan Tambah Order/Ganti Rentang",textAlign:TextAlign.center,)
              ],
            ),
          ),
        ),
      );
    }

    if(pickedOrder.length > 5){
      List<Order> pickedOrderTemp = [];
      pickedOrder.sort((a,b) => b.tot.compareTo(a.tot));
      for(int i = 0; i < 5; i++){
        pickedOrderTemp.add(pickedOrder[i]);
      }
      pickedOrder = pickedOrderTemp;
    }

    var series = [
      charts.Series(
        domainFn: (Order order, _) => order.no,
        measureFn: (Order order, _) => double.parse(order.tot),
        data: pickedOrder,
        id: 'Order',
        labelAccessorFn: chartType == 'pie'?(Order order, _) => '${order.no}':null,
      )
    ];

    if(chartType == 'bar') {
      chart = new Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(height: 200, width: 500,
          child: charts.BarChart(series, animate: true,vertical: true,
          ),
        ),
      );
    }

    if(chartType == 'horBar') {

      chart = new Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(height: 200, width: 500,
          child: charts.BarChart(series, animate: true,vertical: false,
          ),
        ),
      );
    }

    if(chartType == 'pie') {
      chart = Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(height: 200, width: 400,
            child: charts.PieChart(series, animate: true,
              defaultRenderer: new charts.ArcRendererConfig(
                arcWidth: 60,
                  arcRendererDecorators: [charts.ArcLabelDecorator()]),
            ),
          ),
        ),
      );
    }

    return chart;
  }
}
