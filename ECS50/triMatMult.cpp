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

//create loop that loops through the rows and columns of matrix
// loops through rows
  for (unsigned i = 0; i < dim1; ++i){
  //loops through columns
    for (unsigned j = 0; j < dim2; ++j){
        int sum = 0;
        //to account for missing elements
        unsigned kvalue = j + 1;
  //loops through rows of columns
        for (unsigned k = 0; k < kvalue; ++k){
          //calculate num of spaces missing
          int m1 = calcNumSpaces(i);
          int m2 = calcNumSpaces(k);
          sum += matrix1.at(converttoIndex(i, dim1, k, m1)) * matrix2.at(converttoIndex(k, dim2, j, m2));
        }
        result.push_back(sum);
     }
  }

  for (unsigned i = 0; i < result.size(); ++i){
    std::cout << result[i] << ' ';
  }
  std::cout << '\n';
}
