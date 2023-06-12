close all
clear all
M=linspace(45,84,40);
S=linspace(1,40,40);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
