/* File:    practiceSolveByFactoring1.ch 
 * Version: 2.1
 *
 * Purpose: This program provides practice solving equations by factoring
 *          involving:
 *              difference of squares
 *              common factor
 *              x^2+bx+c=0
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_COEFFICIENT 8

/*
 * This finds the Greatest Common Factor of 2 numbers (Euclidean Algorithm).
 */
int gcf(int a,int b);

string_t equation1Print(int a, int b, int c);
string_t equation2Print(int a, int b, int c);
string_t equation3Print(int a, int b, int c);

string_t equation1Solution1(int a, int b, int c);
string_t equation1Solution2(int a, int b, int c);
string_t equation2Solution1(int a, int b, int c);
string_t equation2Solution2(int a, int b, int c);
string_t equation3Solution1(int a, int b, int c);
string_t equation3Solution2(int a, int b, int c);

int getRandInt();
int equals(char* frac1, char* frac2);

string_t getTermNoOp(int val, char var);
string_t getTerm(int val, char var);
string_t getConstTerm(int val);

srand(time(NULL));

int i, a, b, c, numOfProblems, numCorrect;
string_t stuAns1, stuAns2, ans1, ans2;
char var;
double percentCorrect;

switch((1+rand()%5)){
    case 1: var = 'x'; break;
    case 2: var = 'y'; break;
    case 3: var = 'a'; break;
    case 4: var = 'p'; break;
    case 5: var = 'n'; break;
}

printf("Enter the number of problems you want to do: ");
scanf("%d", &numOfProblems);

for(i=0; i<numOfProblems; i++){
    a = getRandInt(); b = getRandInt(); c = getRandInt();
            
    printf("\n\n");
    
    switch(1+rand()%3){
        case 1: a = abs(a); b = abs(b);
                while((a==1 && b==1) || (a&b!=0 && b%a!=0) || (a==b)){
                    a = abs(getRandInt());
                    b = abs(getRandInt());
                }
                printf("#%d: %s\n", (i+1), equation1Print(a,b,c));
                strcpy(ans1, equation1Solution1(a,b,c));
                strcpy(ans2, equation1Solution2(a,b,c));
                break;
        case 2: a = abs(a); b = abs(b)/2+3;
                printf("#%d: %s\n", (i+1), equation2Print(a,b,c));
                strcpy(ans1, equation2Solution1(a,b,c));
                strcpy(ans2, equation2Solution2(a,b,c));
                break;   
        case 3: printf("#%d: %s\n", (i+1), equation3Print(a,b,c));
                strcpy(ans1, equation3Solution1(a,b,c));
                strcpy(ans2, equation3Solution2(a,b,c));
                break;
        default: printf("THE PC PICKED THE WRONG EQUATION!!!");
                exit(1);
    }

    printf("Write you 1st answer in (a/b).\n");
    printf("  %c1 = ", var);
    scanf("%s", &stuAns1);
    printf("Write you 2nd answer in (a/b).\n");
    printf("  %c2 = ", var);
    scanf("%s", &stuAns2);

    if((equals(ans1, stuAns1) && equals(ans2, stuAns2)) ||
       (equals(ans1, stuAns2) && equals(ans2, stuAns1)))
    {
        printf("\n*** Great Job ***\n");
        numCorrect++;
    }
    else
        printf("\nSorry, the correct answers are %c1=%s, %c2=%s ...\n", var, ans1, var, ans2);
    
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
 * This prints (ax)^2-b^2=0.
 */
string_t equation1Print(int a, int b, int c){    
    string_t ans;
    char str[512];
    int A, B;
    
    A = a*a;
    B = b*b;
    
    sprintf(str, "%s^2-%d=0", getTermNoOp(A,var), abs(B));
    
    ans = str;
    return ans;
}
/*
 * This prints abx^2+bcx=0.
 */
string_t equation2Print(int a, int b, int c){    
    string_t ans;
    char str[512];
    int A, B;

    A = a*b;
    B = b*c;
    
    sprintf(str, "%s^2%s=0", getTermNoOp(A,var), getTerm(B, var));
    ans = str;
    return ans;
}
/*
 * This prints x^2+Ax+C=0.
 */
string_t equation3Print(int a, int b, int c){   
    string_t ans;
    char str[512];
    int A, B;

    A = b+c;
    B = b*c;

    sprintf(str, "%c^2%s%s=0", var, getTerm(A,var), getConstTerm(B));
    
    ans = str;
    return ans;
}

/*
 * This finds the '1st' root to (ax)^2-b^2=0.
 */
string_t equation1Solution1(int a, int b, int c){
    string_t ans;
    char str[512]="";
    int numerator = -b;
    int denominator = a;
    int GDC = gcf(abs(numerator), abs(denominator));
    numerator /= GDC;
    denominator /= GDC;
    
    if(denominator<0){
        numerator *= -1;
        denominator *= -1;
    }
    if(denominator!=1)
        sprintf(str, "%d/%d", numerator, denominator);
    else
        sprintf(str, "%d", numerator);
    
    ans = str;
    return ans;
}
/*
 * This finds the '2nd' root to (ax)^2-b^2=0.
 */
string_t equation1Solution2(int a, int b, int c){
    string_t ans;
    char str[512]="";
    int numerator = b;
    int denominator = a;
    int GDC = gcf(abs(numerator), abs(denominator));
    numerator /= GDC;
    denominator /= GDC;
    
    if(denominator<0){
        numerator *= -1;
        denominator *= -1;
    }
    if(denominator!=1)
        sprintf(str, "%d/%d", numerator, denominator);
    else
        sprintf(str, "%d", numerator);
    
    ans = str;
    return ans;
}
/*
 * This finds the '1st' root to abx^2+bcx=0.
 */
string_t equation2Solution1(int a, int b, int c){
    string_t ans;
    char str[512]="";
    int numerator = -c;
    int denominator = a;
    int GDC = gcf(abs(numerator), abs(denominator));
    numerator /= GDC;
    denominator /= GDC;
    
    if(denominator<0){
        numerator *= -1;
        denominator *= -1;
    }
    if(denominator!=1)
        sprintf(str, "%d/%d", numerator, denominator);
    else
        sprintf(str, "%d", numerator);
    
    ans = str;
    return ans;
}
/*
 * This finds the '2nd' root to abx^2+bcx=0.
 */
string_t equation2Solution2(int a, int b, int c){
    return "0";
}
/*
 * This finds the '1st' root to x^2+Ax+C=0.
 */
string_t equation3Solution1(int a, int b, int c){
    string_t ans;
    char str[512]="";
    sprintf(str, "%d", -1*b);  
    ans = str;
    return ans;
}
string_t equation3Solution2(int a, int b, int c){
    string_t ans;
    char str[512]="";
    sprintf(str, "%d", -1*c);   
    ans = str;
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

