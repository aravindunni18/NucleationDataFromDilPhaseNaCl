close all
clear all
M=linspace(6,48,43);
S=linspace(-2,34,37);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
