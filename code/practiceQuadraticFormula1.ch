/* File:    practiceQuadraticFormula1.ch 
 * Version: 2.1
 *
 * Purpose: This program provides practice solving ax^2+bx+c=0 by using
 *          the quadratic forumula. The solution is of the form:
 *
 *              x = (A +- B * sqrt(C)) / D
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#include <math.h>

#define MAX_COEFFICIENT 8

int getRandInt();
int gcf(int a,int b);

string_t getTermNoOp(int val, char var);
string_t getTerm(int val, char var);
string_t getConstTerm(int val);

int isPostivePerfectSquare(int n);
int doesDiscriminantSimplify(int a, int b, int c, int &ansA, int &ansB, int &ansC, int &ansD);
void simpliyDiscriminant(int a, int b, int c, int &ansA, int &ansB, int &ansC, int &ansD);

void printQuestion(int questionNumber, int a, int b, int c, char var);
void solveQuestion(int a, int b, int c, int &ansA, int &ansB, int &ansC, int &ansD);
void getStudentAnswer(int ansA, int ansB, int ansC, int ansD, int &stuA, int &stuB, int &stuC, int &stuD, char var);
string_t getAnswer(char var, int ansA, int ansB, int ansC, int ansD);

int main(){
    int a, b, c, answerA, answerB, answerC, answerD;
    int studentA, studentB, studentC, studentD;
    int discriminant, GCF, numOfProblems, i, numCorrect;
    double percentCorrect;
    char var;
    
    srand(time(NULL));
        
    printf("Enter the number of problems you want to do: ");
    scanf("%d", &numOfProblems);

    for(i=0; i<numOfProblems; i++){
        /*
         * Making sure the answer is not complex number.
         */
        if(rand()%2==0){
            do{
                a = abs(getRandInt()); b = getRandInt(); c = getRandInt();
                discriminant = b*b-4.0*a*c;
                GCF = gcf(abs(a),abs(b)); GCF = gcf(GCF, abs(c));
                
            }while(isPostivePerfectSquare(discriminant) || GCF!=1 || discriminant<0);
        }
        /*
         * Making sure the discriminant simplifies.
         */
       else{   
            do{
                a = abs(getRandInt()); b = getRandInt(); c = getRandInt();
                discriminant = b*b-4.0*a*c;
                GCF = gcf(abs(a),abs(b)); GCF = gcf(GCF, abs(c));
                
            }while(!doesDiscriminantSimplify(a,b,c, answerA, answerB, answerC, answerD) || GCF!=1
                || discriminant<0 || isPostivePerfectSquare(discriminant));
        }
            
        switch((1+rand()%5)){
            case 1: var = 'x'; break;
            case 2: var = 'y'; break;
            case 3: var = 'w'; break;
            case 4: var = 'p'; break;
            case 5: var = 'n'; break;
        }
    
        printQuestion(i+1,a,b,c, var);
        solveQuestion(a, b, c, answerA, answerB, answerC, answerD);
        
        getStudentAnswer(answerA, answerB, answerC, answerD, studentA, studentB, studentC, studentD, var);
        
        if(answerA == studentA && answerB == studentB && answerC == studentC && answerD == studentD){
            printf("*** Good Job ***\n");
            numCorrect++;
        }
        else{
            printf("Sorry the correct answer is %s\n", getAnswer(var, answerA, answerB, answerC, answerD));
        }
        sleep(4);
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

void printQuestion(int questionNumber, int a, int b, int c, char var){
    printf("\n\n");
    printf("#%d) Solve: %s^2%s%s=0. ", questionNumber, getTermNoOp(a,var), getTerm(b,var), getConstTerm(c));
    printf("Write your answer in the form:\n\n");
}


/* This taks a, b, and c in the equation ax^2+bx+c=0 and stors the answer
 *    x = (A +- B * sqrt(C)) / D
 * into A, B, C, D.
 */
void solveQuestion(int a, int b, int c, int &ansA, int &ansB, int &ansC, int &ansD){
    simpliyDiscriminant(a, b, c, ansA, ansB, ansC, ansD);
    
    ansA = -1*b;
    ansD = 2*a;

    int GCF = gcf(abs(ansA),ansD); 
    GCF = gcf(GCF,abs(ansB));
    ansA /= GCF;
    ansB /= GCF;
    ansD /=GCF;
}

void getStudentAnswer(int ansA, int ansB, int ansC, int ansD, int &stuA, int &stuB, int &stuC, int &stuD, char var){
    if(abs(ansB)!=1 && ansD!=1){
        printf("     %c=(A+-B*sqrt(C))/D\n\n", var);    
        printf("  Enter A: "); scanf("%d", &stuA);
        printf("  Enter B: "); scanf("%d", &stuB);        
        printf("  Enter C: "); scanf("%d", &stuC);     
        printf("  Enter D: "); scanf("%d", &stuD);
    }
    else if(abs(ansB)==1 && ansD!=1){
        printf("     %c=(A+-sqrt(C))/D\n\n", var);    
        printf("  Enter A: "); scanf("%d", &stuA);
        stuB=ansB;        
        printf("  Enter C: "); scanf("%d", &stuC);     
        printf("  Enter D: "); scanf("%d", &stuD);
    }
    else if(abs(ansB)!=1 && ansD==1){
        printf("     %c=(A+-B*sqrt(C))\n\n", var);    
        printf("  Enter A: "); scanf("%d", &stuA);
        printf("  Enter B: "); scanf("%d", &stuB);        
        printf("  Enter C: "); scanf("%d", &stuC);     
        stuD=1;
    }
    else{
        printf("     %c=A+-sqrt(C)\n\n", var);    
        printf("  Enter A: "); scanf("%d", &stuA);
        stuB=ansB;        
        printf("  Enter C: "); scanf("%d", &stuC);     
        stuD=1;
    }
    printf("\n");
}

/*
 * This returns the answer in the format:
 *       x = (A +- B * sqrt(C)) / D
 */
string_t getAnswer(char var, int ansA, int ansB, int ansC, int ansD){
    string_t ans;
    char str[512];
    
    if(abs(ansB)!=1 && ansD!=1){
        sprintf(str, "%c=(%d+-%d*sqrt(%d))/%d", var, ansA, ansB, ansC, ansD);    
    }
    else if(abs(ansB)==1 && ansD!=1){
        sprintf(str, "%c=(%d+-sqrt(%d))/%d", var, ansA, ansC, ansD);
    }
    else if(abs(ansB)!=1 && ansD==1){
        sprintf(str, "%c=(%d+-&d*sqrt(%d))", var, ansA, ansB, ansC);
    }
    else{
        sprintf(str, "%c=(%d+-sqrt(%d))", var, ansA, ansC);
    }
    
    ans = str;
    return ans;
}

/* Returns:
 *   0 if n<=0 or sqrt(n) is not an integer. 
 *   1 otherwise.
 */
int isPostivePerfectSquare(int n){
    if(n<=0)
        return 0;
    
    double x = sqrt(n);
    int wholePart = x;  
    
    if(x-wholePart<0.0001)
        return 1;
    else
        return 0;
}

/* Returns:
 *   0 if the discriminant is negative or does have a perfect square factor. 
 *   1 otherwise.
 */
int doesDiscriminantSimplify(int a, int b, int c, int &ansA, int &ansB, int &ansC, int &ansD){
    int discriminant = b*b-4.0*a*c;
    
    if(discriminant<0)
        return 0;
    
    simpliyDiscriminant(a, b, c, ansA, ansB, ansC, ansD);  
    
    if(ansB==1)
        return 0;
    else 
        return 1;
}

void simpliyDiscriminant(int a, int b, int c, int &ansA, int &ansB, int &ansC, int &ansD){
    int discriminant = b*b-4.0*a*c;
    ansB = 1;
    ansC = discriminant;
    int i;
    for(i=discriminant; i>1; i--){
        if(discriminant%(i*i)==0){
            ansB = i;
            ansC = discriminant/(ansB*ansB);
            break;
        }
    } 
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


