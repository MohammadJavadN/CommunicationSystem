function y = adc(x,v,fs_old,fs_new)
% sample and hold
x_s = x(1:floor(fs_old/fs_new):length(x));
% normalize
x_zeromean = (x_s-mean(x_s));
x_n = x_zeromean/max(x_zeromean);
N=2^(v);
% quantizer
Q=zeros(size(x_n));      
levels = (-1- 1/N:1/(N/2):1- 1/N);
Q(x_n<=-1)=0;
Q(levels(N+1)<=x_n)=N-1;

for i=1:N
    Q(levels(i)<=x_n & x_n<levels(i+1))= i-1;
end
% encoder
b = dec2bin(Q,v);
% parallel to serial converter
y = reshape(b',1,length(Q)*v);

% %% plot 
% figure
% plot(Q)
% title('quqntized signal')


