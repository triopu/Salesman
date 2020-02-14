import 'dart:async';
import 'package:flutter/material.dart';
import 'package:demo_salesman/locator_order.dart';
import 'package:demo_salesman/services/api.dart';
import 'package:demo_salesman/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator_order<Api>();

  List<Order> orders;


  Future<List<Order>> fetchOrders() async {
    var result = await _api.getDataCollection();
    orders = result.documents
        .map((doc) => Order.fromMap(doc.data, doc.documentID))
        .toList();
    return orders;
  }

  Stream<QuerySnapshot> fetchOrdersAsStream() {
    return _api.streamDataCollection();
  }

  Future<Order> getOrderById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Order.fromMap(doc.data, doc.documentID) ;
  }


  Future removeOrder(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }

  Future updateOrder(Order data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addOrder(Order data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return ;

  }
}