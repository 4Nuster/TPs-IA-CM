//chargement
String[] lines = loadStrings("fichierCompressed3.txt");
String pic="";
for(int i=0; i<lines.length; i++) pic += lines[i];

//decodage
int i=0,size;
String decodingRes="";
while(i<pic.length()){
  size = unhex(pic.substring(i, i+4));
  if(unhex(pic.substring(i,i+4)) > unhex("8000")){
    size -= unhex("8000");
    for(int j=0; j<size; j++) decodingRes += pic.substring(i+4, i+6);
    size *= 2;
    i += 6;
  }
  else{
    i += 4;
    size *= 2;
    decodingRes += pic.substring(i, i+size);
    i += size;
  }
}

//resultat
print("\n\ndecoded message: "+decodingRes);

int dimension = int(sqrt(float(decodingRes.length())/2.0));
PImage img = createImage(dimension, dimension, RGB);
dimension *= dimension;
img.loadPixels();
int k=0;
for (int j = 0; j < dimension; j++){ 
  img.pixels[j] = color(unhex(decodingRes.substring(k, k+2)));
  k += 2;
} 

img.updatePixels();
image(img, 0, 0);
