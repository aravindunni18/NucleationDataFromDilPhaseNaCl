close all
clear all
M=linspace(0,29,30);
S=linspace(-6,30,37);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
