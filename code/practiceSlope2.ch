/* File:    practiceSlope2.ch 
 * Version: 2.1
 *
 * Purpose: This program provides practice finding the slope for a variety of 
 * problems. Finding the slope of a line: 
 *    - through two points
 *    - parallel to a different line
 *    - perpendicular  to a different line
 *    - when given its x-intercept and a different point
 *    - when given its y-intercept and a different point.
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_COEFFICIENT 8

string_t problem1Print(int x1, int y1, int x2, int y2);
string_t problem2Print(int A, int B, int C);
string_t problem3Print(int A, int B, int C);
string_t problem4Print(int x1, int x2, int y2);
string_t problem5Print(int y1, int x2, int y2);

string_t problem1Solution(int x1, int y1, int x2, int y2);
string_t problem2Solution(int A, int B, int C);
string_t problem3Solution(int A, int B, int C);
string_t problem4Solution(int x1, int x2, int y2);
string_t problem5Solution(int y1, int x2, int y2);

string_t simplifyFraction(int a, int b);

int getRandInt();
int equals(char* val1, char* val2);
/*
 * This finds the Greatest Common Factor of 2 numbers (Euclidean Algorithm).
 */
int gcf(int a,int b);

srand(time(NULL));

int i, x1, y1, x2, y2, A, B, C, numOfProblems, numCorrect;
string_t stuAns, ans;
double percentCorrect;

printf("Enter the number of problems you want to do:\n");
scanf("%d", &numOfProblems);

for(i=0; i<numOfProblems; i++){
    x1 = getRandInt(); y1 = getRandInt(); x2 = getRandInt(); y2 = getRandInt(); 
    A = abs(getRandInt()); B = getRandInt(); C = getRandInt();
    
    printf("\n\n");
    
    switch(1+rand()%5){
        case 1: while(x1==x2){
                    x1 = getRandInt(); x2 = getRandInt();
                }
                printf("#%d: ", (i+1));
                printf("%s\n", problem1Print(x1,y1,x2,y2));
                strcpy(ans, problem1Solution(x1,y1,x2,y2));
                break;
        case 2: printf("#%d: ", (i+1));
                printf("%s\n", problem2Print(A,B,C));
                strcpy(ans, problem2Solution(A,B,C));
                break;  
        case 3: printf("#%d: ", (i+1));
                printf("%s\n", problem3Print(A,B,C));
                strcpy(ans, problem3Solution(A,B,C));
                break;  
        case 4: printf("#%d: ", (i+1));
                printf("%s\n", problem4Print(x1,x2,y2));
                strcpy(ans, problem4Solution(x1,x2,y2));
                break;
        case 5: printf("#%d: ", (i+1));
                printf("%s\n", problem5Print(y1,x2,y2));
                strcpy(ans, problem5Solution(y1,x2,y2));
                break;
        default: printf("THE PC PICKED THE WRONG EQUATION!!!");
                exit(1);
    }
    printf("Enter your answer:\n");
    printf("  m = ");
    scanf("%s", &stuAns);

    if(equals(ans, stuAns))
    {
        printf("\n*** Great Job ***\n");
        numCorrect++;
    }
    else
        printf("\nSorry, the correct answers is m = %s ...\n", ans);
    
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
string_t problem1Print(int x1, int y1, int x2, int y2){
    string_t ans;
	char str[512];

    sprintf(str, "Find the slope of the line through the points (%d,%d) and (%d,%d).\n", x1, y1, x2, y2);
    
	ans = str;
    return ans;
}
/* 
 * This prints out the question for the problem:
 *    Finding the slope of a line parallel to a different line.
 */
string_t problem2Print(int a, int b, int c){    
    string_t ans;
	char str[512], op1;
    
    op1 = b>0 ? '+' : '-';
    
    if(abs(a*b)==1)
        sprintf(str, "Find the slope of the line that is parallel to x%cy=%d.\n", op1, c);
    else if(a==1)
        sprintf(str, "Find the slope of the line that is parallel to x%c%dy=%d.\n", op1, abs(b), c);
    else if(b==1)
        sprintf(str, "Find the slope of the line that is parallel to %dx%cy=%d.\n", a, op1, c);
    else
        sprintf(str, "Find the slope of the line that is parallel to %dx%c%dy=%d.\n", a, op1, abs(b), c);
        
	ans = str;
    return ans;
}
/* 
 * This prints out the question for the problem:
 *    Finding the slope of a line perpendicular to a different line
 */
string_t problem3Print(int a, int b, int c){    
    string_t ans;
	char str[512], op1;
    
    op1 = b>0 ? '+' : '-';
    
    if(abs(a*b)==1)
        sprintf(str, "Find the slope of the line that is perpendicular to x%cy=%d.\n", op1, c);
    else if(a==1)
        sprintf(str, "Find the slope of the line that is perpendicular to x%c%dy=%d.\n", op1, abs(b), c);
    else if(b==1)
        sprintf(str, "Find the slope of the line that is perpendicular to %dx%cy=%d.\n", a, op1, c);
    else
        sprintf(str, "Find the slope of the line that is perpendicular to %dx%c%dy=%d.\n", a, op1, abs(b), c);
    
	ans = str;
    return ans;
}
/* 
 * This prints out the question for the problem:
 *    Finding the slope of a line when given its x-intercept and a different point.
 */
string_t problem4Print(int x1, int x2, int y2){
    string_t ans;
	char str[512];

    sprintf(str, "Find the slope of the line that has an x-intercept of %d and passes through the point(%d,%d).\n",
    x1, x2, y2);
    
	ans = str;
    return ans;
}
/* 
 * This prints out the question for the problem:
 *    Finding the slope of a line when given its y-intercept and a different point.
 */
string_t problem5Print(int y1, int x2, int y2){
    string_t ans;
	char str[512];

    sprintf(str, "Find the slope of the line that has an y-intercept of %d and passes through the point(%d,%d).\n",
    y1, x2, y2);
    
	ans = str;
    return ans;
}

/* 
 * This finds out the solution for the problem:
 *    Finding the slope of a line through two points.
 */
string_t problem1Solution(int x1, int y1, int x2, int y2){
    return simplifyFraction(y2-y1,x2-x1);
}
/* 
 * This finds out the solution for the problem:
 *    Finding the slope of a line parallel to a different line.
 */
string_t problem2Solution(int A, int B, int C){
    return simplifyFraction(-1*A,B);
}
/* 
 * This finds out the solution for the problem:
 *    Finding the slope of a line perpendicular to a different line.
 */
string_t problem3Solution(int A, int B, int C){
    return simplifyFraction(B,A);
}
/* 
 * This finds out the solution for the problem:
 *    Finding the slope of a line when given its x-intercept and a different point.
 */
string_t problem4Solution(int x1, int x2, int y2){
    return simplifyFraction(y2-0,x2-x1);
}
/* 
 * This finds out the solution for the problem:
 *    Finding the slope of a line when given its y-intercept and a different point.
 */
string_t problem5Solution(int y1, int x2, int y2){
    return simplifyFraction(y2-y1,x2-0);
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

