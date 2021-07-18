int row_count = 0;

void calculate(int** combs, int* items, int* curRow, int start, int end,
    int index, int k)
{
    if (index == k)
    {
        for (int j = 0; j < k; j++)
        {
            combs[row_count][j] = curRow[j];
        }
        row_count++;
        return;
    }
    for (int i = start; i <= end && end - i + 1 >= k - index; i++)
    {
        curRow[index] = items[i];
        calculate(combs, items, curRow, i + 1, end, index + 1, k);
    }

}


int** get_combs(int* items, int k, int len) {
    int num_of_combs = num_combs(len, k);
    int** combs;
    combs = (int**)malloc(sizeof(int*) * num_of_combs);
    for (int i = 0; i < num_of_combs; i++) {
        combs[i] = (int*)malloc(sizeof(int) * k);
        for (int j = 0; j < k; j++) {
            combs[i][j] = 0;
        }
    }
    int* curRow = (int*)malloc(sizeof(int) * k);
    int row_count = 0;
    calculate(combs, items, curRow, 0, len - 1, 0, k);
    free(curRow);
    return combs;
}
