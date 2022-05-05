#include <stdio.h>

int f(int y){
 int i;
 int a[32] = { -1, -1 };

 for(i = 2; i <= y; i++) {
 	printf("a[i]: %d\n", a[i]);
 	printf("i: %d\n", i);
 	a[i] = a[i-1] + a[i-2];
 }
 
 return(a[y]);
}

int main(){
 int result = f(32);
 
 printf("Valor retornado: %d\n", result);
 
 return result;
}
