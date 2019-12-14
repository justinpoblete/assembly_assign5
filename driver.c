
#include <stdio.h>

extern double assign5();

int main()
{
  double answer = 0.0;
  printf("Welcome to CPSC 240 brought to you by Justin P \n");
  answer = assign5();
  printf("This main program has recieved this number %8.7lf. Have a nice day\n",answer);
  printf("Main will now return 0 to the operating system\n");
  return 0;
}
