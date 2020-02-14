import 'package:demo_salesman/models/crud_cust.dart';
import 'package:demo_salesman/models/customer.dart';
import 'package:demo_salesman/screens/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EditCustomer extends StatefulWidget {
  @override
  _EditCustomerState createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  final _formKey = GlobalKey<FormState>();
  var txtLong = TextEditingController();
  var txtLat = TextEditingController();

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

  Customer initCustomer;

  List positions = [];

  @override
  Widget build(BuildContext context) {
    final custProvider = Provider.of<CRUDCustomer>(context);
    final dynamic data = ModalRoute.of(context).settings.arguments;
    initCustomer = data;
    txtLong.text = initCustomer.long;
    txtLat.text = initCustomer.lat;
    String id = initCustomer.id;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Customer"),
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
                _formKey.currentState.save();
                await custProvider.updateCustomer(Customer(name:name,addr:addr,prov:prov,city:city,
                                                        post:post,long:long,lat:lat,phone:phone,
                                                        cp:cp,hp:hp,mail:mail,note:note,bal:bal),id);
                Navigator.pop(context);
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
                  decoration: textInputDecoration.copyWith(labelText: "name"),
                  validator: (val) => val.isEmpty ? 'Enter company name' : null,
                  onSaved: (val) {
                    setState(() => name = val);
                  },
                  initialValue: initCustomer.name,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'address'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter address' : null,
                  onSaved: (val) {
                    setState(() => addr = val);
                  },
                  initialValue: initCustomer.addr,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'province'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter province' : null,
                  onSaved: (val) {
                    setState(() => prov = val);
                  },
                  initialValue: initCustomer.prov,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'city'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter city' : null,
                  onSaved: (val) {
                    setState(() => city = val);
                  },
                  initialValue: initCustomer.city,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration.copyWith(
                      labelText: 'postal code'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter postal code' : null,
                  onSaved: (val) {
                    setState(() => post = val);
                  },
                  initialValue: initCustomer.post,
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
                        onSaved: (val) {
                          setState(() => lat = val);
                        },
                        controller: txtLat,
                        //initialValue: initCustomer.lat,
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
                        onSaved: (val) {
                          setState(() => long = val);
                        },
                        controller: txtLong,
                        //initialValue: initCustomer.long,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    IconButton(
                      icon: Icon(Icons.map),
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/customermap').then((value) =>
                        positions = value);
                        txtLat.text = positions[0];lat = positions[0];
                        txtLong.text = positions[1];long = positions[1];
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(labelText: "contact person"),
                  validator: (val) => val.isEmpty ? 'Enter contact person' : null,
                  onSaved: (val) {
                    setState(() =>  cp = val);
                  },
                  initialValue: initCustomer.cp,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'phone'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter phone' : null,
                  onSaved: (val) {
                    setState(() => phone = val);
                  },
                  initialValue: initCustomer.phone,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'mobile'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter mobile' : null,
                  onSaved: (val) {
                    setState(() => hp = val);
                  },
                  initialValue: initCustomer.hp,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: textInputDecoration.copyWith(
                      labelText: 'email'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter enail' : null,
                  onSaved: (val) {
                    setState(() => mail = val);
                  },
                  initialValue: initCustomer.mail,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'note'
                  ),
                  onSaved: (val) {
                    setState(() => note = val);
                  },
                  initialValue: initCustomer.note,
                ),
                SizedBox(height: 50,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Balance',
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
                  onSaved: (val) {
                    setState(() => bal = val);
                  },
                  initialValue: initCustomer.bal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
