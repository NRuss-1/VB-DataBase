/* a program that generates all possible combinations of a set of items of
a given size */
#include <stdio.h>
#include <stdlib.h>
#include "combs.h"

void print_mat(int** mat, int num_rows, int num_cols);
void free_mat(int** mat, int num_rows, int num_cols);

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int num_combs(int n, int k) {
    int combs = 1;
    int i;

    for (i = n; i > max(k, n - k); i--) {
        combs *= i;
    }

    for (i = 2; i <= min(k, n - k); i++) {
        combs /= i;
    }

    return combs;

}

void print_mat(int** mat, int num_rows, int num_cols) {
    int i, j;

    for (i = 0; i < num_rows; i++) {
        for (j = 0; j < num_cols; j++) {
            printf("%d ", mat[i][j]);
        }
        printf("\n");
    }
}

void free_mat(int** mat, int num_rows, int num_cols) {
    int i;

    for (i = 0; i < num_rows; i++) {
        free(mat[i]);
    }
    free(mat);
}

int* helper(int* items, int* one_comb, int k, int len, int new_k, int* curRow, int** combs)
{
    if (k == 0)
    {
        for (int i = 0; i < new_k; i++)
        {
            combs[*curRow][i] = one_comb[i];
            *curRow++;
        }
    }
    else if (k > len)
    {
        if (k > 0)
        {
            for (int i = 0; i < len; i++)
            {
                one_comb[new_k - k] = items[i];
                helper(items + i + 1, one_comb, k - 1, len - i - 1, new_k, curRow, combs);
            }
        }
    }
    return one_comb;
}

int** get_combs(int* items, int k, int len) {
  int num_of_combs = num_combs(len, k);
  int **combs;
  combs = (int**)malloc(sizeof(int*) * num_of_combs);
  for(int i = 0; i < num_of_combs; i++) {
    combs[i] = (int*)malloc(sizeof(int) * k);
    for(int j = 0; j < k; j++) {
      combs[i][j] = 0;
    }
  }
  int *one_comb;
  one_comb = (int*)malloc(sizeof(int) * k);
  int *curRow = (int*)malloc(sizeof(int));
  *curRow = 0;
  one_comb = helper(items, one_comb, k, len, k, curRow, combs);
  return combs;
}


int main() {
    int num_items;
    int* items;
    int i, k;
    int** combs;
    printf("How many items do you have: ");
    scanf("%d", &num_items);

    items = (int*)malloc(num_items * sizeof(int));

    printf("Enter your items: ");
    for (i = 0; i < num_items; i++) {
        scanf("%d", &items[i]);
    }

    printf("Enter k: ");
    scanf("%d", &k);

    combs = get_combs(items, k, num_items);
    print_mat(combs, num_combs(num_items, k), k);
    free(items);
    free_mat(combs, num_combs(num_items, k), k);

    return 0;
}
