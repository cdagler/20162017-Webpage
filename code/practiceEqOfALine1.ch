/* File:    practiceEqOfALine1.ch 
 * Version: 2.1
 *
 * Purpose: This program provides practice finding the equation of a line  
 * for a variety of problems: Find the line when given:
 *    - its slope (m) and a point (x1,y1) it goes through.
 *    - two points (x1,y1) and (x2,y2).
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_COEFFICIENT 6

string_t problem1Print(int mNumerator, int mDenominator, int x1, int y1);
string_t problem2Print(int x1, int y1, int x2, int y2);

string_t problem1Slope(int mNumerator, int mDenominator, int x1, int y1);
string_t problem1Yint(int mNumerator, int mDenominator, int x1, int y1);
string_t problem2Slope(int x1, int y1, int x2, int y2);
string_t problem2Yint(int x1, int y1, int x2, int y2);

string_t simplifyFraction(int numerator, int denominator);

int getRandInt();
int equals(char* val1, char* val2);
/*
 * This finds the Greatest Common Factor of 2 numbers (Euclidean Algorithm).
 */
int gcf(int a,int b);

srand(time(NULL));

int i, x1, y1, x2, y2, mNumerator, mDenominator, numOfProblems, numCorrect;
string_t stuAnsM, stuAnsB, ansM, ansB;
double percentCorrect;

printf("Enter the number of problems you want to do:\n");
scanf("%d", &numOfProblems);

for(i=0; i<numOfProblems; i++){
    x1 = getRandInt(); y1 = getRandInt(); x2 = getRandInt(); y2 = getRandInt(); 
    mNumerator = getRandInt(); mDenominator = abs(getRandInt());
    
    while(x1==x2){
        x1 = getRandInt(); x2 = getRandInt();
    }
    
    while(gcf(abs(mNumerator), abs(mDenominator))!=1){
        mNumerator = getRandInt(); mDenominator = abs(getRandInt());
    }
    
    printf("\n\n");
    
    switch(1+rand()%2){
        case 1: printf("#%d: ", (i+1));
                printf("%s\n", problem1Print(mNumerator, mDenominator, x1,y1));
                strcpy(ansM, problem1Slope(mNumerator, mDenominator, x1,y1));
                strcpy(ansB, problem1Yint(mNumerator, mDenominator, x1,y1));
                break;
        case 2: printf("#%d: ", (i+1));
                printf("%s\n", problem2Print(x1,y1,x2,y2));
                strcpy(ansM, problem2Slope(x1,y1,x2,y2));
                strcpy(ansB, problem2Yint(x1,y1,x2,y2));
                break;  
        default: printf("THE PC PICKED THE WRONG EQUATION!!!");
                exit(1);
    }
    printf("Enter your answer: (y=mx+b)\n");
    printf("  m = ");
    scanf("%s", &stuAnsM);
    printf("  b = ");
    scanf("%s", &stuAnsB);
    
    if(equals(ansM, stuAnsM) && equals(ansB, stuAnsB)){
        printf("\n*** Great Job ***\n");
        numCorrect++;
    }
    else{
        string_t op1 = "";
        if(strchr(ansB,'-')==NULL) strcpy(op1,"+");
        
        printf("\nSorry, the correct answers is y=(%s)x%s%s ...\n", ansM, op1, ansB);
    }
    sleep(2);
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


/* 
 * This prints out the question for the problem:
 *    Find the line through with slope 'm' and contains the point (x,y).
 */
string_t problem1Print(int mNumerator, int mDenominator, int x1, int y1){
    string_t ans;
	char str[512];

    if(mDenominator!=1)
        sprintf(str, "Find the line with slope %d/%d and contains the point (%d,%d).\n",
            mNumerator, mDenominator, x1, y1);
    else
        sprintf(str, "Find the line with slope %d and contains the point (%d,%d).\n",
            mNumerator, x1, y1);
        
	ans = str;
    return ans;
}
/* 
 * This prints out the question for the problem:
 *    Find the line through the two points (x1,y1) and (x2,y2).
 */
string_t problem2Print(int x1, int y1, int x2, int y2){
    string_t ans;
	char str[512];

    sprintf(str, "Find the line through the points (%d,%d) and (%d,%d).\n", x1, y1, x2, y2);
        
	ans = str;
    return ans;
}

/* 
 * This prints out the slope of the line for the problem:
 *    Find the line through with slope 'm' and contains the point (x,y).
 */
string_t problem1Slope(int mNumerator, int mDenominator, int x1, int y1){
    return simplifyFraction(mNumerator, mDenominator);
}
/* 
 * This prints out the y-intercept of the line for the problem:
 *    Find the line through with slope 'm' and contains the point (x,y).
 */
string_t problem1Yint(int mNumerator, int mDenominator, int x1, int y1){
    return simplifyFraction(y1*mDenominator-mNumerator*x1, mDenominator);
}
/* 
 * This finds out the slope of the line for the problem:
 *    Find the line through the two points (x1,y1) and (x2,y2).
 */
string_t problem2Slope(int x1, int y1, int x2, int y2){
    return simplifyFraction(y2-y1,x2-x1);
}
/* 
 * This finds out the y-intercept of the line for the problem:
 *    Find the line through the two points (x1,y1) and (x2,y2).
 */
string_t problem2Yint(int x1, int y1, int x2, int y2){
    return simplifyFraction(x2*y1-x1*y2,x2-x1);
}



string_t simplifyFraction(int numerator, int denominator) {
    string_t ans;
    char str[32];
    int GDC;
    
    if (denominator == 0)
        ans = "UD";
    else {
        GDC = gcf(abs(numerator), abs(denominator));
        numerator/=GDC; denominator/=GDC;
        
        if(denominator<0){
            numerator*=-1; denominator*=-1;
        }
        
        if(denominator == 1)
            sprintf(str, "%d", numerator);
        else
            sprintf(str, "%d/%d", numerator, denominator);
        
        ans = str;
    }
    return ans;
}


int getRandInt(){
    int sign = (rand()%2==0) ? 1 : -1;

    return sign * (1 + rand()%MAX_COEFFICIENT);
}


/*
 * returns 1 if the fractions are the same, else 0.
 */
int equals(char* frac1, char* frac2){
    int a1, b1, a2, b2;
    int i, inputFraction = 0, ansFraction=0;
    char frac1Copy[32];
    char frac2Copy[32];
    
    strcpy(frac1Copy, frac1);
    strcpy(frac2Copy, frac2);
    
    /*
     * Checking to see if the fractions are not integers.
     */
    for(i=0; i<strlen(frac2); i++){
        if(frac1[i]=='/')
            ansFraction = 1;
        if(frac2[i]=='/')
            inputFraction = 1;
    }

    a1 = atoi(strtok(frac1Copy, "(/ "));
    b1 = (ansFraction == 1) ? atoi(strtok(NULL, "/  ()")) : 1;
    
    a2 = atoi(strtok(frac2Copy, "/  ()"));
    b2 = (inputFraction == 1) ? atoi(strtok(NULL, "/  ()")) : 1;
    
    if(a1 == a2 && b1 == b2)
        return 1;
    else
        return 0;
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

