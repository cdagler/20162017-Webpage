/* File:    practiceEq1.ch
 * Version: 2.1
 *
 * Purpose: This program provides pratice equations in one variable.
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_COEFFICIENT 12

/*
 * This finds the Greatest Common Factor of 2 numbers (Euclidean Algorithm).
 */
int gcf(int a,int b);

string_t equation01Print(int A, int B, int C);
string_t equation02Print(int A, int B, int C);
string_t equation03Print(int A, int B, int C, int D);
string_t equation04Print(int A, int B, int C, int D, int E);
string_t equation05Print(int A, int B, int C, int D);

string_t equation01Solve(int A, int B, int C);
string_t equation02Solve(int A, int B, int C);
string_t equation03Solve(int A, int B, int C, int D);
string_t equation04Solve(int A, int B, int C, int D, int E);
string_t equation05Solve(int A, int B, int C, int D);

int getRandInt();
int equals(char* frac1,char* frac2);

srand(time(NULL));

int i, a, b, c, d, e, numOfProblems, numCorrect;
char stuAns[32]="", ans[32]="";
double percentCorrect;

printf("Enter the number of problems you want to do: ");
scanf("%d", &numOfProblems);

for(i=0; i<numOfProblems; i++){
    a = getRandInt(); b = getRandInt(); c = getRandInt(); 
    d = getRandInt(); e = getRandInt();
            
    printf("\n\n");

    switch(1+rand()%5){
        case 1: printf("#%d: Solve: %s\n", (i+1), equation01Print(a,b,c));
                strcpy(ans, equation01Solve(a,b,c));
                break;
        case 2: b=abs(b);
                if(gcf(a,b)!=1) a+=1;
                printf("#%d: Solve: %s\n", (i+1), equation02Print(a,b,c));
                strcpy(ans, equation02Solve(a,b,c));
                break;     
        case 3: printf("#%d: Solve: %s\n", (i+1), equation03Print(a,b,c,d));
                strcpy(ans, equation03Solve(a,b,c,d));
                break;
        case 4: printf("#%d: Solve: %s\n", (i+1), equation04Print(a,b,c,d,e));
                strcpy(ans, equation04Solve(a,b,c,d,e));
                break;
        case 5: printf("#%d: Solve: %s\n", (i+1), equation05Print(a, b, c, d));
                strcpy(ans, equation05Solve(a, b, c, d));
                break;
        default: printf("THE PC PICKED THE WRONG EQUATION!!!");
                exit(1);
    }

    printf("Write your answer in (a/b).\n");
    printf("x = ");
    scanf("%s", &stuAns);

    if(equals(ans, stuAns)){
        printf("\n*** Great Job ***\n");
        numCorrect++;
    }
    else
        printf("\nSorry, the correct answer is %s ...\n", ans);
    
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
 * This prints A=Bx+C
 */
string_t equation01Print(int A, int B, int C){
    char ans[64]="";
    char op1[4]=""; 
    
    if(C>0) strcpy(op1, "+");
        
    sprintf(ans, "%d=%dx%s%d",A,B,op1,C);
    return ans;
}
/*
 * This prints (A/B)x=C
 */
string_t equation02Print(int A, int B, int C){
    char ans[64]="";
        
    sprintf(ans, "(%d/%d)x=%d",A,B,C);
    return ans;    
}


/*
 * This prints Ax+B=Cx+D
 */
string_t equation03Print(int A, int B, int C, int D)
{
    char ans[64]="";
    char op1[4]="", op2[4]=""; 
    
    if(B>0) strcpy(op1, "+");
    if(D>0) strcpy(op2, "+");
        
    sprintf(ans, "%dx%s%d=%dx%s%d",A,op1,B,C,op2,D);
    return ans;    
}

/*           
 * This prints Ax+B+Cx+D=E
 */
string_t equation04Print(int A, int B, int C, int D, int E)
{
    char ans[64]="";
    char op1[4]="", op2[4]="", op3[4]="";

    if(B>0) strcpy(op1, "+");
    if(C>0) strcpy(op2, "+");
    if(D>0) strcpy(op3, "+");

    sprintf(ans, "%dx%s%d%s%dx%s%d=%d",A,op1,B,op2,C,op3,D,E);
    return ans;
}

/*           
 * This prints A=B(Cx+D)
 */
string_t equation05Print(int A, int B, int C, int D)
{
    char ans[64]="";
    char op1[4]=""; 
    
    if(D>0) strcpy(op1, "+");
        
    sprintf(ans, "%d=%d(%dx%s%d)",A,B,C,op1,D);
    return ans;
}

/*
 * This solves A=Bx+C
 */
string_t equation01Solve(int A, int B, int C){
    char ans[32]="";
    int numerator = A-C;
    int denominator = B;
    int GDC = gcf(abs(numerator), abs(denominator));
    numerator /= GDC;
    denominator /= GDC;
    
    if(denominator<0){
        numerator *= -1;
        denominator *= -1;
    }
    if(denominator!=1)
        sprintf(ans, "%d/%d", numerator, denominator);
    else
        sprintf(ans, "%d", numerator);
    
    return ans;
}

/*
 * This solves (A/B)x=C
 */
string_t equation02Solve(int A, int B, int C)
{
    char ans[32]="";
    int numerator = B*C;
    int denominator = A;
    int GDC = gcf(abs(numerator), abs(denominator));
    numerator /= GDC;
    denominator /= GDC;
    
    if(denominator<0){
        numerator *= -1;
        denominator *= -1;
    }
    if(denominator!=1)
        sprintf(ans, "%d/%d", numerator, denominator);
    else
        sprintf(ans, "%d", numerator);
    
    return ans;
}
/*
 * This solves Ax+B=Cx+D
 */
string_t equation03Solve(int A, int B, int C, int D)
{
    char ans[32]="";
    int numerator = B-D;
    int denominator = C-A;
    int GDC = gcf(abs(numerator), abs(denominator));
    numerator /= GDC;
    denominator /= GDC;
    
    if(denominator<0){
        numerator *= -1;
        denominator *= -1;
    }
    if(denominator!=1)
        sprintf(ans, "%d/%d", numerator, denominator);
    else
        sprintf(ans, "%d", numerator);
    
    return ans;
}
/*           
 * This solves Ax+B+Cx+D=E
 */
string_t equation04Solve(int A, int B, int C, int D, int E)
{
    char ans[32]="";
    int numerator = E-D-B;
    int denominator = A+C;
    int GDC = gcf(abs(numerator), abs(denominator));
    numerator /= GDC;
    denominator /= GDC;
    
    if(denominator<0){
        numerator *= -1;
        denominator *= -1;
    }
    if(denominator!=1)
        sprintf(ans, "%d/%d", numerator, denominator);
    else
        sprintf(ans, "%d", numerator);
    
    return ans;
}
/*           
 * This prints A=B(Cx+D)
 */
string_t equation05Solve(int A, int B, int C, int D)
{
    char ans[32]="";
    int numerator = A-B*D;
    int denominator = B*C;
    int GDC = gcf(abs(numerator), abs(denominator));
    numerator /= GDC;
    denominator /= GDC;
    
    if(denominator<0){
        numerator *= -1;
        denominator *= -1;
    }
    if(denominator!=1)
        sprintf(ans, "%d/%d", numerator, denominator);
    else
        sprintf(ans, "%d", numerator);
    
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

    a1 = atoi(strtok(frac1Copy, "/ "));
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
