close all
clear all
M=linspace(35,72,38);
S=linspace(2,38,37);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
