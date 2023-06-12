close all
clear all
M=linspace(0,18,19);
S=linspace(-12,20,33);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
