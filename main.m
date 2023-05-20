clc
clear
close all

v = 8;
A=10;
fs=8000;
W=1500;
N0=1e-3;
n=11;
r=fs*v;
beta = r/2;
B = 500;
[x,fs_rec] = audioread('audio.wav');
fs = fs_rec/(floor(fs_rec/fs));
x_d = adc(x,v,fs_rec,fs);
x_l = linecoder(x_d,beta,r,A,n);
x_c = channel(x_l,B,N0,n*r);
x_ld = linedecoder(x_c,n);
y = dac(x_ld,v,fs,fs_rec,W);

plot(y)

sound(y,fs_rec);



