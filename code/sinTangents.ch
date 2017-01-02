/* File Name: sinTangents.ch
 *
 * This program generates several images that can be merged together 
 * to create an animation that displays the tangent lines of y=sin(x).
 *
 * Author: Clay Dagler (Clayton-Dagler@scusd.edu)
 */
 
#include <chplot.h> 
#include <math.h>

static double i;

/* 
 * The file deriving_tangent_lines.pdf shows how this function was
 * created. 
 */
double tangentLine(double x){
    return cos(i)*x-cos(i)*i+sin(i);
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
    double xMin = 0.0, xMax = 2 * M_PI;
    double yMin = -1.2, yMax = 1.2;
    char fileName[32];
    int plotNum = 1;

    plot.mathCoord();
    plot.title("The Tangents of y=sin(x)");
    plot.label(PLOT_AXIS_X, "");
    plot.label(PLOT_AXIS_Y, "");
    plot.axisRange(PLOT_AXIS_X, xMin, xMax);
    plot.axisRange(PLOT_AXIS_Y, yMin, yMax);
    plot.sizeRatio(2/xMax);
    plot.grid(PLOT_OFF);
    plot.tics(PLOT_AXIS_XY, PLOT_OFF);
    plot.axis(PLOT_AXIS_XY, PLOT_OFF);

    plot.strokeColor("#99CCFF");
    plot.strokeWidth(1);
    
    for(i=xMin; i<xMax; i+=inc){
        if(i<M_PI/2)
        {
            plot.func2D(0, M_PI/2, 500, tangentLine);
            plot.outputType(PLOT_OUTPUTTYPE_FILE, "jpeg", getFileName(plotNum));
            plot.plotting();
            plotNum++;           
        }
        else if(i<M_PI)
        {
            plot.func2D(M_PI/2, M_PI, 500, tangentLine);
            plot.outputType(PLOT_OUTPUTTYPE_FILE, "jpeg", getFileName(plotNum));
            plot.plotting();
            plotNum++;           
        }
        else if(i<3*M_PI/2)
        {
            plot.func2D(M_PI, 3*M_PI/2, 500, tangentLine);
            plot.outputType(PLOT_OUTPUTTYPE_FILE, "jpeg", getFileName(plotNum));
            plot.plotting();
            plotNum++;           
        }
        else
        {
            plot.func2D(3*M_PI/2, 2*M_PI, 500, tangentLine);
            plot.outputType(PLOT_OUTPUTTYPE_FILE, "jpeg", getFileName(plotNum));
            plot.plotting();
            plotNum++;           
        }
    }

    return 0;
}

