/* File:    practiceSystemsNumeric.ch 
 * Version: 2.1
 *
 * Purpose: This program provides practice solving systems of equations
 *          in different forms. The students are to write their answer 
 *          to 2 decimal places.
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_COEFFICIENT 8

string_t system1Print(int a, int b, int c, int d, int e, int f);
string_t system2Print(int a, int b, int c, int d, int e, int f);
string_t system3Print(int a, int b, int c, int d, int e);
string_t system4Print(int a, int b, int c, int d, int e);

double system1XSolution(int a, int b, int c, int d, int e, int f);
double system1YSolution(int a, int b, int c, int d, int e, int f);
double system2XSolution(int a, int b, int c, int d, int e, int f);
double system2YSolution(int a, int b, int c, int d, int e, int f);
double system3XSolution(int a, int b, int c, int d, int e);
double system3YSolution(int a, int b, int c, int d, int e);
double system4XSolution(int a, int b, int c, int d, int e);
double system4YSolution(int a, int b, int c, int d, int e);

int getRandInt();
int equals(double val1, double val2);
/*
 * This finds the Greatest Common Factor of 2 numbers (Euclidean Algorithm).
 */
int gcf(int a,int b);

srand(time(NULL));

int i, a, b, c, d, e, f, numOfProblems, numCorrect;
double stuAnsX, stuAnsY, ansX, ansY;
double percentCorrect;

printf("Enter the number of problems you want to do: ");
scanf("%d", &numOfProblems);

for(i=0; i<numOfProblems; i++){
    a = getRandInt(); b = getRandInt(); c = getRandInt();
    d = getRandInt(); e = getRandInt(); f = getRandInt();
                        
    printf("\n\n");
    
    switch(1+rand()%4){
        case 1: a = abs(a); d = abs(d);
                printf("#%d: Solve:\n", (i+1));
                printf("%s\n", system1Print(a,b,c,d,e,f));
                ansX = system1XSolution(a,b,c,d,e,f);
                ansY = system1YSolution(a,b,c,d,e,f);
                break;
        case 2: b = abs(b); e = abs(e);
                while(abs(a)%abs(b)==0 || abs(b)%abs(a)==0
                || abs(d)%abs(e)==0 || abs(e)%abs(d)==0){
                    a = getRandInt(); b = abs(getRandInt());
                    d = getRandInt(); e = abs(getRandInt());
                } 
                printf("#%d: Solve:\n", (i+1));
                printf("%s\n", system2Print(a,b,c,d,e,f));
                ansX = system2XSolution(a,b,c,d,e,f);
                ansY = system2YSolution(a,b,c,d,e,f);
                break;   
        case 3: c = abs(c);
                if(a*c+d==0) a++; //Avoiding No Solutions.
                printf("#%d: Solve:\n", (i+1));
                printf("%s\n", system3Print(a,b,c,d,e));
                ansX = system3XSolution(a,b,c,d,e);
                ansY = system3YSolution(a,b,c,d,e);
                break;
        case 4: a = abs(a);
                if(a*d+b==0) d++; //Avoiding No Solutions.
                printf("#%d: Solve:\n", (i+1));
                printf("%s\n", system4Print(a,b,c,d,e));
                ansX = system4XSolution(a,b,c,d,e);
                ansY = system4YSolution(a,b,c,d,e);
                break;
        default: printf("THE PC PICKED THE WRONG EQUATION!!!");
                exit(1);
    }
    printf("What is the x-val (2 decimal places): ");
    scanf("%lf", &stuAnsX);
    printf("What is the y-val (2 decimal places): ");
    scanf("%lf", &stuAnsY);

    printf("%.2lf = %.2lf   and   %.2lf = %.2lf", ansX, stuAnsX, ansY, stuAnsY);
    
    if(equals(ansX, stuAnsX) && equals(ansY, stuAnsY))
    {
        printf("\n*** Great Job ***\n");
        numCorrect++;
    }
    else
        printf("\nSorry, the correct answers is (%.2lf,%.2lf) ...\n", ansX, ansY);
    
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
string_t system1Print(int a, int b, int c, int d, int e, int f){
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
     * Making sure everything lines up and that no coefficients
     * of '1' showing.
     */
    if(a==1) 
        sprintf(Ax, "  x");
    else if(a==-1) 
        sprintf(Ax, " -x");
    else if(a>0) 
        sprintf(Ax, " %dx", a);
    else 
        sprintf(Ax, "%dx", a);
    if(b==1) 
        sprintf(By, "+ y");
    else if(b==-1) 
        sprintf(By, "- y");
    else if(b>0)
        sprintf(By, "+%dy", b);
    else 
        sprintf(By, "%dy", b);
    if(d==1) 
        sprintf(Dx, "  x");
    else if(d==-1) 
        sprintf(Dx, " -x");
    else if(d>0) 
        sprintf(Dx, " %dx", d);
    else 
        sprintf(Dx, "%dx", d);
    if(e==1) 
        sprintf(Ey, "+ y");
    else if(e==-1) 
        sprintf(Ey, "- y");
    else if(e>0)
        sprintf(Ey, "+%dy", e);
    else 
        sprintf(Ey, "%dy", e);
    
    sprintf(str, "\t%s%s=%d\n\t%s%s=%d", Ax, By, c, Dx, Ey, f);
    ans = str;
    return ans;
}
/* 
 * This returns the system.
 *  y=(a/b)x+c
 *  y=(d/e)x+f
 */
string_t system2Print(int a, int b, int c, int d, int e, int f){
    /*
     * Making sure there are no fractions with a denominator = 1.
     */
    char str[512], m1[8], m2[8], op1[8]="", op2[8]=""; 
	string_t ans;

    int GCF = gcf(abs(a),abs(b));
    a /= GCF; b /= GCF;
    GCF = gcf(abs(d),abs(e));
    d /= GCF; e /= GCF;
    
    if(c>0) sprintf(op1, "+");
    if(f>0) sprintf(op2, "+");
    
    if(b!=1) 
        sprintf(m1, "(%d/%d)", a, b);
    else 
        sprintf(m1, "%d", a);
    if(e!=1) 
        sprintf(m2, "(%d/%d)", d, e);
    else 
        sprintf(m2, "%d", d);
    
    sprintf(str, "\ty=%sx%s%d\n\ty=%sx%s%d", m1, op1, c, m2, op2, f);
    
	ans = str;
    return ans;
}
/* 
 * This returns the system.
 *  x=ay+b
 *  cx+dy=e
 */
string_t system3Print(int a, int b, int c, int d, int e){
    /*
     * Making sure there are no coefficients of '1' showing.
     */
    char str[512], Ay[8], B[8], Cx[8], Dy[8];
	string_t ans;
    
    /*
     * Making sure there is no common factor.
     */
    int GCF = gcf(abs(c),abs(d)); GCF = gcf(GCF,abs(e));
    c /= GCF; d /= GCF; e /= GCF;
    
    if(a==1)
        sprintf(Ay, "y");
    else if(a==-1)
        sprintf(Ay, "-y");
    else 
        sprintf(Ay, "%dy", a);
    if(b>0)
        sprintf(B, "+%d", b);
    else
        sprintf(B, "%d", b);
    if(c==1)
        sprintf(Cx, "x");
    else if(c==-1)
        sprintf(Cx, "-x");
    else 
        sprintf(Cx, "%dx", c);
    if(d==1)
        sprintf(Dy, "+y");
    else if(d==-1)
        sprintf(Dy, "-y");
    else if(d>0)
        sprintf(Dy, "+%dy", d);
    else 
        sprintf(Dy, "%dy", d);
    
    switch(1+rand()%2){
        case 1: sprintf(str, "\tx=%s%s\n\t%s%s=%d", Ay, B, Cx, Dy, e);
                break;
        case 2: sprintf(str, "\t%s%s=%d\n\tx=%s%s",  Cx, Dy, e, Ay, B);
    }
	ans = str;
    return ans;
}
/* 
 * This returns the system.
 *  ax+by=c
 *  y=dx+e
 */
string_t system4Print(int a, int b, int c, int d, int e){
    /*
     * Making sure there are no coefficients of '1' showing.
     */
    char str[512], Ax[8], By[8], Dx[8], E[8]; 
	string_t ans;

    /*
     * Making sure there is no common factor.
     */
    int GCF = gcf(abs(a),abs(b)); GCF = gcf(GCF,abs(c));
    a /= GCF; b /= GCF; c /= GCF;
    
    if(a==1)
        sprintf(Ax, "x");
    else if(a==-1)
        sprintf(Ax, "-x");
    else 
        sprintf(Ax, "%dx", a);
    if(b==1)
        sprintf(By, "+y");
    else if(b==-1)
        sprintf(By, "-y");
    else if(b>0)
        sprintf(By, "+%dy", b);
    else
        sprintf(By, "%dy", b);        
    if(d==1)
        sprintf(Dx, "x");
    else if(d==-1)
        sprintf(Dx, "-x");
    else 
        sprintf(Dx, "%dx", d);
    if(e>0)
        sprintf(E, "+%d", e);
    else
        sprintf(E, "%d", e);
    
    switch(1+rand()%2){
        case 1: sprintf(str, "\t%s%s=%d\n\ty=%s%s", Ax, By, c, Dx, E);
                break;
        case 2: sprintf(str, "\ty=%s%s\n\t%s%s=%d", Dx, E, Ax, By, c);
    }
	
	ans = str;
    return ans;
}

/*
 * This returns the x-value (rounded to 2 decimal points) of the 
 * system:
 *  ax+by=c
 *  dx+ey=f
 */
double system1XSolution(int a, int b, int c, int d, int e, int f){
    return ((1.0*f)/e-(1.0*c)/b)/((1.0*d)/e-(1.0*a)/b);
}
/*
 * This returns the y-value (rounded to 2 decimal points) of the 
 * system:
 *  ax+by=c
 *  dx+ey=f
 */
double system1YSolution(int a, int b, int c, int d, int e, int f){
    return (-1.0*a)/b*system1XSolution(a,b,c,d,e,f)+(1.0*c)/b;
}
/* 
 * This returns the x-value (rounded to 2 decimal points) of the 
 * system:
 *  y=(a/b)x+c
 *  y=(d/e)x+f
 */
double system2XSolution(int a, int b, int c, int d, int e, int f){
    return ((1.0*f)-(1.0*c))/((1.0*a)/b-(1.0*d/e));
}
/* 
 * This returns the y-value (rounded to 2 decimal points) of the 
 * system:
 *  y=(a/b)x+c
 *  y=(d/e)x+f
 */
double system2YSolution(int a, int b, int c, int d, int e, int f){
    return (1.0*a)/b*system2XSolution(a,b,c,d,e,f)+c;
}
/* 
 * This returns the x-value (rounded to 2 decimal points) of the 
 * system:
 *  x=ay+b
 *  cx+dy=e
 */
double system3XSolution(int a, int b, int c, int d, int e){
    return a*system3YSolution(a,b,c,d,e)+b;
}
/* 
 * This returns the y-value (rounded to 2 decimal points) of the 
 * system:
 *  x=ay+b
 *  cx+dy=e
 */
double system3YSolution(int a, int b, int c, int d, int e){
    return (1.0*e-1.0*b*c)/(1.0*d+1.0*a*c);
}
/* 
 * This returns the x-value (rounded to 2 decimal points) of the 
 * system:
 *  ax+by=c
 *  y=dx+e
 */
double system4XSolution(int a, int b, int c, int d, int e){
    return (1.0*c-1.0*b*e)/(1.0*b*d+a);
}
/* 
 * This returns the y-value (rounded to 2 decimal points) of the 
 * system:
 *  ax+by=c
 *  y=dx+e
 */
double system4YSolution(int a, int b, int c, int d, int e){
    return d*system4XSolution(a,b,c,d,e)+e;
}

int getRandInt(){
    int sign = (rand()%2==0) ? 1 : -1;

    return sign * (1 + rand()%MAX_COEFFICIENT);
}


int equals(double val1, double val2){
    if(abs(val1-val2)<0.05)
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

