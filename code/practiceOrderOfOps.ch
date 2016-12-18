/* File: practiceOrderOfOps.ch
 * Version: 2.1
 *
 * Test the result for an order of operation problem where the numbers range [1, 10] 
 * with random messages 
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */
#include <stdio.h>
#include <stdlib.h>  /* for using srand() and rand() in the C standard lib */
#include <time.h>    /* for using time() in the C standard lib  */

/* function prototypes to print different order of operation expressions */
void printOrderOfOpExpression01(int A, int B, int C, int D);
void printOrderOfOpExpression02(int A, int B, int C, int D);
void printOrderOfOpExpression03(int A, int B, int C, int D, int E, int F);
void printOrderOfOpExpression04(int A, int B);
void printOrderOfOpExpression05(int A, int B);

/* function prototypes to simplify different order of operation expressions */
int simplifyOrderOfOpExpression01(int A, int B, int C, int D);
int simplifyOrderOfOpExpression02(int A, int B, int C, int D);
int simplifyOrderOfOpExpression03(int A, int B, int C, int D, int E, int F);
int simplifyOrderOfOpExpression04(int A, int B);
int simplifyOrderOfOpExpression05(int A, int B);

srand(time(NULL));

int main() {
    int i, answer, studentAnswer, numOfProbs, numCorrect; 
    int n;                          /* the random expressions the student is working on */
    int a, b, c, d, e, f;           /* the random integers in the expressions */
    double percentCorrect;
    
    srand(time(NULL));   /* seed the random number generator */
    
    printf("How many problems are you going to do: ");
    scanf("%d", &numOfProbs);
        
    for(i=0; i<numOfProbs; i++){
        a = 1 + rand() % 10; /* get x in the range [1, 10] */
        b = 1 + rand() % 10; /* get y in the range [1, 10] */
        c = 1 + rand() % 10; /* get x in the range [1, 10] */
        d = 1 + rand() % 10; /* get y in the range [1, 10] */
        e = 1 + rand() % 10; /* get x in the range [1, 10] */
        f = 1 + rand() % 10; /* get y in the range [1, 10] */

        /* making some of the integers negative */
        if(rand()%2 == 1) a *= -1;
        if(rand()%2 == 1) b *= -1;
        if(rand()%2 == 1) c *= -1;
        if(rand()%2 == 1) d *= -1;
        if(rand()%2 == 1) e *= -1;
        if(rand()%2 == 1) f *= -1;
        
        switch(rand()%5){
            case 0: printOrderOfOpExpression01(a,b,c,d);
                    answer = simplifyOrderOfOpExpression01(a,b,c,d);
                    break;
            case 1: printOrderOfOpExpression02(a,b,c,d);
                    answer = simplifyOrderOfOpExpression02(a,b,c,d);
                    break;
            case 2: printOrderOfOpExpression03(a,b,c,d,e,f);
                    answer = simplifyOrderOfOpExpression03(a,b,c,d,e,f);
                    break;
            case 3: printOrderOfOpExpression04(a,b);
                    answer = simplifyOrderOfOpExpression04(a,b);
                    break;
            case 4: printOrderOfOpExpression05(a,b);
                    answer = simplifyOrderOfOpExpression05(a,b);
                    break;
        }
        scanf("%d", &studentAnswer); /* get the user's answer */
        
        if(studentAnswer == answer){
            numCorrect++;
            printf("\n  *** Nice Work!!! ***\n\n");
        }
        else
            printf("\n\n  Sorry the answer is %d \n\n", answer);
    }
    
    if(numOfProbs>5){
        percentCorrect = (1.0*numCorrect)/(1.0*numOfProbs);
        
        if(percentCorrect>=0.80){
            printf("You are a STAR at this ...\n");
            printf("You got %d/%d = %.2lf%%\n", numCorrect, numOfProbs, 100 * percentCorrect);
        }
        else if(percentCorrect>=0.65){  
            printf("Nice job, you are on you way to mastering this ...\n");
            printf("You got %d/%d = %.2lf%%\n", numCorrect, numOfProbs, 100 * percentCorrect);
        }
        else{
            printf("Great effort, you will benefit with more practice ...\n");
            printf("You got %d/%d = %.2lf%%\n", numCorrect, numOfProbs, 100 * percentCorrect);
        }
    }
    else
        printf("You got %d out of %d.\n", numCorrect, numOfProbs);

    return 0;
}

/*
 * This prints out A+B(C+D).
 */
void printOrderOfOpExpression01(int A, int B, int C, int D){
    char op1[4] = "", op2[4]="";
    
    if(B>0) strcpy(op1, "+");
    if(D>0) strcpy(op2, "+");
        
    printf("What is %d%s%d*(%d%s%d):\n", A,op1,B,C,op2,D);
}

/*
 * This prints out (A+B)(C+D).
 */
void printOrderOfOpExpression02(int A, int B, int C, int D){
    char op1[4] = "", op2[4]="";
    
    if(B>0) strcpy(op1, "+");
    if(D>0) strcpy(op2, "+");
        
    printf("What is (%d%s%d)*(%d%s%d):\n", A,op1,B,C,op2,D);
}

/*
 * This prints out A(B+C)+D(E+F).
 */
void printOrderOfOpExpression03(int A, int B, int C, int D, int E, int F){
    char op1[4] = "", op2[4]="", op3[4]="";
    
    if(C>0) strcpy(op1, "+");
    if(D>0) strcpy(op2, "+");
    if(F>0) strcpy(op3, "+");
        
    printf("What is %d*(%d%s%d)%s%d*(%d%s%d):\n", A,B,op1,C,op2,D,E,op3,F);
}

/*
 * This prints out (A)^2+(B)^2.
 */
void printOrderOfOpExpression04(int A, int B){
    printf("What is (%d)^2+(%d)^2:\n", A, B);
}

/*
 * This prints out 2*(A)^2+B.
 */
void printOrderOfOpExpression05(int A, int B){
    char op1[4] = "";
    
    if(B>0) strcpy(op1, "+");
        
    printf("What is 2*(%d)^2%s%d:\n", A, op1, B);
}

/*
 * This simplifys out A+B(C+D).
 */
int simplifyOrderOfOpExpression01(int A, int B, int C, int D){
    return A+B*(C+D);
}

/*
 * This simplifys out (A+B)(C+D).
 */
int simplifyOrderOfOpExpression02(int A, int B, int C, int D){
    return (A+B)*(C+D);
}

/*
 * This simplifys out A(B+C)+D(E+F).
 */
int simplifyOrderOfOpExpression03(int A, int B, int C, int D, int E, int F){
    return A*(B+C)+D*(E+F);
}

/*
 * This simplifys out (A)^2+(B)^2.
 */
int simplifyOrderOfOpExpression04(int A, int B){
    return A*A+B*B;
}

/*
 * This simplifys out 2*(A)^2+B.
 */
int simplifyOrderOfOpExpression05(int A, int B){
    return 2*A*A+B;
}

