close all
clear all
M=linspace(43,78,36);
S=linspace(3,40,38);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
