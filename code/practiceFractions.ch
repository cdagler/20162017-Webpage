/* File Name: practiceFractions.ch 
 *
 * This program will generate fraction problems for the students to practice.
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */


#define REDUCED_FRAC 0
#define UNREDUCED_FRAC 1
#define IMPROPER_FRAC 2

#define MAX_FRAC_PART 8

#include <string.h>

/*
 * This finds the Greatest Common Factor of 2 numbers (Euclidean Algorithm).
 */
int gcf(int a,int b);

void swapInt(int &x, int &y);

/*
 * Returns 1 if the student got the problem correct, else 0.
 */
int praticeReduceFraction(void);
int praticeAddFraction(void);
int praticeSubtractFraction(void);
int praticeMuplityFraction(void);
int praticeDivideFraction(void);

/*
 * Finds the numerator 'a' and denominator 'b' of a random fraction.
 */
void getRandomFrac(int fractionType, int &a, int &b);
/*
 * Takes a string in the form "a/b" and stores a and b.
 */
void stringToFrac(char frac[], int &a, int &b);

srand(time(NULL));

int numOfProblems, whatToPratice, numCorrect, i, randInt;
double percentCorrect;    
    
printf("What do you want to pratice, Enter\n");
printf("  1: Reduce fractions\n");
printf("  2: Add fractions\n");
printf("  3: Subtract fractions\n");
printf("  4: Multiply fractions\n");
printf("  5: Divide fractions\n");
printf("  6: Add and Subtract fractions\n");
printf("  7: All Operations on fractions\n");
scanf("%d", &whatToPratice);
    
printf("Enter the number of problems to do:\n");
scanf("%d", &numOfProblems);    
printf("\n");

for(i=0; i<numOfProblems; i++){
    printf("#%d: ", i+1);
    
    switch(whatToPratice){
        case 1: numCorrect += praticeReduceFraction();
                break;
        case 2: numCorrect += praticeAddFraction();
                break;
        case 3: numCorrect += praticeSubtractFraction();
                break;
        case 4: numCorrect += praticeMuplityFraction();
                break;
        case 5: numCorrect += praticeDivideFraction();
                break;
        case 6: randInt = 1 + rand() % 2;
                if(randInt == 1)
                    numCorrect += praticeAddFraction();
                else
                    numCorrect += praticeSubtractFraction();
                break;
        case 7: randInt = 1 + rand() % 5;
                if(randInt == 1)
                    numCorrect += praticeReduceFraction();
                else if(randInt == 2)
                    numCorrect += praticeAddFraction();
                else if(randInt == 3)
                    numCorrect += praticeSubtractFraction();
                else if(randInt == 4)
                    numCorrect += praticeSubtractFraction();
                else
                    numCorrect += praticeDivideFraction();
                break;
        default: printf("Bad Input ....\n");
                exit(1);
    }
}    
    
if(numOfProblems>5){
    percentCorrect = (1.0*numCorrect)/(1.0*numOfProblems);
    
    if(percentCorrect>=0.80){
        printf("You are a STAR at this ...\n");
        printf("You got %d/%d = %.2lf%%\n", numCorrect, numOfProblems, 100 * percentCorrect);
    }
    else if(percentCorrect>=0.65){  
        printf("Nice job, you are on you way to mastering this ...\n");
        printf("You got %d/%d = %.2lf%%\n", numCorrect, numOfProblems, 100 * percentCorrect);
    }
    else{
        printf("Great effort, you will benefit with more practice ...\n");
        printf("You got %d/%d = %.2lf%%\n", numCorrect, numOfProblems, 100 * percentCorrect);
    }
}
else
    printf("You got %d out of %d.\n", numCorrect, numOfProblems);

int praticeReduceFraction(void)
{
    int a, b, aAns, bAns, aStuAns, bStuAns, GCF;
    char temp[32] = "";
    char input[32] = "";
    getRandomFrac(UNREDUCED_FRAC, a, b);
    
    GCF = gcf(a,b);
    aAns = a/GCF;
    bAns = b/GCF;
    
    printf("Simplify: Enter your answer in the form (a/b)\n\n");
    printf("\t %d\n", a);
    printf("\t -- \n");
    printf("\t %d\n\n\n",b);
    scanf("%s", input);
    
    /*
     * Making it ok for a studnet to input an integer.
     * e.g. 7/1 = 7
     */
    if(bAns!=1 && strchr(input,'/')!=NULL){
        stringToFrac(input, aStuAns, bStuAns);
    }
    else{
        aStuAns = atoi(input);
        bStuAns = 1;                
    }
    
    if(aStuAns == aAns && bStuAns == bAns){
        printf("Nice Job!!!\n\n\n");
        sleep(2);
        return 1;
    }
    else{
        printf("Sorry, the correct answer is %d/%d\n\n\n", aAns, bAns);
        sleep(2);
        return 0;
    }
}

int praticeAddFraction(void)
{
    int a, b, c, d, ansA, ansB, stuAnsA, stuAnsB;
 
    int GCF;
    char temp[32] = "";
    char input[32] = "";
    getRandomFrac(REDUCED_FRAC, a, b);
    getRandomFrac(REDUCED_FRAC, c, d);
    
    printf("Simplify: Enter your answer in the form (a/b)\n\n");
    printf("\t %d \t\t %d \n", a, c);
    printf("\t -- \t+\t -- \n");
    printf("\t %d \t\t %d \n", b, d);
    scanf("%s", input);
    
    /*
     * Making it ok for a studnet to input an integer.
     * e.g. 7/1 = 7
     */
    if(ansB!=1 && strchr(input,'/')!=NULL){
        stringToFrac(input, stuAnsA, stuAnsB);
    }
    else{
        stuAnsA = atoi(input);
        stuAnsB = 1;                
    }
    
    ansA = a*d+b*c;
    ansB = b*d;
    
    GCF = gcf(ansA,ansB);
    ansA /= GCF;
    ansB /= GCF;
    
    if(ansA == stuAnsA && ansB == stuAnsB){
        printf("Nice Job!!!\n\n\n");
        sleep(2);
        return 1;
    }
    else{
        if(ansB!=1)
            printf("Sorry, the correct answer is %d/%d\n\n\n", ansA, ansB);
        else
            printf("Sorry, the correct answer is %d\n\n\n", ansA); 
        sleep(2);
        return 0;
    }
}

int praticeSubtractFraction(void){
    int a, b, c, d, ansA, ansB, stuAnsA, stuAnsB;
    int GCF;
    double fracVal1, fracVal2;
    char temp[32] = "";
    char input[32] = "";
    getRandomFrac(REDUCED_FRAC, a, b);
    getRandomFrac(REDUCED_FRAC, c, d);
    
    /*
     * Makeing sure the fraction are not equal.
     */
    if(a==c && b==d){
        c += 2;
        d += 3;    
    }
    
    /*
     * Makeing sure we are not going to get a negative or zero answer.
     */
    fracVal1 = (1.0*a)/(1.0*b);
    fracVal2 = (1.0*c)/(1.0*d);
    if(fracVal1 < fracVal2){
        swapInt(a,c);
        swapInt(b,d);
    }    
    
    printf("Simplify: Enter your answer in the form (a/b)\n\n");
    printf("\t %d \t\t %d \n", a, c);
    printf("\t -- \t-\t -- \n");
    printf("\t %d \t\t %d \n", b, d);
    scanf("%s", input);
    
    /*
     * Making it ok for a studnet to input an integer.
     * e.g. 7/1 = 7
     */
    if(ansA!=1 && strchr(input,'/')!=NULL){
        stringToFrac(input, stuAnsA, stuAnsB);
    }
    else{
        stuAnsA = atoi(input);
        stuAnsB = 1;                
    }
    
    ansA = a*d-b*c;
    ansB = b*d;
    
    GCF = gcf(ansA,ansB);
    ansA /= GCF;
    ansB /= GCF;
    
    if(ansA == stuAnsA && ansB == stuAnsB){
        printf("Nice Job!!!\n\n\n");
        sleep(2);
        return 1;
    }
    else{
        if(ansB!=1)
            printf("Sorry, the correct answer is %d/%d\n\n\n", ansA, ansB);
        else
            printf("Sorry, the correct answer is %d\n\n\n", ansA); 
        sleep(2);
        return 0;
    }
}


int praticeMuplityFraction(void){
    int a, b, c, d, ansA, ansB, stuAnsA, stuAnsB;
 
    int GCF;
    char temp[32] = "";
    char input[32] = "";
    getRandomFrac(REDUCED_FRAC, a, b);
    getRandomFrac(REDUCED_FRAC, c, d);
    
    printf("Simplify: Enter your answer in the form (a/b)\n\n");
    printf("\t %d \t\t %d \n", a, c);
    printf("\t -- \t*\t -- \n");
    printf("\t %d \t\t %d \n", b, d);
    scanf("%s", input);
    
    /*
     * Making it ok for a studnet to input an integer.
     * e.g. 7/1 = 7
     */
    if(ansB!=1 && strchr(input,'/')!=NULL){
        stringToFrac(input, stuAnsA, stuAnsB);
    }
    else{
        stuAnsA = atoi(input);
        stuAnsB = 1;                
    }
    
    ansA = a*c;
    ansB = b*d;
    
    GCF = gcf(ansA,ansB);
    ansA /= GCF;
    ansB /= GCF;
    
    if(ansA == stuAnsA && ansB == stuAnsB){
        printf("Nice Job!!!\n\n\n");
        sleep(2);
        return 1;
    }
    else{
        if(ansB!=1)
            printf("Sorry, the correct answer is %d/%d\n\n\n", ansA, ansB);
        else
            printf("Sorry, the correct answer is %d\n\n\n", ansA); 
        sleep(2);
        return 0;
    }
}


int praticeDivideFraction(void){
    int a, b, c, d, ansA, ansB, stuAnsA, stuAnsB;
 
    int GCF;
    char temp[32] = "";
    char input[32] = "";
    getRandomFrac(REDUCED_FRAC, a, b);
    getRandomFrac(REDUCED_FRAC, c, d);
    
    printf("Simplify: Enter your answer in the form (a/b)\n\n");
    printf("\t %d \t\t %d \n", a, c);
    printf("\t -- \t/\t -- \n");
    printf("\t %d \t\t %d \n", b, d);
    scanf("%s", input);
    
    /*
     * Making it ok for a studnet to input an integer.
     * e.g. 7/1 = 7
     */
    if(ansB!=1 && strchr(input,'/')!=NULL){
        stringToFrac(input, stuAnsA, stuAnsB);
    }
    else{
        stuAnsA = atoi(input);
        stuAnsB = 1;                
    }
    
    ansA = a*d;
    ansB = b*c;
    
    GCF = gcf(ansA,ansB);
    ansA /= GCF;
    ansB /= GCF;
    
    if(ansA == stuAnsA && ansB == stuAnsB){
        printf("Nice Job!!!\n\n\n");
        sleep(2);
        return 1;
    }
    else{
        if(ansB!=1)
            printf("Sorry, the correct answer is %d/%d\n\n\n", ansA, ansB);
        else
            printf("Sorry, the correct answer is %d\n\n\n", ansA); 
        sleep(2);
        return 0;
    }
}

/*
 * Finds the numerator 'a' and denominator 'b' of a random fraction.
 */
void getRandomFrac(int fractionType, int &a, int &b){
    int c, GCF;    
    
    if(fractionType==REDUCED_FRAC){
        a = 1 + rand() % MAX_FRAC_PART;
        b = 2 + rand() % MAX_FRAC_PART;
        
        /*
         * Making sure the fraction not equal to 1.
         */
        if(a==b)
            b += 2 + rand() % 3;
        /*
         * Making sure the fraction is 'improper'.
         */
        if(a>b){
            c=a; 
            a=b; 
            b=c;
        }
        GCF = gcf(a,b);
        a /= GCF;
        b /= GCF;
    }
    else if(fractionType==UNREDUCED_FRAC){
        a = 1 + rand() % (MAX_FRAC_PART);
        b = 1 + rand() % (MAX_FRAC_PART);
        c = 2 + rand() % 6;
        
        /*
         * Making sure the fraction not equal to 1.
         */
        if(a==b)
            b += 1 + rand() % 3;
        /*
         * Making sure the fraction is 'proper'.
         */
        if(a>b){
            c=a; 
            a=b; 
            b=c;
        }
        a *= c;
        b *= c;      
    }
    else if(fractionType==IMPROPER_FRAC){
        a = 1 + rand() % MAX_FRAC_PART;
        b = 1 + rand() % MAX_FRAC_PART;
        
        /*
         * Making sure the fraction not equal to 1.
         */
        if(a==b)
            b += 1 + rand() % 3;
        /*
         * Making sure the fraction is 'improper'.
         */
        if(a<b){
            c=a; 
            a=b; 
            b=c;
        }
        GCF = gcf(a,b);
        a /= a;
        b /= b;
      
    }
    else{
        printf("What type of fraction do you want????\n");
        exit(1);
    }
}

void stringToFrac(char frac[], int &a, int &b){
    int i=0;
    char *aVals, *bVals;
    
    a = atoi(strtok(frac, "/  ()"));
    b = atoi(strtok(NULL, "/  ()"));
}

/*
 * This finds the Greatest Common Factor of 2 numbers (Euclidean Algorithm).
 *
 * Step throught with a=6, b=8.
 *
 * Step 1:          Step 2:         Step 3:
 * ===========      ===========     ===========
 * c=a%b=6%8=6      c=a%b=8%6=2     c=a%b=6%2=0
 * c!=0             c!=0            c==0
 * a=b=8            a=b=6               return b(=2)
 * b=c=6            b=c=2
 */
int gcf(int a,int b){
    int c;
    while(1){
        c = a%b;
        if(c==0)
            return b;
        a = b;
        b = c;
    }
    return -1;
}

void swapInt(int &x, int &y){
    int temp = x;
    x=y;
    y=temp;
}
