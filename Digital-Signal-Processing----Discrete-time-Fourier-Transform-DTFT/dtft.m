function y =dtft(x,w) 
        
    w = linspace(-pi, pi, 11); 
    n = x.offset:x.offset+length(x.data)-1;
       
    Q = n'*w;
    y = x.data*exp(-1i*Q);
 end 
    