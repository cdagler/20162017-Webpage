/* File:    practiceFactoringPolys.ch 
 * Version: 3.1
 *
 * Purpose: This program provides practice factoring polynomials
 *          of the form:
 *              difference of squares
 *              common factor
 *              x^2+Bx+C
 *              Ax^2+Bx+C
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_COEFFICIENT 8

#define DIF_SQRS 1   //Pratice Differences of Squares Only
#define COM_FACT 2   //Pratice Common Factoring Only
#define E_TRY 3      //Pratice x^2+Bx+C Only
#define H_TRY 4      //Pratice Ax^2+Bx+C Only
#define FACTOR_ALL 5 //Pratice All 4 Types of Factoring

string_t expression1Print(char var);
string_t expression2Print(char var);
string_t expression3Print(char var);
string_t expression4Print(char var);

string_t expression1Ans(int &A,int &B, int &C, int &D, char var);
string_t expression2Ans(int &A,int &B, int &C, int &D, char var);
string_t expression3Ans(int &A,int &B, int &C, int &D, char var);
string_t expression4Ans(int &A,int &B, int &C, int &D, char var);

string_t getTermNoOp(int val, char var);
string_t getTerm(int val, char var);
string_t getConstTerm(int val);

int getRandInt();
int gcf(int a,int b);

static int a, b, c, d;

int main(){
    int ansA, ansB, ansC, ansD, stuA, stuB, stuC, stuD, i, numOfProblems, numCorrect;
    int factoringType, problemType;
    string_t ans;
    char var;
    double percentCorrect;
    
    srand(time(NULL));
    
    printf("Enter the number of problems to Pratice: ");
    scanf("%d", &numOfProblems);

    printf("What do you want to pratice. Enter\n");
    printf("  1) To Practice Factoirng Differences of Squares Only.\n");
    printf("  2) To Practice Factoirng by Common Factoring Only.\n");
    printf("  3) To Practice Factoirng x^2-Bx+C Only.\n");
    printf("  4) To Practice Factoirng Ax^2-Bx+C Only.\n");
    printf("  5) To Practice Factoirng All of the Above Expressions.\n");
    scanf("%d", &factoringType);
    
    for(i=0; i<numOfProblems; i++){  
        switch((1+rand()%5)){
            case 1: var = 'x'; break;
            case 2: var = 'y'; break;
            case 3: var = 'm'; break;
            case 4: var = 'n'; break;
            case 5: var = 'q'; break;
        }
        
        printf("\n\n");
        
        if(factoringType == FACTOR_ALL)
            problemType = 1+rand()%4;
        else 
            problemType = factoringType;

        switch(problemType){
            case 1: printf("#%d: Factor: %s.\n", (i+1), expression1Print(var));
                    strcpy(ans, expression1Ans(ansA, ansB, ansC, ansD, var));
                    printf("For your answer (A%c+B)(C%c+D), enter:\n", var, var);
                    printf("   A: "); scanf("%d", &stuA);
                    printf("   B: "); scanf("%d", &stuB);
                    printf("   C: "); scanf("%d", &stuC);
                    printf("   D: "); scanf("%d", &stuD);
                    break;
            case 2: printf("#%d: Factor: %s.\n", (i+1), expression2Print(var));
                    strcpy(ans, expression2Ans(ansA, ansB, ansC, ansD, var));
                    printf("For your answer A(B%c^2+C%c+D), enter:\n", var, var);
                    printf("   A: "); scanf("%d", &stuA);
                    printf("   B: "); scanf("%d", &stuB);
                    printf("   C: "); scanf("%d", &stuC);
                    printf("   D: "); scanf("%d", &stuD);
                    break;
            case 3: printf("#%d: Factor: %s.\n", (i+1), expression3Print(var));
                    strcpy(ans, expression3Ans(ansA, ansB, ansC, ansD, var));
                    printf("For your answer (A%c+B)(C%c+D), enter:\n", var, var);
                    printf("   A: "); scanf("%d", &stuA);
                    printf("   B: "); scanf("%d", &stuB);
                    printf("   C: "); scanf("%d", &stuC);
                    printf("   D: "); scanf("%d", &stuD);
                    break;
            case 4: printf("#%d: Factor: %s.\n", (i+1), expression4Print(var));
                    strcpy(ans, expression4Ans(ansA, ansB, ansC, ansD, var));
                    printf("For your answer (A%c+B)(C%c+D), enter:\n", var, var);
                    printf("   A: "); scanf("%d", &stuA);
                    printf("   B: "); scanf("%d", &stuB);
                    printf("   C: "); scanf("%d", &stuC);
                    printf("   D: "); scanf("%d", &stuD);
                    break;
            default: printf("THE PC PICKED THE WRONG EQUATION!!!");
                    exit(1);   
        }
        
        if(ansA==stuA && ansB==stuB && ansC==stuC && ansD==stuD || 
           ansA==stuC && ansB==stuD && ansC==stuA && ansD==stuB)
        {
            printf("\n*** Great Job ***\n");
            numCorrect++;
        }
        else
            printf("\nSorry, the correct answers is %s ...\n", ans);
        
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
 * This returns (a*a)x^2-(b*b).
 */
string_t expression1Print(char var){
    string_t ans;
    char str[512];
    int GCF;

    a = abs(getRandInt()); b = abs(getRandInt());    
    GCF = gcf(a,b);
    while(GCF!=1){
        a = abs(getRandInt()); b = abs(getRandInt());    
        GCF = gcf(a,b);
    }

    sprintf(str, "%s^2%s", getTermNoOp(a*a, var), getConstTerm(-1*b*b));
    
    ans = str;
    return ans;
}


/*
 * This returns (a*b)x^2+(a*c)x+a*d.
 */
string_t expression2Print(char var){
    string_t ans;
    char str[512];
    int GCF;

    a = abs(getRandInt())+3; b = abs(getRandInt()); 
    c = getRandInt(); d = getRandInt();
    GCF = gcf(b,abs(c));
    while(GCF!=1){
        b = abs(getRandInt()); c = getRandInt();    
        GCF = gcf(b,abs(c));
    }

    sprintf(str, "%s^2%s%s", getTermNoOp(a*b, var), getTerm(a*c, var), getConstTerm(a*d));
    ans = str;
    return ans;
}

/*
 * This returns x^2+(b+d)x+b*d.
 */
string_t expression3Print(char var){
    string_t ans;
    char str[512];
    int GCF;

    b = getRandInt(); d = getRandInt();
    GCF = gcf(abs(b+d),abs(b*d));
    while(GCF!=1 && b+d==0){
        b = getRandInt(); d = getRandInt();    
        GCF = gcf(abs(b+d),abs(b*d));
    }
    
    sprintf(str, "%c^2%s%s", var,  getTerm(b+d, var), getConstTerm(b*d));
    ans = str;
    return ans;
}

/*
 * This returns (a*c)x^2+(a*d+b*c)x+b*d.
 */
string_t expression4Print(char var){
    string_t ans;
    char str[512];
    int GCF;
    
    while(GCF!=1){
        switch((1+rand()%9)){
            case 1: a=2; c=3; break;
            case 2: a=6; c=1; break;
            case 3: a=2; c=2; break;
            case 4: a=4; c=1; break;
            case 5: a=2; c=6; break;
            case 6: a=6; c=2; break;
            case 7: a=3; c=4; break;
            case 8: a=4; c=3; break;
            case 9: a=5; c=1; break;
        } 
        switch((1+rand()%8)){
            case 1: b=1; d=1; break;
            case 2: b=-1; d=-1; break;
            case 3: b=-2; d=-1; break;
            case 4: b=-1; d=-2; break;
            case 5: b=3; d=1; break;
            case 6: b=-3; d=-1; break;
            case 7: b=2; d=3; break;
            case 8: b=-2; d=-3; break;
        } 
        GCF = gcf(abs(a*c),abs(a*d+b*c));
        GCF = gcf(GCF,b*d);
    }     
    
    sprintf(str, "%s^2%s%s", getTermNoOp(a*c, var), getTerm(a*d+b*c, var), getConstTerm(b*d));
    ans = str;
    return ans;
}

/*
 * For the expression (a*a)x^2-(b*b)=(Ax+B)(Cx+D) it sets:
 *     A = a
 *     B = b
 *     C = a
 *     D = -b
 * and returns (Ax+B)(Cx+D).
 */
string_t expression1Ans(int &A,int &B, int &C, int &D, char var){
    string_t ans;
    char str[512];
    
    A = C = a;
    B = b;
    D = -1*b;
    
    sprintf(str, "(%s%s)(%s%s)", getTermNoOp(A, var), getConstTerm(B), 
        getTermNoOp(C, var), getConstTerm(D));
    
    ans = str;
    return ans;
}

/*
 * For the expression (a*b)x^2+(a*c)x+a*d=A(Bx^2+Cx+D) it sets:
 *     A = a
 *     B = b
 *     C = c
 *     D = d
 * and returns A(Bx^2+Cx+D)
 */
string_t expression2Ans(int &A,int &B, int &C, int &D, char var){
    string_t ans;
    char str[512];
    
    A=a;
    B=b;
    C=c;
    D=d;

    sprintf(str, "%d(%s^2%s%s)", a, getTermNoOp(B, var), getTerm(C, var), getConstTerm(D));
    
    ans = str;
    return ans;
}

/*
 * For the expression x^2+(b+d)x+b*d=(Ax+B)(Cx+D) it sets:
 *     A = 1
 *     B = b
 *     C = 1
 *     D = d
 * and returns (Ax+B)(Cx+D).
 */
string_t expression3Ans(int &A,int &B, int &C, int &D, char var){
    string_t ans;
    char str[512];
    
    A = C = 1;
    B = b;
    D = d;
    
    sprintf(str, "(%s%s)(%s%s)", getTermNoOp(A, var), getConstTerm(B), 
        getTermNoOp(C, var), getConstTerm(D));
    
    ans = str;
    return ans;
}

/*
 * This returns (a*c)x^2+(a*d+b*c)x+b*d.
 */
/*
 * For the expression (a*c)x^2+(a*d+b*c)x+b*d=(Ax+B)(Cx+D) it sets:
 *     A = a
 *     B = b
 *     C = c
 *     D = d
 * and returns (Ax+B)(Cx+D).
 */
string_t expression4Ans(int &A,int &B, int &C, int &D, char var){
    string_t ans;
    char str[512];

    A=a;
    B=b;
    C=c;
    D=d;

    sprintf(str, "(%s%s)(%s%s)", getTermNoOp(A, var), getConstTerm(B), getTermNoOp(C, var), 
        getConstTerm(D));
    
    ans = str;
    return ans;
}
/*
 * The next 3 functions are used to help with formatting; e.g.:
 *    No '+-'
 *    No '1x' ...
 */
string_t getTermNoOp(int val, char var){
    string_t ans;
	char str[16];
    
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
	char str[16];

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
	char str[16];

    if(val<0) 
        sprintf(str, "%d", val);
    else
        sprintf(str, "+%d", val);
    
	ans = str;
    return ans;
}


int getRandInt(){
    int sign = (rand()%2==0) ? 1 : -1;
    return sign * (1 + rand()%MAX_COEFFICIENT);
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
