//chargement
String[] lines = loadStrings("fichier3.txt");
String pic="";
for(int i=0; i<lines.length; i++) pic += lines[i];

//codage
String result="", current="", buffer="";
int colorCounter=0, counter=0;
boolean incoming=false;

for(int i=0; i<=pic.length(); i+=2){
  if(!incoming && pic.length()>=i+6){
    if(pic.substring(i, i+2).equals(pic.substring(i+2, i+4)) && pic.substring(i+2, i+4).equals(pic.substring(i+4, i+6))){
      incoming = true;
      current = pic.substring(i, i+2);
      colorCounter = 1;
      if(counter>0){
        result += hex(counter, 4)+buffer;
        buffer = "";
        counter = 0;
      }
      continue;
    }
  }
  if(i == pic.length()){
    if(incoming) result += hex(unhex("8000")+colorCounter, 4)+current;
    else{
      if(buffer!="") result += hex(counter, 4)+buffer;
    }
  }
  else{
    if(!incoming){
      buffer += pic.substring(i, i+2);
      counter++;
    }
    else{
      if(current.equals(pic.substring(i, i+2))) colorCounter++;
      else{
        result += hex(unhex("8000")+colorCounter, 4)+current;
        incoming = false;
        current = "";
        i-=2;
      }
    }
  }
}

//resultat
print(result);
String[] resultTable = split(result,' ');
saveStrings("fichierCompressed.txt", resultTable);

//taux de compression
float rate = 1.0 - float(result.length()) / float(pic.length());
print("\nCompression rate: "+rate);
