function y = linecoder(x,beta,r,A,n)
high_fs = n*r;
x = double(x(:))-48;

syms t p_s
p_s(t) = cos(2*pi*beta*t)*sinc(r*t) /...
        (1-(4*beta*t)^2);

p = double(subs(p_s,-3/r:1/(high_fs+1):3/r));

% todo: check length of x
x = A*2*(x-0.5);
len_p=length(p);
y=zeros(1,(length(x)+2)*n+1);
y(1:len_p-3*n) = x(1)*p(3*n+1:len_p);

y(1:len_p-2*n) = [y(1:len_p-3*n)+ x(2)*p(2*n+1:5*n+1),p(5*n+2:len_p)];

y(1:len_p-n) = [y(1:len_p-2*n)+ x(3)*p(n+1:5*n+1),p(5*n+2:len_p)];

y(1:len_p) = [y(1:len_p-n)+x(4)*p(1:5*n+1),p(5*n+2:len_p)];
a=5*n+1;
for k = 5:length(x) 
    b = 1+(k-4)*n;
    c=len_p+(k-5)*n;
    y(b:c) = y(b:c)+ x(k)*p(1:a);
    y(len_p-n+b:len_p+b-1) = p(a+1:len_p);
end 

end
    




