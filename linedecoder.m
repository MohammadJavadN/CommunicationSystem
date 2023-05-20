function y = linedecoder(x,n)
y = x(1:n:length(x))>0;
end