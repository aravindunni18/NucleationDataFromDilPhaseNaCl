close all
clear all
M=linspace(32,66,35);
S=linspace(1,34,34);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
