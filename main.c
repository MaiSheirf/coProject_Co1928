#include <stdio.h>


void display(int arr[] , int n){
    for(int i =0 ; i <n ; i++){
        printf("%d \t ",arr[i]);
    }
}
void insertionSort(int list[], int n)
{
    int i, j ,key;
    for (i = 1; i < n; i++) {
        key = list[i];
        j = i - 1;
        while (j >= 0 && list[j] > key) {
            list[j + 1] = list[j];
            j = j - 1;
        }
        list[j + 1] = key;
    }


}
int binarySearch(int list[], int l, int r , int x)
{

    while (l <= r) {
        int m = l + (r - l) / 2;
        if (list[m] == x)
            return m;
        if (list[m] < x)
            l = m + 1;
        else
            r = m - 1;
    }
    return -1;
}
void quicksort(int list[],int first,int last){
    int i, j, pivot, temp;

    if(first<last){
        pivot=first;
        i=first;
        j=last;
        while(i<j){
            while(list[i]<=list[pivot]&&i<last)
                i++;
            while(list[j]>list[pivot])
                j--;
            if(i<j){
                temp=list[i];
                list[i]=list[j];
                list[j]=temp;
            }
        }
        temp=list[pivot];
        list[pivot]=list[j];
        list[j]=temp;

        quicksort(list,first,j-1);
        quicksort(list,j+1,last);
    }
}
void merge(int arr[], int l, int m, int r)
{
    int i =0, j =0, k=l;
    int n1 = m - l + 1;
    int n2 = r - m;
    int L[n1], R[n2];
    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        }
        else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }

}
void mergeSort(int arr[], int l, int r)
{
    if (l < r) {
        int m = l + (r - l) / 2;
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);
        merge(arr, l, m, r);

    }
}
int main() {
    int arr[] = { 12, 11, 13, 5, 6, 7 };
    int arr_size = sizeof(arr) / sizeof(arr[0]);
    //mergeSort(arr,0,arr_size-1);
    //insertionSort(arr,arr_size);
    quicksort(arr,0,arr_size-1);
    display(arr,arr_size);
    int result = binarySearch(arr,0,arr_size-1,1);
    if(result==-1){
        printf(" \n Not found ");
    }else{
        printf(" \n found successfully");
    }
}