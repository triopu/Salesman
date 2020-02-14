import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_salesman/models/crud_order.dart';
import 'package:demo_salesman/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> _searchResult = [];
  List<Order> _orderDetails = [];
  List<Order> _order = [];
  List<Order> _showedOrder = [];
  var txtTotal = TextEditingController();
  bool showSearch = false;

  @override
  void initState(){
    super.initState();
  }

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    int totOrder = 0;
    final orderProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: ListView(
          children: <Widget>[

            Container(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(8,0,8,0),
                child: new Card(
                  child: new ListTile(
                    leading: new Icon(Icons.search),
                    title: new TextField(
                      controller: controller,
                      decoration: new InputDecoration(
                          hintText: 'Cari Pelanggan', border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },),
                  ),
                ),
              ),
            ),

            Container(
              child: StreamBuilder(
                stream: orderProvider.fetchOrdersAsStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData){
                    _order = snapshot.data.documents
                        .map((doc) => Order.fromMap(doc.data, doc.documentID))
                        .toList();

                    _showedOrder = showSearch?_searchResult:_order;

                    totOrder = 0;
                    _order.forEach((val){
                      totOrder = totOrder + int.parse(val.tot);
                    });

                    _showedOrder.sort((a,b) => b.tot.compareTo(a.tot));
                    return LayoutBuilder(
                      builder:(context,constraints) => SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Card(
                                  child: Padding(
                                      padding:EdgeInsets.all(10),
                                      child: Text("Total Order: $totOrder")
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(minWidth: constraints.minWidth),
                                  child: DataTable(
                                    columnSpacing:5,
                                    columns: [
                                    DataColumn(
                                      label: Text('Costumer'),
                                    ),
                                    DataColumn(
                                        label: Text('Date')
                                    ),
                                    DataColumn(
                                      label: Text('Tot. Order'),
                                    ),
                                    DataColumn(
                                        label: Text('Status')
                                    ),
                                    DataColumn(
                                      label: Text('Delete'),
                                    ),
                                  ],
                                    rows: _showedOrder
                                        .map(
                                            (order) =>
                                            DataRow(cells: [
                                              DataCell(
                                                  Text(order.no)
                                              ),
                                              DataCell(
                                                  Text(order.date)
                                              ),
                                              DataCell(
                                                  Text(order.tot)
                                              ),
                                              DataCell(
                                                  Text(order.status)
                                              ),
                                              DataCell(
                                                  IconButton(
                                                    onPressed: () async {
                                                      orderProvider.removeOrder(order.id);
                                                    },
                                                    icon: Icon(Icons.delete),
                                                  )
                                              )
                                            ])
                                    ).toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Text('fetching');
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          dynamic result = await Navigator.pushNamed(context, '/orderadd');
          if(result != null){
            print("Success");
          }
        },
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    _orderDetails = _order;

    if (text.isEmpty) {
      setState(() {
        showSearch = false;
      });
      return;
    }

    _orderDetails.forEach((orderDetail) {
      if (orderDetail.no.contains(text) || orderDetail.no.contains(text))
        _searchResult.add(orderDetail);
    });


    if(_searchResult.length > 0){
      setState(() {
        showSearch = true;
      });
    }else{
      setState(() {
        showSearch = true;
      });
      _searchResult.clear();
    }
  }

}
