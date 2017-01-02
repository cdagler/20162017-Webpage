/* File Name: tanTangents.ch
 *
 * This program generates several images that can be merged together 
 * to create an animation that displays the tangent lines of y=tan(x).
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
    return x/(cos(i)*cos(i))-i/(cos(i)*cos(i))+tan(i);
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
    double lineWidth = 0.2;
    int lineType = 1, dataType=0;
    double inc = 0.1;
    double xMin = -M_PI/2.0, xMax = M_PI/2.0;
    double yMin = -5.0, yMax = 5.0;
    char fileName[32];
    int plotNum = 1;
    
    plot.mathCoord();
    plot.title("The Tangents of y=tan(x)");
    plot.label(PLOT_AXIS_X, "");
    plot.label(PLOT_AXIS_Y, "");
    plot.axisRange(PLOT_AXIS_X, xMin, xMax);
    plot.axisRange(PLOT_AXIS_Y, yMin, yMax);
    plot.sizeRatio(3.0);
    plot.grid(PLOT_OFF);
    plot.tics(PLOT_AXIS_XY, PLOT_OFF);
    plot.axis(PLOT_AXIS_XY, PLOT_OFF);

    plot.strokeColor("#99CCFF");
    plot.strokeWidth(1);
    
    for(i=xMin+0.2; i<xMax-0.2; i+=inc){
        if(i<0)
        {
            plot.func2D(-M_PI/2.0, i+0.05, 500, tangentLine);
            plot.outputType(PLOT_OUTPUTTYPE_FILE, "jpeg", getFileName(plotNum));
            plot.plotting();
            plotNum++;           
        }
        else
        {
            plot.func2D(i-0.05, M_PI/2.0, 500, tangentLine);
            plot.outputType(PLOT_OUTPUTTYPE_FILE, "jpeg", getFileName(plotNum));
            plot.plotting();
            plotNum++;             
        }
    }

    return 0;
}
