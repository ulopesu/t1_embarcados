#include <stdio.h>
#include <math.h>
#include "convolve.h"

const float A = 1;
const int qtd_points = 2000;

int main(int argc, char *argv[])
{
    FILE *ptr;
    char new_ch = '\0';

    // Opening file in reading mode
    ptr = fopen("sinal.txt", "r");
    float *h = malloc(sizeof(float) * qtd_points);

    if (NULL == ptr)
    {
        printf("file can't be opened \n");
    }

    //  -0.0000000e+00  -> input

    int i, j;
    float exp, aux;
    int sinal = 0; // 0 -> Positivo | 1 -> Negativo
    for (i = 0, j = 0; new_ch != EOF; j++)
    {
        new_ch = fgetc(ptr);

        if (j == 0 && new_ch == '-')
        {
            sinal = 1;
        }
        else if (j == 1)
        {
            aux = (float) new_ch - '0';
        }
        else if (j == 3)
        {
            aux += ((float) new_ch - '0')/10;
        }
        else if (j == 4)
        {
            aux += ((float) new_ch - '0')/100;
        }
        else if (j == 13)
        {
            exp = (float) new_ch - '0';
        }
        else if (j == 15)
        {
            aux *= powf(10, exp);

            if (sinal == 1)
            {
                aux *= (-1);
            }

            h[i] = aux;
            j = -1;
            sinal = 0;
            i++;
        }
    }

    // for (int i = 0; i < qtd_points; i++)
    // {
    //     printf("%f ", h[i]);
    // }

    float x[] = {A, A, A, A, A};
    int lenX = sizeof(x) / sizeof(float);
    int lenY;

    printf("lenH: %d | lenX: %d \n", qtd_points, lenX);

    float *y = convolve(h, x, qtd_points, lenX, &lenY);

    for (int i = 0; i < 10; i++)
    {
        printf("(%.2f : ", y[i]);
        y[i] /= 11;
        printf("%.2f) ", y[i]);
    }

    puts("");
    free(h);
    free(y);
    return 0;
}