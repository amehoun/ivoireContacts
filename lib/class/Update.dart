import 'Contact.class.dart';

class Update {
  String contact = "";
  
  String x1 ="0";
  String x2 ="0";
  Update(contact) {
    this.contact = contact;

    Contact n1 = new Contact(this.contact);

    bool n2 = n1.isCi();

    if (n2 == true) {
      String n3 = n1.huitChiffres();

      // print(n3);

      int typeN = n1.typeNum(n3);

      /*
				1 pour fixe Abijan
				2 pour fixe Hors Abijan
				3 pour mobile
			*/

     

      if (typeN == 3) {
        n1.mobile(n3);
      } else if (typeN == 1) {
        n1.fixe1(n3);
      } else {
        n1.fixe2(n3);
      }

      // print(typeN);

        this.x1 = n1.finalNum();

        this.x2 = n1.finalReseau();  

      


    } else {
      print("Le numero n'est pas au format Ivoirien");
      
        this.x1 = this.contact;

        this.x2 = ""; 
    }
  }

      getNum()
      {
         return this.x1;
          // print(this.x1);
      }

      getReseau()
      {
         return this.x2;
          // print(this.x2);
      }
   
}
