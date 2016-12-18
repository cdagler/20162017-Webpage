/* File:    praticeSystems1.ch 
 * Version: 2.1
 *
 * Purpose: This program provides practice solving a system in standard
 * form where the answers are integers.
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_COEFFICIENT 8

void problemPrint();

string_t getTermNoOp(int val, char var);
string_t getTerm(int val, char var);
string_t getConstTerm(int val);

static int A, B, C, D, E, F, ans1, ans2;
static char var1, var2;

/*
 * This finds the Greatest Common Factor of 2 numbers (Euclidean Algorithm).
 */
int gcf(int a,int b);

int main(){
    int i, numOfProblems, numCorrect;
    int stuAns1, stuAns2;
    double percentCorrect;
        
    printf("Enter the number of problems you want to do: ");
    scanf("%d", &numOfProblems);

    printf("\n\n");
    
    for(i=0; i<numOfProblems; i++){   
        printf("Solve:\n");
        problemPrint();
        printf("Enter your answer: (%c,%c)\n", var1, var2);
        printf("  %c = ", var1);
        scanf("%d", &stuAns1);
        printf("  %c = ", var2);
        scanf("%d", &stuAns2);
    
        if(ans1 ==  stuAns1 && ans2 ==  stuAns2){
            printf("\n*** Great Job ***\n\n\n");
            numCorrect++;
        }
        else{
            printf("\nSorry, the correct answers is (%d,%d) ...\n\n\n", ans1, ans2);
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
 * This prints out the question:
 *      Ax+By=C
 *      Dx+Ey=F
 * and finds the answer.
 */
void problemPrint(){
    char Ax[8], By[8], Dx[8], Ey[8]; //Making sure not to print a '1'.
    
    switch(randint(1,5)){
        case 1: var1 = 'x'; var2 = 'y'; break;
        case 2: var1 = 'a'; var2 = 'b'; break;
        case 3: var1 = 'm'; var2 = 'n'; break;
        case 4: var1 = 'u'; var2 = 'v'; break;
        case 5: var1 = 'p'; var2 = 'q';
    }
    
    A=D; B=E;
    while(A==D && B==E){
        A = abs(getRandInt());  B = getRandInt();
        D = getRandInt(); E = getRandInt();
        ans1 = getRandInt(); ans2 = getRandInt();
        
        C = A * ans1 + B * ans2;
        F = D * ans1 + E * ans2;
        
        /*
         * Making sure there is no common factor.
         */
        int GCF = gcf(abs(A),abs(B)); GCF = gcf(GCF,abs(C));
        A /= GCF; B /= GCF; C /= GCF;
        GCF = gcf(abs(D),abs(E)); GCF = gcf(GCF,abs(F));
        D /= GCF; E /= GCF; F /= GCF;
    }
    
    /*
     * Makeing sure everything lines up and that no coefficients
     * of '1' showing.
     */
    if(A==1) 
        sprintf(Ax, "  %c", var1);
    else if(A==-1) 
        sprintf(Ax, " -%c", var1);
    else if(A>0) 
        sprintf(Ax, " %d%c", A, var1);
    else 
        sprintf(Ax, "%d%c", A, var1);
    if(B==1) 
        sprintf(By, "+ %c", var2);
    else if(B==-1) 
        sprintf(By, "- %c", var2);
    else if(B>0)
        sprintf(By, "+%d%c", B, var2);
    else 
        sprintf(By, "%d%c", B, var2);
    if(D==1) 
        sprintf(Dx, "  %c", var1);
    else if(D==-1) 
        sprintf(Dx, " -%c", var1);
    else if(D>0) 
        sprintf(Dx, " %d%c", D, var1);
    else 
        sprintf(Dx, "%d%c", D, var1);
    if(E==1) 
        sprintf(Ey, "+ %c", var2);
    else if(E==-1) 
        sprintf(Ey, "- %c", var2);
    else if(E>0)
        sprintf(Ey, "+%d%c", E, var2);
    else 
        sprintf(Ey, "%d%c", E, var2);
    
    printf("\n\t%s%s=%d\n\t%s%s=%d\n\n", Ax, By, C, Dx, Ey, F);
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

