import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width*0.86,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),

                    child: Card(
                      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                        ),
                        title: Text('DEMO SALESMAN'),
                        subtitle: Text('PT. San Husada'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),

                    child: FlatButton.icon(onPressed: ()async{
                      dynamic result = await Navigator.pushNamed(context, '/');

                    },  icon: Icon(Icons.branding_watermark,size: 40, color: Colors.blue,),
                        label:Text('Dashboard',style: TextStyle(
                          fontSize: 18,
                        ),)),
                  )
                ],
              ),
            )
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width*0.14,
          color: Colors.blue,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Icon(Icons.playlist_play, size: 50,color: Colors.white,),
              )

            ],
          ),
        ),
      ],
    );
  }}
