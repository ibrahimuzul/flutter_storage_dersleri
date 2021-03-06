import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKullanimi extends StatefulWidget {
  @override
  _SharedPrefKullanimiState createState() => _SharedPrefKullanimiState();
}

class _SharedPrefKullanimiState extends State<SharedPrefKullanimi> {
  String isim;
  var isimController = TextEditingController();

  int id;
  var idController = TextEditingController();
  bool cinsiyet;
  var formKey = GlobalKey<FormState>();
  var mySharedPrefences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SharedPreferences.getInstance().then((sf)=>mySharedPrefences=sf);
    SharedPreferences.getInstance().then((sf) {
      debugPrint("init");
      mySharedPrefences = sf;
    });
  }

  @override
  void dispose() {
    mySharedPrefences.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Pref Kullanımı"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                isminiziGirin(),
                idOlustur(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioListTile(
                    value: true,
                    groupValue: cinsiyet,
                    onChanged: (secildi) {
                      setState(() {
                        debugPrint("x");
                        cinsiyet = secildi;
                      });
                    },
                    title: Text("Erkek"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioListTile(
                    value: false,
                    groupValue: cinsiyet,
                    onChanged: (secildi) {
                      setState(() {
                        cinsiyet = secildi;
                      });
                    },
                    title: Text("Kadın"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: _ekle,
                      child: Text("Kaydet"),
                      color: Colors.green,
                    ),
                    RaisedButton(
                      onPressed: _goster,
                      child: Text("Göster"),
                      color: Colors.blue,
                    ),
                    RaisedButton(
                      onPressed: _sil,
                      child: Text("Sil"),
                      color: Colors.red,
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  Padding idOlustur() {
    debugPrint("id");
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (deger) {
                    id = int.parse(deger);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "ID giriniz",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  controller: idController,
                ),
              );
  }

  void _ekle() async {
    formKey.currentState.save();
    debugPrint(isim);
    await (mySharedPrefences as SharedPreferences).setString("myIsim", isim);
    await (mySharedPrefences as SharedPreferences).setInt("myId", id);
    await (mySharedPrefences as SharedPreferences)
        .setBool("myCinsiyet", cinsiyet);
  }

  void _goster() {

    isim = (mySharedPrefences as SharedPreferences).getString("myIsim") ??
        "NULL";
    //isimController.text = isim;
    debugPrint("Okunan isim " + isim);

    id = (mySharedPrefences as SharedPreferences).getInt("myId") ?? null;
    //idController.text=id.toString();
    debugPrint("Okunan id " + id.toString());


    setState(() {

    cinsiyet =
        (mySharedPrefences as SharedPreferences).getBool("myCinsiyet") ??
            true;

      cinsiyet =
          (mySharedPrefences as SharedPreferences).getBool("myCinsiyet") ??
              true;
      debugPrint("Cinsiyet erkek mi " + (cinsiyet ? "Erkek" : "Kadın"));
    });
  }

  void _sil() {
    (mySharedPrefences as SharedPreferences).remove("myIsim");
    (mySharedPrefences as SharedPreferences).remove("myId");
    (mySharedPrefences as SharedPreferences).remove("myCinsiyet");
    (mySharedPrefences as SharedPreferences).remove("sil");
    (mySharedPrefences as SharedPreferences).remove("telNo");
  }

  isminiziGirin() {
    debugPrint("isim");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onSaved: (deger) {
          isim = deger;
        },
        decoration: InputDecoration(
          labelText: "Isminizi giriniz",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)),
        ),
        controller: isimController,
      ),
    );
  }
}
