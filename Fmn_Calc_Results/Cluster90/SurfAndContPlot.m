% close all
% clear all
figure
M=linspace(54,90,37);
S=linspace(2,42,41);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
