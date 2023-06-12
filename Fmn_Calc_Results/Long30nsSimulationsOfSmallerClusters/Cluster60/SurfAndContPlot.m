close all
clear all
M=linspace(18,60,43);
S=linspace(0,41,42);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
