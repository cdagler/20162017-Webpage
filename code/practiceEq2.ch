/* File:    practiceEq2.ch 
 * Purpose: This program provides pratice equations in one variable.
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_COEFFICIENT 12

/*
 * This finds the Greatest Common Factor of 2 numbers (Euclidean Algorithm).
 */
int gcf(int a,int b);

string_t equation01Print(int A, int B, int C, int D, int E, int F);
string_t equation02Print(int A, int B, int C, int D, int E, int F, int G, int H);
string_t equation03Print(int A, int B, int C, int D, int E, int F);
string_t equation04Print(int A, int B, int C, int D);
string_t equation05Print(int A, int B, int C, int D, int E, int F, int G, int H);

string_t equation01Solve(int A, int B, int C, int D, int E, int F);
string_t equation02Solve(int A, int B, int C, int D, int E, int F, int G, int H);
string_t equation03Solve(int A, int B, int C, int D, int E, int F);
string_t equation04Solve(int A, int B, int C, int D);
string_t equation05Solve(int A, int B, int C, int D, int E, int F, int G, int H);

int getRandInt();
int equals(char* frac1,char* frac2);

srand(time(NULL));

int i, a, b, c, d, e, f, g, h, numOfProblems, numCorrect;
char stuAns[32]="", ans[32]="";
double percentCorrect;

printf("Enter the number of problems you want to do:\n");
scanf("%d", &numOfProblems);

for(i=0; i<numOfProblems; i++){
    a = getRandInt(); b = getRandInt(); c = getRandInt(); d = getRandInt();
    e = getRandInt(); f = getRandInt(); g = getRandInt(); h = getRandInt();
            
    printf("\n\n");
    
    switch(1+rand()%5){
        case 1: printf("#%d: Solve: %s\n", (i+1), equation01Print(a,b,c,d,e,f));
                strcpy(ans, equation01Solve(a,b,c,d,e,f));
                break;
        case 2: printf("#%d: Solve: %s\n", (i+1), equation02Print(a,b,c,d,e,f,g,h));
                strcpy(ans, equation02Solve(a,b,c,d,e,f,g,h));
                break;     
        case 3: printf("#%d: Solve: %s\n", (i+1), equation03Print(a,b,c,d,e,f));
                strcpy(ans, equation03Solve(a,b,c,d,e,f));
                break;
        case 4: a = abs(a); b=abs(b)+1;
                if(gcf(a,b)!=1) a+=1;
                printf("#%d: Solve: %s\n", (i+1), equation04Print(a,b,c,d));
                strcpy(ans, equation04Solve(a,b,c,d));
                break;
        case 5: switch(rand()%5){
                    case 0: e=2,f=6,g=12,h=3; break;
                    case 1: e=5,f=10,g=2,h=5; break;  
                    case 2: e=7,f=2,g=14,h=7; break;  
                    case 3: e=3,f=12,g=4,h=4; break;  
                    case 4: e=5,f=3,g=15,h=3; break;   
                }
                a = abs(a); b=abs(b); c=abs(c); d=abs(d);
    
                if(gcf(a,e)!=1) a+=1;
                if(gcf(b,f)!=1) b+=1;
                if(gcf(c,g)!=1) c+=1;
                if(gcf(d,h)!=1) d+=1;
                    
                printf("#%d: Solve: %s\n", (i+1), equation05Print(a, b, c, d, e, f, g, h));
                strcpy(ans, equation05Solve(a, b, c, d, e, f, g, h));
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
 * This prints A+B(Cx+D)=Ex+G
 */
string_t equation01Print(int A, int B, int C, int D, int E, int F){
    char ans[64]="";
    char op1[4]="", op2[4]="", op3[4]=""; 
    
    if(B>0) strcpy(op1, "+");
    if(D>0) strcpy(op2, "+");
    if(F>0) strcpy(op3, "+");
        
    sprintf(ans, "%d%s%d(%dx%s%d)=%dx%s%d",A,op1,B,C,op2,D,E,op3,F);
    return ans;
}
/*
 * This prints A(Bx+C)+D(Ex+F)=Gx+H
 */
string_t equation02Print(int A, int B, int C, int D, int E, int F, int G, int H){
    char ans[64]="";
    char op1[4]="", op2[4]="", op3[4]="", op4[4]=""; 
    
    if(C>0) strcpy(op1, "+");
    if(D>0) strcpy(op2, "+");
    if(F>0) strcpy(op3, "+");        
    if(H>0) strcpy(op4, "+");
        
    sprintf(ans, "%d(%dx%s%d)%s%d(%dx%s%d)=%dx%s%d",A,B,op1,C,op2,D,E,op3,F,G,op4,H);
    return ans;    
}


/*
 * This prints Ax+B+C(Dx+E)=F
 */
string_t equation03Print(int A, int B, int C, int D, int E, int F){
    char ans[64]="";
    char op1[4]="", op2[4]="", op3[4]=""; 
    
    if(B>0) strcpy(op1, "+");
    if(C>0) strcpy(op2, "+");
    if(E>0) strcpy(op3, "+");        
        
    sprintf(ans, "%dx%s%d%s%d(%dx%s%d)=%d",A,op1,B,op2,C,D,op3,E,F);
    return ans;    
}

/*           
 * This prints (A/B)x + C = D
 */
string_t equation04Print(int A, int B, int C, int D){
    char ans[64]="";
    char op1[4]="";

    if(C>0) strcpy(op1, "+");

    sprintf(ans, "(%d/%d)x%s%d=%d",A,B,op1,C,D);
    return ans;
}

/*           
 * This prints (A/E)x + (B/F) = (C/G)x + (D/H)
 */
string_t equation05Print(int A, int B, int C, int D, int E, int F, int G, int H){
    char ans[64]="";
    
    sprintf(ans, "(%d/%d)x+(%d/%d)=(%d/%d)x+(%d/%d)",A,E,B,F,C,G,D,H);
    return ans;
}

/*
 * This solves A+B(Cx+D)=Ex+G
 */
string_t equation01Solve(int A, int B, int C, int D, int E, int F){
    char ans[32]="";
    int numerator = -1 * (F-B*D-A);
    int denominator = (E-B*C);
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
 * This solves A(Bx+C)+D(Ex+F)=Gx+H
 */
string_t equation02Solve(int A, int B, int C, int D, int E, int F, int G, int H){
    char ans[32]="";
    int numerator = H-D*F-A*C;
    int denominator = D*E-G+A*B;
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
 * This solves Ax+B+C(Dx+E)=F
 */
string_t equation03Solve(int A, int B, int C, int D, int E, int F){
    char ans[32]="";
    int numerator = -1 * (C*E-F+B);
    int denominator = C*D+A;
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
 * This solves (A/B)x + C = D
 */
string_t equation04Solve(int A, int B, int C, int D)
{
    char ans[32]="";
    int numerator = B*D-B*C;
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
 * This solves (A/E)x + (B/F) = (C/G)x + (D/H)
 */
string_t equation05Solve(int A, int B, int C, int D, int E, int F, int G, int H)
{
    char ans[32]="";
    int numerator = (B*G*H-D*F*G)*E;
    int denominator = C*F*H*E-A*F*G*H;
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
