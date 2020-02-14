class Order{
  String id;
  String no;
  String date;
  String tot;
  String status;

  Order({this.id,this.no,this.date, this.tot, this.status});

  Order.fromMap(Map snapshot, String id):
    id = id ?? '',
    no = snapshot['no']??'',
    date = snapshot['date']??'',
    tot = snapshot['tot']??'',
    status = snapshot['status']??'';

    toJson(){
      return{
        "no":no,
        "date":date,
        "tot":tot,
        "status":status,
    };
  }
}