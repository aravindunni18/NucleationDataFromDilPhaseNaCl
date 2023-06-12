close all
clear all
M=linspace(0,11,12);
S=linspace(-15,19,35);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
