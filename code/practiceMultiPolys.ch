/* File:    practiceMultiPolys.ch
 * Version: 2.1
 *
 * Purpose: This program provides practice solving multiplying polynomials:
 *              ax(bx^2+cx+d)
 *              (ax+b)(cx+d)
 *              (ax+b)^2
 *              (ax+b)(cx^2+dx+e)
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_COEFFICIENT 8

string_t expression1Print(int a, int b, int c, int d, char var);
string_t expression2Print(int a, int b, int c, int d, char var);
string_t expression3Print(int a, int b, char var);
string_t expression4Print(int a, int b, int c, int d, int e, char var);

string_t expression1Ans(int a, int b, int c, int d, int &A,int &B, int &C, char var);
string_t expression2Ans(int a, int b, int c, int d, int &A,int &B, int &C, char var);
string_t expression3Ans(int a, int b, int &A,int &B, int &C, char var);
string_t expression4Ans(int a, int b, int c, int d, int e, int &A,int &B, int &C, int &D, char var);

string_t getTermNoOp(int val, char var);
string_t getTerm(int val, char var);
string_t getConstTerm(int val);

srand(time(NULL));

int main(){
    int i, a, b, c, d, e, numOfProblems, numCorrect;
    int stuAnsA, stuAnsB, stuAnsC, stuAnsD, ansA, ansB, ansC, ansD;
    string_t ans;
    char var;
    double percentCorrect;

    printf("Enter the number of problems you want to do:\n");
    scanf("%d", &numOfProblems);

    for(i=0; i<numOfProblems; i++){    
        a = abs(getRandInt()); b = getRandInt(); c = abs(getRandInt());
        d = getRandInt(); e = getRandInt();

        switch((1+rand()%5)){
            case 1: var = 'x'; break;
            case 2: var = 'y'; break;
            case 3: var = 'a'; break;
            case 4: var = 'p'; break;
            case 5: var = 'n'; break;
        }
        
        printf("\n\n");
        
        switch(1+rand()%4){
            case 1: a+=2; b = abs(b);
                    printf("#%d: Expand: %s.\n", (i+1), expression1Print(a, b, c, d, var));
                    strcpy(ans, expression1Ans(a, b, c, d, ansA, ansB, ansC, var));
                    ansD = 0;
                    printf("For your answer A%c^3+B%c^2+C%c, enter:\n", var, var, var);
                    printf("   A: "); scanf("%d", &stuAnsA);
                    printf("   B: "); scanf("%d", &stuAnsB);
                    printf("   C: "); scanf("%d", &stuAnsC);
                    stuAnsD = 0; 
                    break;
            case 2: if(a==b) b++;
                    else if (a==-1*b) b--;
                    if(c==d) d++;
                    else if (c==-1*d) d--;
                    printf("#%d: Expand: %s.\n", (i+1), expression2Print(a, b, c, d, var));
                    strcpy(ans, expression2Ans(a, b, c, d, ansA, ansB, ansC, var));
                    ansD = 0;
                    printf("For your answer A%c^2+B%c+C, enter:\n", var, var);
                    printf("   A: "); scanf("%d", &stuAnsA);
                    printf("   B: "); scanf("%d", &stuAnsB);
                    printf("   C: "); scanf("%d", &stuAnsC);
                    stuAnsD = 0;
                    break;   
            case 3: if(a==b) b++;
                    else if (a==-1*b) b--;
                    printf("#%d: Expand: %s.\n", (i+1), expression3Print(a, b, var));
                    strcpy(ans, expression3Ans(a, b, ansA, ansB, ansC, var));
                    ansD = 0;
                    printf("For your answer A%c^2+B%c+C, enter:\n", var, var);
                    printf("   A: "); scanf("%d", &stuAnsA);
                    printf("   B: "); scanf("%d", &stuAnsB);
                    printf("   C: "); scanf("%d", &stuAnsC);
                    stuAnsD = 0;
                    break; 
            case 4: if(a==b) b++;
                    printf("#%d: Expand: %s.\n", (i+1), expression4Print(a, b, c, d, e, var));
                    strcpy(ans, expression4Ans(a, b, c, d, e, ansA, ansB, ansC, ansD, var));
                    printf("For your answer A%c^3+B%c^2+C%c+D, enter:\n", var, var, var);
                    printf("   A: "); scanf("%d", &stuAnsA);
                    printf("   B: "); scanf("%d", &stuAnsB);
                    printf("   C: "); scanf("%d", &stuAnsC);
                    printf("   D: "); scanf("%d", &stuAnsD);
                    break; 
            default: printf("THE PC PICKED THE WRONG EQUATION!!!");
                    exit(1);
        }    
        
        if(ansA==stuAnsA && ansB==stuAnsB && ansC==stuAnsC && ansD==stuAnsD)
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
 * This retruns ax(bx^2+cx+d).
 */
string_t expression1Print(int a, int b, int c, int d, char var){
    string_t ans;
    char str[512], term1[8], term2[8], term3[8], const1[8]; 
    
    
    strcpy(term1, getTermNoOp(a, var));
    strcpy(term2, getTermNoOp(b, var));
    strcpy(term3, getTerm(c, var));
    strcpy(const1, getConstTerm(d));
  
    sprintf(str, "%s(%s^2%s%s)", term1, term2, term3, const1);
    
    ans = str;
    return ans;
}
/*
 * This retruns (ax+b)(cx+d).
 */
string_t expression2Print(int a, int b, int c, int d, char var){
    string_t ans;
    char str[512], term1[8], const1[8], term2[8], const2[8];
    
    strcpy(term1, getTermNoOp(a, var));
    strcpy(const1, getConstTerm(b));
    strcpy(term2, getTermNoOp(c, var));
    strcpy(const2, getConstTerm(d));
        
    sprintf(str, "(%s%s)(%s%s)", term1, const1, term2, const2);
    
    ans = str;
    return ans;
}
/*
 * This retruns (ax+b)^2.
 */
string_t expression3Print(int a, int b, char var){
    string_t ans;
    char str[512], term1[8], const1[8];
    
    strcpy(term1, getTermNoOp(a, var));
    strcpy(const1, getConstTerm(b));
        
    sprintf(str, "(%s%s)^2", term1, const1);
    
    ans = str;
    return ans;
}
/*
 * This retruns (ax+b)(cx^2+dx+e).
 */
string_t expression4Print(int a, int b, int c, int d, int e, char var){
    string_t ans;
    char str[512], term1[8], const1[8], term2[8], term3[8], const2[8];
    
    strcpy(term1, getTermNoOp(a, var));
    strcpy(const1, getConstTerm(b));
    strcpy(term2, getTermNoOp(c, var));
    strcpy(term3, getTerm(d, var));
    strcpy(const2, getConstTerm(e));
        
    sprintf(str, "(%s%s)(%s^2%s%s)", term1, const1, term2, term3, const2);
    
    ans = str;
    return ans;
}


/*
 * For the problem ax(bx^2+cx+d) this probram returns the answer Ax^3+Bx^2+Cx and
 * stores the values A, B, and C.
 */
string_t expression1Ans(int a, int b, int c, int d, int &A,int &B, int &C, char var){
    string_t ans;
    char str[512], term1[8], term2[8], term3[8];
    
    A = a*b;
    B = a*c;
    C = a*d;
    
    strcpy(term1, getTermNoOp(A, var));
    strcpy(term2, getTerm(B, var));
    strcpy(term3, getTerm(C, var));
    
    sprintf(str, "%s^3%s^2%s", term1, term2, term3);
    
    ans = str;
    return ans;
}
/*
 * For the problem (ax+b)(cx+d) this probram returns the answer Ax^2+Bx+C and
 * stores the values A, B, and C.
 */
string_t expression2Ans(int a, int b, int c, int d, int &A,int &B, int &C, char var){
    string_t ans;
    char str[512], term1[8], term2[8], term3[8];
    
    A = a*c;
    B = a*d+b*c;
    C = b*d;
    
    strcpy(term1, getTermNoOp(A, var));
    strcpy(term2, getTerm(B, var));
    strcpy(term3, getConstTerm(C));
    
    sprintf(str, "%s^2%s%s", term1, term2, term3);
    
    ans = str;
    return ans;
}
/*
 * For the problem (ax+b)^2 this probram returns the answer Ax^2+Bx+C and
 * stores the values A, B, and C.
 */
string_t expression3Ans(int a, int b, int &A,int &B, int &C, char var){
    string_t ans;
    char str[512], term1[8], term2[8], const1[8];
    
    A = a*a;
    B = 2*a*b;
    C = b*b;
    
    strcpy(term1, getTermNoOp(A, var));
    strcpy(term2, getTerm(B, var));
    strcpy(const1, getConstTerm(C));
    
    sprintf(str, "%s^2%s%s", term1, term2, const1);
    
    ans = str;
    return ans;
}
/*
 * For the problem (ax+b)(cx^2+dx+e) this probram returns the answer Ax^3+Bx^2+Cx+D and
 * stores the values A, B, C and D.
 */
string_t expression4Ans(int a, int b, int c, int d, int e, int &A,int &B, int &C, int &D, char var){
    string_t ans;
    char str[512], term1[8], term2[8], term3[8], const1[8];
    
    A = a*c;
    B = a*d+b*c;
    C = b*d+a*e;
    D = b*e;
    
    strcpy(term1, getTermNoOp(A, var));
    strcpy(term2, getTerm(B, var));
    strcpy(term3, getTerm(C, var));
    strcpy(const1, getConstTerm(D));
    
    sprintf(str, "%s^3%s^2%s%s", term1, term2, term3, const1);
    
    ans = str;
    return ans;
}

int getRandInt(){
    int sign = (rand()%2==0) ? 1 : -1;
    return sign * (1 + rand()%MAX_COEFFICIENT);
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
