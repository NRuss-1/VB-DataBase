#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int editDist(char* word1, char* word2);
int min(int a, int b);
void swap(int** a, int** b);

int min(int a, int b){  //todo
  return a < b ? a:b;
}

void swap(int** a, int** b){  //todo
  int* temp = *a;
  *a = *b;
  *b = temp;
}

int editDist(char* word1, char* word2){

  int word1_len = strlen(word1);
  int word2_len = strlen(word2);
  int* oldDist = (int*)malloc((word2_len + 1) * sizeof(int)); //todo
  int* curDist = (int*)malloc((word2_len + 1) * sizeof(int)); //todo

  int i,j,dist;

  //intialize distances to length of the substrings
  for(i = 0; i < word2_len + 1; i++){
    oldDist[i] = i; //todo
    curDist[i] = i; //todo
  }

  for(i = 1; i < word1_len + 1; i++){
    curDist[0] = i; //todo
    for(j = 1; j < word2_len + 1; j++){
      if(word1[i-1] == word2[j-1]){  //todo
        curDist[j] = oldDist[j - 1]; //todo
      }//the characters in the words are the same
      else{
        curDist[j] = min(min(oldDist[j], //deletion  //todo
                          curDist[j-1]), //insertion   //todo
                          oldDist[j-1]) + 1; //subtitution  //todo
      }
    }//for each character in the second word
    swap(&oldDist, &curDist); //todo
  }//for each character in the first word

  dist = oldDist[word2_len];//using oldDist instead of curDist because of the last swap //todo
  free(oldDist); //todo
  free(curDist); //todo
  return dist;   //todo

}

int main(int argc, char** argv){
  if(argc < 3){
    printf("Usage: %s word1 word 2\n", argv[0]);
    exit(1);
  }
  printf("The distance between %s and %s is %d.\n", argv[1], argv[2], editDist(argv[1], argv[2]));

  return 0;
}
