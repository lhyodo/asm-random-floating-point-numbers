
#include <stdio.h>
#include <stdlib.h>

// Function Prototypes
int compare(const void* a, const void* b);
void quick_sort(void* base, size_t num, size_t size, int (*compar)(const void*, const void*));

int compare(const void* a, const void* b)
{
    if (*(double*)a > *(double*)b) return 1;
    if (*(double*)a < *(double*)b) return -1;
    return 0;
}

void quick_sort(void* base, size_t num, size_t size, int (*compar)(const void*, const void*)) {
    char* arr = (char*) base;

    // Calculate the left and right bounds of the array
    int left = 0;
    int right = num - 1;

    // If the array has 0 or 1 elements, it is already sorted
    if (num < 2) {
        return;
    }

    // Choose a pivot element
    int pivot_index = (left + right) / 2;
    char* pivot_value = arr + (pivot_index * size);

    // Partition the array
    while (left <= right) {
        // Find the first element on the left that is greater than or equal to the pivot
        char* left_value = arr + (left * size);
        while (compare(left_value, pivot_value) < 0) {
            left++;
            left_value = arr + (left * size);
        }

        // Find the first element on the right that is less than or equal to the pivot
        char* right_value = arr + (right * size);
        while (compare(right_value, pivot_value) > 0) {
            right--;
            right_value = arr + (right * size);
        }

        // Swap the left and right elements if they are in the wrong order
        if (left <= right) {
            for (size_t i = 0; i < size; i++) {
                char temp = left_value[i];
                left_value[i] = right_value[i];
                right_value[i] = temp;
            }
            left++;
            right--;
        }
    }

    // Recursively sort the left and right partitions
    if (right > 0) {
        quick_sort(arr, right + 1, size, compare);
    }
    if (left < num - 1) {
        quick_sort(arr + (left * size), num - left, size, compare);
    }
}