function y=lowpass(x,B,fs)
if(B<fs/2) 
    if(size(x,1)>size(x,2))
        x=x';
    end
    len = length(x);
    fft_x=fft(x);
    t = (len/fs);
    Bt= floor(B*t);
    fft_x(Bt+2:len-Bt)=0;
    y = real(ifft(fft_x));
else
    y=x;
end

