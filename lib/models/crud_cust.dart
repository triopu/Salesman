import 'dart:async';
import 'package:flutter/material.dart';
import 'package:demo_salesman/locator_cust.dart';
import 'package:demo_salesman/services/api.dart';
import 'package:demo_salesman/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDCustomer extends ChangeNotifier {
  Api _api = locator_cust<Api>();

  List<Customer> customers;
  Customer customer;


  Future<List<Customer>> fetchCustomers() async {
    var result = await _api.getDataCollection();
    customers = result.documents
        .map((doc) => Customer.fromMap(doc.data, doc.documentID))
        .toList();
    return customers;
  }

  Stream<QuerySnapshot> fetchCustomersAsStream() {
    return _api.streamDataCollection();
  }

  Future<Customer> getCustomerById(String id) async {
    var doc = await _api.getDocumentById(id);
    customer = Customer.fromMap(doc.data, doc.documentID);
    return customer;
  }



  Future removeCustomer(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }

  Future updateCustomer(Customer data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addCustomer(Customer data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;

  }
}