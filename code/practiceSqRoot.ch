/* File:    practiceSqroot.ch 
 * Purpose: This program provides pratice for square roots.
 * Author:  Clay Dagler (Clayton-Dagler@scusd.edu)
 */

/*
 * Returns a random inside number of a square root.
 */
int getRandSquareRoot();
/*
 * Simplifies sqrt(n) to A sqrt(B) and stores in A and B. 
 */
void simplySquareRoot(int n, int &A, int &B);

srand(time(NULL));

int i=0, x=0, numOfProblems=0, numCorrect=0, A=0, B=0, ansA=0, ansB=0;
double percentCorrect;

printf("Enter the number of problems you want to practice:\n");
scanf("%d", &numOfProblems);

for(i=0; i<numOfProblems; i++){
    x = getRandSquareRoot();
    printf("Simplify sqrt(%d) = A*sqrt(B)\n", x);
    printf("  A: "); scanf("%d", &A);
    printf("  B: "); scanf("%d", &B);
    
    simplySquareRoot(x, ansA, ansB);
    
    if(A == ansA && B == ansB){
        printf("\nGreat Job, sqrt(%d)=%d*sqrt(%d)\n\n", x, ansA, ansB);
        numCorrect++;
    }
    else{
        printf("\nNice try, but sqrt(%d)=%d*sqrt(%d)\n\n", x, ansA, ansB);
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

/*
 * Returns a random inside number of a square root.
 */
int getRandSquareRoot(){
    int perfectSquares[] = {4, 9, 16, 25, 36, 49, 81, 100, 121};
    int notPerfectSquares[] = {2, 3, 5, 6, 7};
    
    int perfectSquareIndex = rand() % 8;
    int notPerfectSquareIndex;
    
    if(perfectSquareIndex == 8)
        notPerfectSquareIndex = rand() % 2;
    else if(perfectSquareIndex > 5)
        notPerfectSquareIndex = rand() % 3;
    else
        notPerfectSquareIndex = rand() % 5;
    
    return perfectSquares[perfectSquareIndex] * notPerfectSquares[notPerfectSquareIndex];
}

/*
 * Simplifys sqrt(n) to A sqrt(B) and stores in A and B. 
 */
void simplySquareRoot(int n, int &A, int &B){
    int i, outsideNum, insideNum;
    for(i=sqrt(x); i>1; i--){
        if(x%(i*i)==0){
            outsideNum = i;
            insideNum = x/(outsideNum * outsideNum);
            break;
        }
    }
    A = outsideNum;
    B = insideNum;
}
