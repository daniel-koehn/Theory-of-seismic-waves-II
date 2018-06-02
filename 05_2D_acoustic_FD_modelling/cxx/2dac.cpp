/* 2-D acoustic wave equation FD solver */
/* ------------------------------------ */
/* 					*/
/* Daniel Koehn                         */
/* Kiel, 1st of June 2018               */
/* ------------------------------------ */

#include <Eigen/Dense>
#include <iostream>
#include <fstream>
#include <time.h>

using namespace std;
using namespace Eigen;

int main(){

// time start + end
clock_t start, end;

/* Declaration and definition of variables */
float xmax = 500.0, zmax = xmax, dx = 1.0, dz = dx, tmax = 0.502, dt = 0.001; 
const int nx = (int)(xmax/dx), nz = (int)(zmax/dz), nt = (int)(tmax/dt);

float vp0 = 580.0, signal;

float xr=330.0, zr = xr, xsrc = 250.0, zsrc = xsrc, f0 = 40.0;
float t0 = 4.0 / f0, t, dt2 = dt*dt;

int isrc = (int)(xsrc/dx), jsrc = (int)(zsrc/dz);
int ir = (int)(xr/dx), jr = (int)(zr/dz);

int i, j, n;

// define model
// ------------
Eigen::MatrixXf vp(nx+1,nz+1);
Eigen::MatrixXf vp2(nx+1,nz+1);

for (i = 1;i <= nx; i++) {
    for (j = 1;j <= nz; j++) {       
	vp(j,i) = vp0;
    }
}

// define square of Vp model
vp2 = vp.cwiseProduct(vp);

// open output file
ofstream file;
file.open ("seis.dat");

// start clock
start = clock();

// Initialize empty pressure arraysS
Eigen::MatrixXf p(nx+1,nz+1);
Eigen::MatrixXf pold(nx+1,nz+1);
Eigen::MatrixXf pnew(nx+1,nz+1);
Eigen::MatrixXf d2px(nx+1,nz+1);
Eigen::MatrixXf d2pz(nx+1,nz+1);

/* Time-loop */
for (n = 0;n <= nt; n++) {

    /* Calculate source signal */
    /* ----------------------- */
    t = n * dt; /* time */
    signal=-2*(t-t0)*f0*f0*expf(-f0*f0*(t-t0)*(t-t0)); /* source signal */

    /* FD approximation of spatial dervatives by 3-point operator */
    /* ---------------------------------------------------------- */
    for (i = 1;i <= nx-1; i++) {
    	for (j = 1;j <= nz-1; j++) {       

	    d2px(j,i) = (p(j,i+1) - 2 * p(j,i) + p(j,i-1)) / (dx*dx);
	    d2pz(j,i) = (p(j+1,i) - 2 * p(j,i) + p(j-1,i)) / (dz*dz);          

	}
    }	

    /* Time Extrapolation */		
    /* ------------------ */
    pnew = 2 * p - pold + dt2 * vp2.cwiseProduct(d2px + d2pz);

    /* Add Source Term at isrc */
    /* ----------------------- */
    /* Absolute pressure w.r.t analytical solution */
    pnew(jsrc,isrc) = pnew(jsrc,isrc) + signal / (dx * dz) * dt * dt;

    /* Remap Time Levels */
    /* ----------------- */
    pold = p;
       p = pnew;

    /* Seismogram output */
    file << t;
    file << "\t";
    file << p(jr,ir);
    file << "\n";

}

// stop clock
end = clock();

cout << "Wall time: " << 1000 * (double)(end - start) / CLOCKS_PER_SEC << " ms" << endl;

file.close();

return 0;
}
