import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_salesman/models/crud_cust.dart';
import 'package:demo_salesman/models/customer.dart';
import 'package:demo_salesman/screens/customer/edit_customer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatefulWidget {

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  List<Customer> _searchResult = [];
  List<Customer> _customerDetails = [];
  List<Customer> _customer = [];
  List<Customer> _showedCustomer = [];

  bool showSearch = false;

  @override
  void initState(){
    super.initState();
  }

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final customerProvider = Provider.of<CRUDCustomer>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
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
                stream: customerProvider.fetchCustomersAsStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData){
                    _customer = snapshot.data.documents
                        .map((doc) => Customer.fromMap(doc.data, doc.documentID))
                        .toList();

                    _showedCustomer = showSearch?_searchResult:_customer;

                    _showedCustomer.sort((a,b) => b.bal.compareTo(a.bal));

                    return LayoutBuilder(
                      builder:(context,constraints) => SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(minWidth: constraints.minWidth),
                                  child: DataTable(
                                    columnSpacing: 0,
                                    columns: [
                                    DataColumn(
                                      label: Text('Costumer'),
                                    ),
                                    DataColumn(
                                        label: Text('Date')
                                    ),
                                    DataColumn(
                                      label: Text('Tot. Balance'),
                                    ),
                                    DataColumn(
                                        label: Text('Edit')
                                    )
                                  ],
                                    rows: _showedCustomer
                                        .map(
                                            (customer) =>
                                            DataRow(cells: [
                                              DataCell(
                                                  Text(customer.name)
                                              ),
                                              DataCell(
                                                  Text(customer.city)
                                              ),
                                              DataCell(
                                                  Text(customer.bal)
                                              ),
                                              DataCell(
                                                  IconButton(
                                                    icon: Icon(Icons.edit),
                                                    onPressed: () async {
                                                      final dynamic data = await customerProvider.getCustomerById(customer.id);
                                                      await Navigator.push(context, MaterialPageRoute(builder: (context) => EditCustomer(),
                                                          settings: RouteSettings(
                                                            arguments: data,
                                                          )));
                                                    },
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
      floatingActionButton:           FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.pushNamed(context, '/customeradd');
        },
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    _customerDetails = _customer;

    print(text);

    if (text.isEmpty) {
      setState(() {
        showSearch = false;
      });
      return;
    }

    _customerDetails.forEach((custDetail) {
      if (custDetail.name.contains(text) || custDetail.name.contains(text))
        _searchResult.add(custDetail);
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
