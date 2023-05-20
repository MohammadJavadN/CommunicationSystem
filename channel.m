function y = channel(x,B,N0,fs)
sigma = (B*N0)^0.5;
x_noisy = x + randn(1, length(x))*sigma;
if(B<fs/2)
    y=lowpass(x_noisy,B,fs);
else
    y=x_noisy;
end
end