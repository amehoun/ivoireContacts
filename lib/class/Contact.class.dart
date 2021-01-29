class Contact {
  
  String numro = "";

  String numero = "0";

  String reseau = "";
  
  var num3 = "";
  
  var num2 = "";
  
  String ind = "";


  Contact(numro) {
    this.numro = numro;
  }

  isCi() {
    var reg = new RegExp(r"^(\+){1}225[0-9]{8}$|^00225[0-9]{8}$|^[0-9]{8}$");

    var resultat = reg.hasMatch(this.numro);

    return resultat;
  }

  huitChiffres() {
    var numro = this.numro;

    var reg1 = new RegExp("^\\+{1}225([0-9]{8})");

    var resultat1 = reg1.firstMatch(this.numro);

    if (resultat1 != null) {
      this.ind = "+225 ";

      numro = resultat1[1];
    }

    var reg2 = new RegExp(r"^00225([0-9]{8})");

    var resultat2 = reg2.firstMatch(this.numro);

    if (resultat2 != null) {
      this.ind = "00225 ";

      numro = resultat2[1];
    }

    return numro;
  }

  typeNum(num2) {
    int type = 3;

    this.num2 = num2;

    var reg1 = new RegExp(r"^2[0-9]{7}$");

    var reg2 = new RegExp(r"^3[0-9]{7}$");

    bool b1 = reg1.hasMatch(this.num2);

    bool b2 = reg2.hasMatch(this.num2);

    if ( b1 == true) 
    {
      type = 1;
    }
    
    if ( b2 == true) 
    {
       type = 2;
    } 

    return type;
  }

  mobile(num3) {
    this.num3 = num3;

    var reg = new RegExp(r"^.([0-9]{1})[0-9]{6}$");

    var resultat3 = reg.firstMatch(this.num3);

    if (resultat3[1] == "0" ||
        resultat3[1] == "1" ||
        resultat3[1] == "2" ||
        resultat3[1] == "3") {
      this.num3 = this.ind + "01" + this.num3;

      this.reseau = "MOOV";
    }

    if (resultat3[1] == "4" || resultat3[1] == "5" || resultat3[1] == "6") {
      this.num3 = this.ind + "05" + this.num3;

      this.reseau = "MTN";
    }

    if (resultat3[1] == "7" || resultat3[1] == "8" || resultat3[1] == "9") {
      this.num3 = this.ind + "07" + this.num3;

      this.reseau = "ORANGE";
    }

    this.numero = this.num3;
    
    // print(this.numero);

    
  }

  fixe1(num3) {
    this.num3 = num3;

    var reg = new RegExp(r"^.{2}([0-9]{1})[0-9]{5}$");

    var resultat3 = reg.firstMatch(this.num3);

    // print(resultat3[1]);


    if (resultat3[1] == "8") 
    {
      this.num3 = this.ind + "21" + this.num3;
      

      this.reseau = "FIXE MOOV";
    } 
    
    if (resultat3[1] == "0" ) 
    {
      this.num3 = this.ind + "25" + this.num3;
       

      this.reseau = "FIXE MTN";
    } 

    
    if (resultat3[1] == "1" || resultat3[1] == "2" || resultat3[1] == "3" || resultat3[1] == "4"  || resultat3[1] == "5" || resultat3[1] == "6" || resultat3[1] == "7" || resultat3[1] == "9") {
      this.num3 = this.ind + "27" + this.num3;
      

      this.reseau = "FIXE ORANGE";
    } 
    
    this.numero = this.num3;

    // print(this.numero);

   
  }

  fixe2(num3) 
  {
    this.num3 = num3;

    var reg = new RegExp(r"^.{2}([0-9]{1})[0-9]{5}$");

    var resultat3 = reg.firstMatch(this.num3);

    if (resultat3[1] == "0") 
    {
      this.num3 = this.ind + "25" + this.num3;
      
      this.reseau = "FIXE MTN";
      
    } else {
      this.num3 = this.ind + "27" + this.num3;

      this.reseau = "FIXE ORANGE";
    }

    this.numero = this.num3;

    // print(this.numero);

    
  }

  finalNum()
  {
   return this.numero;
  // print(this.numero);
  }

  finalReseau()
  {
    return this.reseau;
  }
}
