function y = linecoder_realtime(x,beta,r,A,D)
high_fs = D*r;
x = double(x(:))-48;
global p firsttime
syms t p_s

if (firsttime)
    p_s(t) = cos(2*pi*beta*t)*sinc(r*t) /...
            (1-(4*beta*t)^2);

    p = double(subs(p_s,-3/r:1/(high_fs+1):3/r));%todo: +1
    firsttime=0;
end

x = A*2*(x-0.5);
len_p=length(p);
y=zeros(1,(length(x)+2)*D+1);
y(1:len_p-3*D) = x(1)*p(3*D+1:len_p);

y(1:len_p-2*D) = [y(1:len_p-3*D)+ x(2)*p(2*D+1:5*D+1),p(5*D+2:len_p)];

y(1:len_p-D) = [y(1:len_p-2*D)+ x(3)*p(D+1:5*D+1),p(5*D+2:len_p)];

y(1:len_p) = [y(1:len_p-D)+x(4)*p(1:5*D+1),p(5*D+2:len_p)];
a=5*D+1;
for k = 5:length(x) 
    b = 1+(k-4)*D;
    c=len_p+(k-5)*D;
    y(b:c) = y(b:c)+ x(k)*p(1:a);
    y(len_p-D+b:len_p+b-1) = p(a+1:len_p);
end 

end
    




