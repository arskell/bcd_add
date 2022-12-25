#include <iostream>
#include <memory>
#include <math.h>
#include "Vbcd_add.h"
#include "verilated.h"


int main(int argc, char** argv) {
      auto contextp = std::make_unique<VerilatedContext>();
      contextp->commandArgs(argc, argv);
      
      auto top = std::make_unique<Vbcd_add>(contextp.get());

      while (!contextp->gotFinish()) { 
        
        unsigned int a = 0;
        unsigned int b = 0;
        std::cout<<"a: ";
        std::cin>>a;
        std::cout<<"b: ";
        std::cin>>b;
        
        for(int i = 0; i < 8; ++i){
          int d = pow(10, i);
          top->a[i] = (a/d) % 10;
          top->b[i] = (b/d) % 10;
        }
        
        top->eval();
        for(int i = 7; i >= 0; --i){
          std::cout<<(int)top->s[i];
        }
        std::cout<<std::endl;
        std::cout<<"carry: "<<(int)top->cout<<std::endl;        
      }

      return 0;
}