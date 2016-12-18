/* File Name: prabTangents.ch
 *
 * This program displays the parabola (y=x^2) defined by
 * its tangent lines.
 *
 * Name: Clay Dagler (Clayton-Dagler@scusd.edu)
 */
 
#include <chplot.h> 
static double i;

/*
 * Note: This function was found by finding the tangent 
 * lines of y=x^2 by hand and discovering a pattern.
 */
double tangentLine(double x){
    return i*(2*x-i);
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
    double inc = 0.1;
    double xMin = -2.0, xMax = 2.0;
    double yMin = 0.0, yMax = 4.0;
    char fileName[32];
    int plotNum = 1;
    
    plot.mathCoord();
    plot.title("The Tangents of y=x^2");
    plot.label(PLOT_AXIS_XY, "");
    plot.axisRange(PLOT_AXIS_X, xMin, xMax);
    plot.axisRange(PLOT_AXIS_Y, yMin, yMax);
    plot.sizeRatio(1);
    plot.grid(PLOT_OFF);
    plot.tics(PLOT_AXIS_XY, PLOT_OFF);
    plot.axis(PLOT_AXIS_XY, PLOT_OFF);

    plot.strokeColor("#99CCFF");
    plot.strokeWidth(1);

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
