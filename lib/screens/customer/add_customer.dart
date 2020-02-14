import 'package:demo_salesman/models/crud_cust.dart';
import 'package:demo_salesman/models/customer.dart';
import 'package:demo_salesman/screens/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String addr = '';
  String prov = '';
  String city = '';
  String post = '';
  String long = '';
  String lat = '';
  String cp = '';
  String phone = '';
  String hp = '';
  String mail = '';
  String note = '';
  String bal = '';

  List positions = [];
  var txtLong = TextEditingController();
  var txtLat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final custProvider = Provider.of<CRUDCustomer>(context);
    txtLong.text = '';
    txtLat.text = '';
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Customer"),
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: ()async{
              if(_formKey.currentState.validate()){
                await custProvider.addCustomer(Customer(name:name,addr:addr,prov:prov,city:city,
                    post:post,long:long,lat:lat,phone:phone,
                    hp:hp,mail:mail,note:note,bal:bal));
                Navigator.pop(context);
                print("Success");
              }else{
                print("Error");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'company name'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter company name' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'address'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter address' : null,
                  onChanged: (val) {
                    setState(() => addr = val);
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'province'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter province' : null,
                  onChanged: (val) {
                    setState(() => prov = val);
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'city'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter city' : null,
                  onChanged: (val) {
                    setState(() => city = val);
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'postal code'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter postal code' : null,
                  onChanged: (val) {
                    setState(() => post = val);
                  },
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        enabled: false,
                        decoration: textInputDecoration.copyWith(
                            labelText: 'latitude'
                        ),
                        validator: (val) => val.isEmpty ? 'Enter latitude' : null,
                        onChanged: (val) {
                          setState(() => lat = val);
                        },
                        controller: txtLat,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: TextFormField(
                        enabled: false,
                        decoration: textInputDecoration.copyWith(
                            labelText: 'longtitude'
                        ),
                        validator: (val) => val.isEmpty ? 'Enter longtitude' : null,
                        onChanged: (val) {
                          setState(() => long = val);
                        },
                        controller: txtLong,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    IconButton(
                      icon: Icon(Icons.map),
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/customermap').then((value) =>
                        positions = value);
                        print(positions[0]);
                        txtLat.text = positions[0];lat = positions[0];
                        txtLong.text = positions[1];long = positions[1];
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'contact person'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter contact person' : null,
                  onChanged: (val) {
                    setState(() =>  cp = val);
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'phone'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter phone' : null,
                  onChanged: (val) {
                    setState(() => phone = val);
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'mobile'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter mobile' : null,
                  onChanged: (val) {
                    setState(() => hp = val);
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'email'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter enail' : null,
                  onChanged: (val) {
                    setState(() => mail = val);
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'note'
                  ),
                  onChanged: (val) {
                    setState(() => note = val);
                  },
                ),
                SizedBox(height: 50,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Balance',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter balance' : null,
                  onChanged: (val) {
                    setState(() => bal = val);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
