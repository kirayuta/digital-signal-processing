function Y = dtft2(x, w)
        
   n = x.offset:x.offset+length(x.data)-1;
       
      for i = 1:length(w)
           
           for k=1:length(n)
               a(k) = x.data(k)*cos((w(i))*n(k));
               b(k) = -(x.data(k)*sin(w(i)*n(k)));
end
           
           Y.real(i) = sum(a);
           Y.imag(i) = sum(b);
           
           Y.real(i) = Y.real(i)*(abs(Y.real(i))>10^-10);
           Y.imag(i) = Y.imag(i)*(abs(Y.imag(i))>10^-10); 
           
   end
end