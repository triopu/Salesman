import 'package:demo_salesman/models/crud_order.dart';
import 'package:demo_salesman/models/order.dart';
import 'package:demo_salesman/screens/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOrder extends StatefulWidget {
  @override
  _AddOrderState createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  final _formKey = GlobalKey<FormState>();
  var txtDate = TextEditingController();

  String no = '';
  String date = '';
  String tot = '';
  String status = '';

  DateTime selectedDate = DateTime.now();
  String setDate;

  Future<Null> _selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2016,1),
        lastDate: DateTime(2021,1));
    if(picked != null && picked != selectedDate){
      setState(() {
        setDate = picked.toLocal().toString().split(' ')[0];
        txtDate.text = setDate;
        date = setDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<CRUDModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Order"),
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () async{
                  Navigator.pop(context,null);
                },
              );
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              if(_formKey.currentState.validate()){
                await orderProvider.addOrder(Order(no:no, date:date, tot:tot, status:status));
                Navigator.pop(context);
              }else{
                print("Error");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: ()async{
              Navigator.pop(context,null);
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
                      labelText: 'company name',
                  ),
                  validator: (val) => val.isEmpty ? 'Enter company name' : null,
                  onChanged: (val) {
                    setState(() => no = val);
                  },
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        enabled: false,
                        decoration: textInputDecoration.copyWith(
                          labelText: 'date',
                        ),
                        validator: (val) => val.isEmpty ? 'Enter date (dd/mm/yy)' : null,
                        controller: txtDate,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: ()async{
                        await _selectDate(context);
                      },
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration.copyWith(
                      labelText: 'total order'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter total order' : null,
                  onChanged: (val) {
                    setState(() => tot = val);
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'status'
                  ),
                  validator: (val) => val.isEmpty ? 'Enter status' : null,
                  onChanged: (val) {
                    setState(() => status = val);
                  },
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
