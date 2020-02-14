class Customer {
  String id;
  String name;
  String addr;
  String prov;
  String city;
  String post;
  String long;
  String lat;
  String phone;
  String cp;
  String hp;
  String mail;
  String note;
  String bal;

  Customer({this.id, this.name, this.addr, this.prov,
    this.post, this.long, this.lat, this.city,
    this.phone, this.cp, this.hp, this.mail, this.note,
    this.bal});

  Customer.fromMap(Map snapshot, String id):
        id = id ?? '',
        name = snapshot['name']??'',
        addr = snapshot['addr']??'',
        prov = snapshot['prov']??'',
        city = snapshot['city']??'',
        post = snapshot['post']??'',
        long = snapshot['long']??'',
        lat = snapshot['lat']??'',
        phone = snapshot['phone']??'',
        cp = snapshot['cp']??'',
        hp = snapshot['hp']??'',
        mail = snapshot['mail']??'',
        note = snapshot['note']??'',
        bal = snapshot['bal']??'';

  toJson(){
    return{
      "name":name,
      "addr":addr,
      "prov":prov,
      "city":city,
      "post":post,
      "long":long,
      "lat":lat,
      "phone":phone,
      "cp":cp,
      "hp":hp,
      "mail":mail,
      "note":note,
      "bal":bal,
    };
  }
}