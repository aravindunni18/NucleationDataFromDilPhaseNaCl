close all
clear all
M=linspace(24,60,37);
S=linspace(1,36,36);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
