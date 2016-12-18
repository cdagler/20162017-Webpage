/* File:    practiceSlope1.ch 
 * Version: 2.1
 *
 * Purpose: This program provides practice finding the slope of a line
 * through two points.
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_COEFFICIENT 8

string_t problemPrint(int x1, int y1, int x2, int y2);
string_t problemSolution(int x1, int y1, int x2, int y2);

string_t simplifyFraction(int numerator, int denominator);

int getRandInt();
int equals(char* val1, char* val2);
/*
 * This finds the Greatest Common Factor of 2 numbers (Euclidean Algorithm).
 */
int gcf(int a,int b);

srand(time(NULL));

int i, x1, y1, x2, y2, numOfProblems, numCorrect;
string_t stuAns, ans;
double percentCorrect;

printf("Enter the number of problems you want to do:\n");
scanf("%d", &numOfProblems);

for(i=0; i<numOfProblems; i++){
    x1 = getRandInt(); y1 = getRandInt(); x2 = getRandInt(); y2 = getRandInt(); 
    
    printf("\n\n");
    
    while(x1==x2){
        x1 = getRandInt(); x2 = getRandInt();
    }
    printf("#%d: ", (i+1));
    printf("%s\n", problemPrint(x1,y1,x2,y2));
    strcpy(ans, problemSolution(x1,y1,x2,y2));
    
    printf("Enter your answer:\n");
    printf("  m = ");
    scanf("%s", &stuAns);

    if(equals(ans, stuAns)) {
        printf("\n*** Great Job ***\n");
        numCorrect++;
    }
    else
        printf("\nSorry, the correct answers is m=%s ...\n", ans);
    
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
 *    Finding the slope of a line through two points.
 */
string_t problemPrint(int x1, int y1, int x2, int y2){
    string_t ans;
    char str[128];
    
    sprintf(str, "Find the slope of the line through the points (%d,%d) and (%d,%d).\n", x1, y1, x2, y2);
    
    ans = str;
    return ans;
}

/* 
 * This finds out the solution for the problem:
 *    Finding the slope of a line through two points.
 */
string_t problemSolution(int x1, int y1, int x2, int y2){
    return simplifyFraction(y2-y1,x2-x1);
}



/* This takes any fraction a/b and simplifies it. The output
 * will have a positive denominator and if the denominator is
 * zero it returns "UD".
 */
string_t simplifyFraction(int a, int b) {
    string_t ans;
    char str[64];
    int GDC;
    
    if (b == 0)
        ans = "UD";
    else {
        GDC = gcf(abs(a), abs(b));
        a/=GDC; b/=GDC;
        
        if(b<0){
            a*=-1; b*=-1;
        }
        
        if(b == 1)
            sprintf(str, "%d", a);
        else
            sprintf(str, "%d/%d", a, b);
        
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
