function f = mag_phase(X) 

   % MAG_PHASE Input argument is a structure with x.real and x.imag
   % Return values are y.mag (magnitude) and y.phase (phase in radians)  
   
   f.mag = ((X.real).^(2)+(X.imag).^(2)).^(0.5);
   f.phase = atan2(X.imag,X.real);
    end 