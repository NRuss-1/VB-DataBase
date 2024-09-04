from ValidationData import falseNegatives, falsePositives


def validateFalseNegative(s1, s2):
    for pair in falseNegatives:
        if s1 in pair and s2 in pair and s1 != s2:
            return True


def validateFalsePositive(s1, s2):
    for pair in falsePositives:
        if s1 in pair and s2 in pair and s1 != s2:
            return True


def levenshtein_distance(str1, str2):
    if validateFalseNegative(str1, str2):
        return 1
    
    if validateFalsePositive(str1, str2):
        return 10

    # Get the lengths of the input strings
    m = len(str1)
    n = len(str2)
 
    prev_row = [j for j in range(n + 1)]
    curr_row = [0] * (n + 1)

    for i in range(1, m + 1):
        curr_row[0] = i
        for j in range(1, n + 1):
            if str1[i - 1] == str2[j - 1]:
                #no operation needed
                curr_row[j] = prev_row[j - 1]
            else:
                curr_row[j] = 1 + min(
                    curr_row[j - 1],  # Insert
                    prev_row[j],      # Remove
                    prev_row[j - 1]   # Replace
                )

        # Update the previous row with the current row
        prev_row = curr_row.copy()
    return curr_row[n]

#stupid similarity algo, I prefer additive but we do this cause lazy
def similarity(s1, s2):
    return 1 - (levenshtein_distance(s1, s2) / max(len(s1), len(s2)))
