close all
clear all
M=linspace(0,6,7);
S=linspace(-16,16,33);
G=load('free_energy.dat');
surf(M,S,G');xlabel('M');ylabel('S');
figure
contourf(M,S,G');xlabel('M');ylabel('S');
