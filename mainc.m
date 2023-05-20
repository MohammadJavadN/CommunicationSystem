clc
clear
close all

v = 8;
A=10;
fs=8000;
W=1500;
N0=1e-5;
D=11;
r=fs*v;
beta = r/2;
B = fs*v/2;
[x,fs_old] = audioread('audio.wav');
x=x(1:4410);
x_d = adc(x,v,fs_old,fs);

for i = 1:5
    A = i;
    for j = 0:20
        N0 = j*(4*1e-5);
        x_l = linecoder(x_d,beta,r,A,D);
        x_c = channel(x_l,B,N0,D*r);
        x_ld = linedecoder(x_c,D);
        sigma2(j+1)=B*N0;
        BER(j+1)=sum(abs(x_d(:)'-double(x_ld(1:length(x_d)))-48))/length(x_d)*100;
    end
    plot(sigma2,BER)
    hold on
    s(i) = string(['A = ', char(A+48)]);
    legend(s)
end

title('BER')
xlabel('\sigma^2')
ylabel('BER (%)')
