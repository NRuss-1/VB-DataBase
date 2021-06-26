#include <iostream>
#include <vector>
#include <fstream>
#include <stdexcept>
#include <cmath>

int main(int argc, char *argv[]){
  //open the files
  std::ifstream m1{argv[1]};
  if (!m1){
    throw std::logic_error{"File cannot be opened."};
  }
  std::ifstream m2{argv[2]};
  if (!m2){
    throw std::logic_error{"File cannot be opened."};
  }

  //read the dimensions
  unsigned dim1, dim2;
  m1 >> dim1;
  m2 >> dim2;

  //create one dimensional vector
  std::vector<int> matrix1;
  std::vector<int> matrix2;
  std::vector<int> result;
  int buf;

  while (m1 >> buf){
    matrix1.push_back(buf);
  }

  while(m2 >> buf){
    matrix2.push_back(buf);
  }

  //matrix multiplication and write to file
//    arrstart = i * n + i - m;

  //for each row
  int n = dim1;
  int rowcount = 0;
  unsigned rowstart = 0;
  unsigned colstart = 0;
  unsigned arrstart;
  int m = 0;
  while (rowcount != dim1){
    //for all columns
    int sum;

    for (unsigned i = colstart; i < n; ++i){



    }







  ++rowcount;
  ++rowstart;
  ++colstart;
  m = m + rowcount;
}
  for (unsigned i = 0; i < result.size(); ++i){
    std::cout << result[i] << ' ';
  }
  std::cout << '\n';
}
