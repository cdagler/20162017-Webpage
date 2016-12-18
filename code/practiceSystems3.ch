/* File:    practiceSystems3.ch 
 * Version: 2.1
 *
 * Purpose: This program provides practice solving systems of equations
 *          in the form:
 *
 *              Ax+By=C
 *              Dx+Ey=F
 *
 *          where:
 *          - A, B, D, or E are 1 
 *          - A+D=0 or B+E=0
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_COEFFICIENT 8


string_t systemPrint(int a, int b, int c, int d, int e, int f, char* var1, char* var2);

string_t systemXSolution(int a, int b, int c, int d, int e, int f);
string_t systemYSolution(int a, int b, int c, int d, int e, int f);



int getRandInt();
string_t simplifyFraction(int a, int b);
int equals(char* val1, char* val2);
/*
 * This finds the Greatest Common Factor of 2 numbers (Euclidean Algorithm).
 */
int gcf(int a,int b);

srand(time(NULL));

int i, a, b, c, d, e, f, numOfProblems, numCorrect;
string_t stuAnsX, stuAnsY, ansX, ansY, var1, var2;
double percentCorrect;

printf("Enter the number of problems you want to do:\n");
scanf("%d", &numOfProblems);

for(i=0; i<numOfProblems; i++){
    a = abs(getRandInt()); b = getRandInt(); c = getRandInt();
    d = abs(getRandInt()); e = getRandInt(); f = getRandInt();
                        
    switch(1+rand()%6){
        case 1: d = -1 * a; break;
        case 2: e = -1 * b; break;   
        case 3: a=1; break;
        case 4: b=1; break;
        case 5: d=1; break;
        case 6: d=1; break;
        default: printf("THE PC PICKED THE WRONG EQUATION!!!");
                exit(1);
    }

    switch(1+rand()%4){
        case 1: strcpy(var1, "x"); strcpy(var2, "y"); break;
        case 2: strcpy(var1, "a"); strcpy(var2, "b"); break;   
        case 3: strcpy(var1, "m"); strcpy(var2, "n"); break;
        case 4: strcpy(var1, "u"); strcpy(var2, "v"); break;
        default: printf("THE PC PICKED THE WRONG EQUATION!!!");
                exit(1);
    }
    
    
    printf("\n\n");
    printf("#%d: Solve:\n", (i+1));
    printf("%s\n", systemPrint(a,b,c,d,e,f, var1, var2));
    strcpy(ansX, systemXSolution(a,b,c,d,e,f));
    strcpy(ansY, systemYSolution(a,b,c,d,e,f));
    printf("Enter your answers:\n");
    printf("  %s = ", var1);
    scanf("%s", &stuAnsX);
    printf("  %s = ", var2);
    scanf("%s", &stuAnsY);

    if(equals(ansX, stuAnsX) && equals(ansY, stuAnsY))
    {
        printf("\n*** Great Job ***\n");
        numCorrect++;
    }
    else
        printf("\nSorry, the correct answers is (%s,%s) ...\n", ansX, ansY);
    
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
 * This returns the system.
 *  ax+by=c
 *  dx+ey=f
 */
string_t systemPrint(int a, int b, int c, int d, int e, int f, char* var1, char* var2){
    string_t ans;
    char str[512], Ax[8], By[8], Dx[8], Ey[8]; //Making sure not to print a '1'.

    /*
     * Making sure there is no common factor.
     */
    int GCF = gcf(abs(a),abs(b)); GCF = gcf(GCF,abs(c));
    a /= GCF; b /= GCF; c /= GCF;
    GCF = gcf(abs(d),abs(e)); GCF = gcf(GCF,abs(f));
    d /= GCF; e /= GCF; f /= GCF;
    
    /*
     * Makeing sure everything lines up and that no coefficients
     * of '1' showing.
     */
    if(a==1) 
        sprintf(Ax, "  %s", var1);
    else if(a==-1) 
        sprintf(Ax, " -%s", var1);
    else if(a>0) 
        sprintf(Ax, " %d%s", a, var1);
    else 
        sprintf(Ax, "%d%s", a, var1);
    if(b==1) 
        sprintf(By, "+ %s", var2);
    else if(b==-1) 
        sprintf(By, "- %s", var2);
    else if(b>0)
        sprintf(By, "+%d%s", b, var2);
    else 
        sprintf(By, "%d%s", b, var2);
    if(d==1) 
        sprintf(Dx, "  %s", var1);
    else if(d==-1) 
        sprintf(Dx, " -%s", var1);
    else if(d>0) 
        sprintf(Dx, " %d%s", d, var1);
    else 
        sprintf(Dx, "%d%s", d, var1);
    if(e==1) 
        sprintf(Ey, "+ %s", var2);
    else if(e==-1) 
        sprintf(Ey, "- %s", var2);
    else if(e>0)
        sprintf(Ey, "+%d%s", e, var2);
    else 
        sprintf(Ey, "%d%s", e, var2);
    
    sprintf(str, "\t%s%s=%d\n\t%s%s=%d", Ax, By, c, Dx, Ey, f);
    
    ans = str;
    return ans;
}
/*
 * This returns the x-value of the system:
 *  ax+by=c
 *  dx+ey=f
 */
string_t systemXSolution(int a, int b, int c, int d, int e, int f){
    return simplifyFraction(c*e-b*f, a*e-b*d);
}
/*
 * This returns the y-value of the system:
 *  ax+by=c
 *  dx+ey=f
 */
string_t systemYSolution(int a, int b, int c, int d, int e, int f){
    return simplifyFraction(a*f-c*d, a*e-b*d);
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

int getRandInt(){
    int sign = (rand()%2==0) ? 1 : -1;

    return sign * (1 + rand()%MAX_COEFFICIENT);
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

