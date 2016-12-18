/* File:    practiceFindingMandB.ch 
 * Version: 2.1
 *
 * Purpose: This program provides practice finding the slope (m) and 
 *  y-intercept (b) of a line when the equation is given in:
 *    - standard form [Ax+By=C]
 *    - point slope form [y-A=B(x-C)]
 *    - 'solved' for x [Ax=By+C] 
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_COEFFICIENT 8

void problem1Print();
void problem2Print();
void problem3Print();

string_t problem1Slope();
string_t problem1Yint();
string_t problem2Slope();
string_t problem2Yint();
string_t problem3Slope();
string_t problem3Yint();

string_t getTermNoOp(int val, char var);
string_t getTerm(int val, char var);
string_t getConstTerm(int val);

string_t fracToString(int numerator, int denominator);

int equals(char* val1, char* val2);
/*
 * This finds the Greatest Common Factor of 2 numbers (Euclidean Algorithm).
 */
int gcf(int a,int b);

static int A, B, C;
static char var1='x', var2='y';

int main(){
    int i, numOfProblems, numCorrect;
    string_t stuAnsM, stuAnsB, ansM, ansB;
    double percentCorrect;
        
    printf("Enter the number of problems you want to do:\n");
    scanf("%d", &numOfProblems);

    for(i=0; i<numOfProblems; i++){    
        switch(randint(1,3)){
            case 1: problem1Print();
                    ansM = problem1Slope();
                    ansB = problem1Yint();
                    break;
            case 2: problem2Print();
                    ansM = problem2Slope();
                    ansB = problem2Yint();
                    break;
            case 3: problem3Print();
                    ansM = problem3Slope();
                    ansB = problem3Yint();
                    break;
        }
            
        printf("Enter your answer: (%c=m%c+b)\n", var2, var1);
        printf("  m = ");
        scanf("%s", &stuAnsM);
        printf("  b = ");
        scanf("%s", &stuAnsB);
    
        if(equals(ansM, stuAnsM) && equals(ansB, stuAnsB)){
            printf("\n*** Great Job ***\n\n\n");
            numCorrect++;
        }
        else{
            string_t op1 = "";
            if(strchr(ansB,'-')==NULL) strcpy(op1,"+");
        
            printf("\nSorry, the correct answers is y=(%s)x%s%s ...\n\n\n", ansM, op1, ansB);
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
}
/* 
 * This prints out the question for finding the m and b for a line in standard form.
 */
void problem1Print(){
    A = abs(getRandInt());
    B = getRandInt();
    C = getRandInt();
    
    printf("What is the slope (m) and y-intercept (b) for the line %s%s=%d?\n", 
        getTermNoOp(A,var1), getTerm(B,var2), C);
    
}
/* 
 * This prints out the question for finding the m and b for a line in point slope form.
 */
void problem2Print(){
    A = getRandInt();
    B = getRandInt();
    C = getRandInt();
    
    printf("What is the slope (m) and y-intercept (b) for the line %c%s=%d(%c%s)?\n", 
        var2, getConstTerm(A), B, var1, getConstTerm(C));    
}

/* 
 * This prints out the question for finding the m and b for a line 'solved' for x.
 */
void problem3Print(){
    A = getRandInt();
    B = getRandInt();
    C = getRandInt();
    
    printf("What is the slope (m) and y-intercept (b) for the line %s=%s%s?\n", 
        getTermNoOp(A,var1), getTermNoOp(B,var2), getConstTerm(C));     
}


string_t problem1Slope(){
    return fracToString(-1*A,B);
}
string_t problem1Yint(){
    return fracToString(C,B);
}

string_t problem2Slope(){
    return fracToString(B,1);
}
string_t problem2Yint(){
    return fracToString(B*C-A,1);
}

string_t problem3Slope(){
    return fracToString(A,B);
}
string_t problem3Yint(){
    return fracToString(-1*C,B);
}

int getRandInt(){
    int sign = (rand()%2==0) ? 1 : -1;
    
    return sign * randint(1,MAX_COEFFICIENT);
}

/*
 * The next 3 functions are used to help with formatting; e.g.:
 *    No '+-'
 *    No '1x' ...
 */
string_t getTermNoOp(int val, char var){
    string_t ans;
    char str[64];
    
    if(val==1) 
        sprintf(str, "%c", var); 
    else if(val==-1)
        sprintf(str, "-%c", var);
    else 
        sprintf(str, "%d%c", val, var);

    ans = str;
    return ans;
}

string_t getTerm(int val, char var){
    string_t ans;
    char str[64];
    
    if(val==1) 
        sprintf(str, "+%c", var);
    else if(val==-1)
        sprintf(str, "-%c", var);
    else if(val>0)
        sprintf(str, "+%d%c", val, var);
    else
        sprintf(str, "%d%c", val, var);
    
    ans = str;
    return ans;
}

string_t getConstTerm(int val){
    string_t ans;
    char str[64];
    
    if(val<0) 
        sprintf(str, "%d", val);
    else
        sprintf(str, "+%d", val);
    
    ans = str;
    return ans;
}

string_t fracToString(int numerator, int denominator){
    char ans[512]="";
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

