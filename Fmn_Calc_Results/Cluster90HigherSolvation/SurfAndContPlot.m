close all
clear all
M=linspace(42,87,46);
S=linspace(22,68,47);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
