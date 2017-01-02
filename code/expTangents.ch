/* File Name: expTangents.ch
 *
 * This program generates several images that can be merged together 
 * to create an animation that displays the tangent lines of y=e^x.
 *
 * Name: Clay Dagler (Clayton-Dagler@scusd.edu)
 */
 
#include <chplot.h> 
#include <math.h>

static double i;

/*
 * The file deriving_tangent_lines.pdf shows how this function was
 * created. 
 */
double tangentLine(double x){
    return exp(i)*x-exp(i)*i+exp(i);
}    

string_t getFileName(int n) {
    char ans[64];
    if(n < 10)
        sprintf(ans, "00%d.jpg", n);
    else if(n<100)
        sprintf(ans, "0%d.jpg", n);
    else if(n<1000)
        sprintf(ans, "%d.jpg", n);
    else {
        printf("\aTo many output files!!!!\n");
        exit(1);
    }
    return ans;
}

int main() {
    CPlot plot;
    double inc = 0.2;
    double xMin = -3.0, xMax = 3.0;
    double yMin = 0.0, yMax = 20.0;
    char fileName[32];
    int plotNum = 1;

    plot.mathCoord();
    plot.title("The Tangents of y=e^x");
    plot.label(PLOT_AXIS_X, "");
    plot.label(PLOT_AXIS_Y, "");
    plot.axisRange(PLOT_AXIS_X, xMin, xMax);
    plot.axisRange(PLOT_AXIS_Y, yMin, yMax);
    plot.sizeRatio(2);
    plot.grid(PLOT_OFF);
    plot.tics(PLOT_AXIS_XY, PLOT_OFF);
    plot.axis(PLOT_AXIS_XY, PLOT_OFF);
    
    plot.strokeColor("#99CCFF");  
    plot.strokeWidth(1);
    
    /*
     * The bottom.
     */
    plot.line(xMin, 0, xMax, 0);  /* The bottom */
    plot.outputType(PLOT_OUTPUTTYPE_FILE, "jpeg", getFileName(plotNum));
    plot.plotting();
    plotNum++;
    
    for(i=xMin; i<xMax; i+=inc){
        plot.func2D(xMin, xMax, 500, tangentLine);
        plot.outputType(PLOT_OUTPUTTYPE_FILE, "jpeg", getFileName(plotNum));
        plot.plotting();
        plotNum++;
    }
    
    return 0;
}


