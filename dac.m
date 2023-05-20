function y = dac(x_ld,v,fs,fs_rec,W)
len = length(x_ld);
temp = reshape(x_ld(1:len-3),v,floor(len/v))';
binary = char(uint8(temp(:,:))+48);
y_d = bin2dec(binary);
y_d=(y_d-mean(y_d));
y_d=y_d/max(abs(y_d));
y = zeros(1,length(y_d)*floor(fs_rec/fs));
y((1:floor(fs_rec/fs):length(y_d)*floor(fs_rec/fs)))=y_d(:)';
y=lowpass(y,W,fs_rec);
end