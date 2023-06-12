close all
clear all
M=linspace(0,30,31);
S=linspace(-7,35,43);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
