import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:permission_handler/permission_handler.dart';
import '../class/Update.dart';

class CtHome extends StatefulWidget {
  @override
  _CtHomeState createState() => _CtHomeState();
}

class _CtHomeState extends State<CtHome> {
  List<Contact> contacts = [];
  List<Contact> filterContactsd = [];
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllContacts();
    searchController.addListener(() {
      filterContacts();
      // createContacts();
    });
  }

  getAllContacts() async {
    // List<Contact> _contacts = (await FlutterContacts.getContacts()).toList();
    if(await Permission.contacts.request().isGranted){
      
      Iterable<Contact> _contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
      setState(() {
      contacts = _contacts;
    });
    }
  

    
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }
        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);
        return phone != null;
      });
      setState(() {
        filterContactsd = _contacts;
      });
    }
  }

  //  createContacts() {
  // List<Contact> newContact = [];
  //  newContact.displyname = "AA";
  //   newContact.phones = [Item(value: "99999933")];
  //   ContactsService.addContact(newContact);
  // }


  nbrContact() {
    var ncontact = contacts.length.toString();
    return ncontact;
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage("assetName"),
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Bonjour! {Sylvain}\nBienvenue sur \nI Contacts",
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 45,
                          width: 200,
                           margin: EdgeInsets.all(10),
                           padding: EdgeInsets.all(8.0),
                          // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29.5)),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                hintText: "Search",
                                icon: Icon(Icons.search),
                                border: InputBorder.none),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            height: 30,
                            width: 85,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(29.5)),
                            child:
                                Center(child: Text(nbrContact() + " contacts")),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: isSearching == false
                    ? contacts.length
                    : filterContactsd.length,
                itemBuilder: (context, index) {
                  Contact contact = isSearching == true
                      ? filterContactsd[index]
                      : contacts[index];
                  String getphone() {
                    if (contact.phones.isNotEmpty == true) {
                      String myNum1 = contact.phones.elementAt(0).value;

                      String myNum = myNum1.replaceAll(" ", "");

                      Update m1 = new Update(myNum);

                      String m2 = m1.getNum();

                      return m2 ;
                    } else {
                      return 'pas de numero pour ce contact';
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: GestureDetector(
                      onTap: () {
                        return showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return new AlertDialog(
                                title: Column(
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 90,
                                      // margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Center(
                                          child: Text(
                                        contact.displayName,
                                        style: TextStyle(color: Colors.black),
                                      )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Nouveau N°:" + getphone(),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                content: Text(
                                  "Ancien N°:" + getphone(),
                                  textAlign: TextAlign.start,
                                ),
                                actions: [
                                  new FlatButton(
                                    onPressed: () {
                                      print("confirmer");

                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: Container(
                                        height: 30,
                                        width: 85,
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(29.5)),
                                        child: Center(
                                            child: Text(
                                          "Modiffier",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                  new FlatButton(
                                    onPressed: () {
                                      print("Annuler");
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: Container(
                                        height: 30,
                                        width: 85,
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(29.5)),
                                        child: Center(
                                            child: Text(
                                          "Annuler",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        //padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 17),
                                blurRadius: 23,
                                spreadRadius: -13,
                                color: Colors.indigoAccent,
                              )
                            ]),

                        child: ListTile(
                          title: Text(contact.displayName),
                          subtitle: Text(getphone()),
                          leading: (contact.avatar != null &&
                                  contact.avatar.length > 0)
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(contact.avatar),
                                )
                              : CircleAvatar(child: Icon(Icons.person)),
                          // PopupOptionMenu(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        // visible: _dialVisible,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.settings),
              backgroundColor: Colors.red,
              label: 'Parametre',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('FIRST CHILD')),
          SpeedDialChild(
            child: Icon(Icons.person),
            backgroundColor: Colors.blue,
            label: 'Passer à 10 chiffres',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: Icon(Icons.money_sharp),
            backgroundColor: Colors.green,
            label: 'Faire un don',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
    );
  }
}

// enum MenuOption { Send, Draft, Discard }

// class PopupOptionMenu extends StatelessWidget {
//   const PopupOptionMenu({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<MenuOption>(
//       itemBuilder: (BuildContext context) {
//         return <PopupMenuEntry<MenuOption>>[
//           PopupMenuItem(
//             child: Text("Save"),
//             value: MenuOption.Send,
//           ),
//           PopupMenuItem(
//             child: Text("Save"),
//             value: MenuOption.Draft,
//           ),
//           PopupMenuItem(
//             child: Text("Save"),
//             value: MenuOption.Discard,
//           ),
//         ];
//       },
//     );
//   }
// }
