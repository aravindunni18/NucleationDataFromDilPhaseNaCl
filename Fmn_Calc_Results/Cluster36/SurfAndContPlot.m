close all
clear all
M=linspace(0,36,37);
S=linspace(-4,32,37);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
