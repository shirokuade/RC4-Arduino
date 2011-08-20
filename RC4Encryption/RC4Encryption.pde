#include <string.h>

unsigned char S[256];
char has[512];

#define S_SWAP(a,b) do { int t = S[a]; S[a] = S[b]; S[b] = t; } while(0)

void rc4(char *key, char *data){
     int i,j;
     
     Serial.print("Source : ");
     Serial.println(data);
     Serial.print("Key : ");
     Serial.println(key);
          
     for (i=0;i<256;i++){
         S[i] = i;
         //printf("%x",S[i]);
     }
     
     //printf("\n");

     j = 0;
     for (i=0;i<256;i++){
         j = (j+S[i]+key[i%strlen(key)]) %256;    
         S_SWAP(S[i],S[j]);
         //printf("%x",S[i]);
     }
     
     //printf("\n");
     i = j = 0;
     for (int k=0;k<strlen(data);k++){
         i = (i+1) %256;
         j = (j+S[i]) %256;
         S_SWAP(S[i],S[j]);
         has[k] = data[k]^S[(S[i]+S[j]) %256];
     }
     has[strlen(data)+1] = '\0';
     
     //printf("\n");

}

void setup() {
  Serial.begin(9600);
  char key[] = "Hello";
  char sdata[] = "this is data source!";
  rc4(key,sdata);
  Serial.print("Encrypted : ");
  Serial.println(has);
  rc4(key,has);
  Serial.print("Decrypted : ");
  Serial.println(has);
  
}

void loop(){
  
}
