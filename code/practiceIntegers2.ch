/* File Name: practiceIntegers2.ch
 * Version:   2.1
 *
 * This program will generate integer problems for the students to practice.
 *
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

#define MAX_NUMBER 10

#include <string.h>


/*
 * Returns 1 if the student got the problem correct, else 0.
 */
int praticeProblem1(void);
int praticeProblem2(void);

int getRandInt();
string_t getTermNoOp(int val, char var);
string_t getTerm(int val, char var);
string_t getConstTerm(int val);

srand(time(NULL));

int numOfProblems, numCorrect, i;
double percentCorrect;    
    
printf("Enter the number of problems to do: ");
scanf("%d", &numOfProblems);    
printf("\n");

for(i=0; i<numOfProblems; i++){
    printf("#%d: ", i+1);
    
    switch(1 + rand() % 2){
        case 1: numCorrect += praticeProblem1();
                break;
        case 2: numCorrect += praticeProblem2();
                break;
        default: printf("Bad Input ....\n");
                exit(1);
    }
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

int praticeProblem1(){
    int stuAns, ans;
    int a = getRandInt();
    int b = getRandInt();
    int c = getRandInt();
    int d = getRandInt();
    
    printf("(%s)(%s)+(%s)(%s) = ", getConstTerm(a), getConstTerm(b), 
        getConstTerm(c), getConstTerm(d));
    
    scanf("%d", &stuAns);
    ans = a*b+c*d;
    
    if(stuAns == ans){
        printf(" *** Good Job ***\n\n");
        return 1;
    }
    else{
        printf("  Sorry the correct answer is %d.\n\n", ans);
        return 0;
    }
}

int praticeProblem2(){
    int stuAns, ans;
    int a = getRandInt();
    int b = getRandInt();
    int c = getRandInt();
    int d = getRandInt();
    
    printf("(%s)(%s)-(%s)(%s) = ", getConstTerm(a), getConstTerm(b), 
        getConstTerm(c), getConstTerm(d));
    
    scanf("%d", &stuAns);
    ans = a*b-c*d;
    
    if(stuAns == ans){
        printf(" *** Good Job ***\n\n");
        return 1;
    }
    else{
        printf("  Sorry the correct answer is %d.\n\n", ans);
        return 0;
    }
}
int getRandInt(){
    int sign = (rand()%2==0) ? 1 : -1;

    return sign * (1 + rand()%MAX_NUMBER);
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


