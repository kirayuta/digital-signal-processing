classdef sequence
	properties
		data
		offset
	end
	
	methods
		function s = sequence(data, offset)
			% SEQUENCE   Sequence object
			%            S = SEQUENCE(DATA, OFFSET) creates sequence S
			%            using DATA and OFFSET
			%
			%            Your Name  1 Jan 2014
			s.data = data;
			s.offset = offset;
		end
		
		function display(s)
			var = inputname(1);
			if (isempty(var))
				disp('ans =');
			else
				disp([var '=']);
			end
			switch length(s.data)
				case 0
					disp('    data: []')
				case 1
					disp(['    data: ', num2str(s.data)])
				otherwise
					disp(['    data: [' num2str(s.data) ']'])
			end
			disp(['  offset: ' num2str(s.offset)])
		end
		
		function y = flip(s)
			% FLIP Flip a Matlab sequence structure, x, so y = x[-n]
        newlength= length(s.data);
        
        z= s.data;
        
        o = -(newlength +s.offset-1);
        z(1: newlength)=s.data(end:-1:1);
        
        y = sequence(z,o);
        
        end
        
		function y = shift(x, n0)
          
          % SHIFT Shift a Matlab sequence structure, x, by integer amount n0 so that y[n] = x[n - n0]
           
           y=sequence(x.data, x.offset+n0);
		end
		
		function z = plus(x, y)
         
        % PLUS  Add x and y. Either x and y will both be sequence structures, or one of them may be a number. 
          
            if (isa(x,'sequence')==0)
            x=sequence(x.*ones(1,length(y.data)),y.offset);
            end
            
            if (isa(y,'sequence')==0)
            y=sequence(y.*ones(1,length(x.data)),x.offset);
            end

            LIx = length(x.data) + x.offset - 1;
            LIy = length(y.data) + y.offset - 1;
            
            x.data=[zeros(1,x.offset-y.offset) x.data zeros(1,LIy-LIx)];
            y.data=[zeros(1,y.offset-x.offset) y.data zeros(1,LIx-LIy)];
            
            a1=x.data + y.data;
            off=min(x.offset,y.offset);
            
             if(sum(a1==0))==length(a1)
                z=sequence(0,0);
             end
            
            while (a1(1)==0)
                a1(1)=[];
                off=off+1; 
            end
            
            while (a1(end)==0)
                a1(end)=[];
               
            end  
  
            z = sequence(a1,off);
        end

        
		function z = minus(x, y)
            
             if (isa(x,'sequence')==0)
            x=sequence(x.*ones(1,length(y.data)),y.offset);      
            end
            
            if (isa(y,'sequence')==0)
            y=sequence(y.*ones(1,length(x.data)),x.offset);
            end
            
            LIx = length(x.data) + x.offset - 1;
            LIy = length(y.data) + y.offset - 1;
            
            x.data=[zeros(1,x.offset-y.offset) x.data zeros(1,LIy-LIx)];
            y.data=[zeros(1,y.offset-x.offset) y.data zeros(1,LIx-LIy)];
            
            a1=x.data - y.data;
            off=min(x.offset,y.offset);
            
             if(sum(a1==0))==length(a1)
                z=sequence(0,0);
             end
            
            while (a1(1)==0)
                a1(1)=[];
                off=off+1; 
            end
            
            while (a1(end)==0)
                a1(end)=[];
              
            end  
            z = sequence(a1,off);
        end
        
		function z = times(x, y)
           
        % TIMES Multiply x and y (i.e. .*) Either x and y will both be sequence structures, or one of them may be a number.
           
            if (isa(x,'sequence')==0)
            x=sequence(x.*ones(1,length(y.data)),y.offset);
            end
            
            if (isa(y,'sequence')==0)
            y=sequence(y.*ones(1,length(x.data)),x.offset);   
            end

            LIx = length(x.data) + x.offset - 1;
            LIy = length(y.data) + y.offset - 1;
            
            x.data=[zeros(1,x.offset-y.offset) x.data zeros(1,LIy-LIx)];
            y.data=[zeros(1,y.offset-x.offset) y.data zeros(1,LIx-LIy)];
            
            a1=x.data .* y.data;

            off=min(y.offset,x.offset);
 
             if(sum(a1==0))==length(a1)
                z=sequence(0,0);
             end
            
            while (a1(1)==0)
                a1(1)=[];
                off=off+1; 
            end
            
            while (a1(end)==0)
                 a1(end)=[];    
            end  
        
            z = sequence(a1,off);	
        end
        
        
		function  stem(x)
        
        % STEM Display a Matlab sequence, x, using a stem plot.
          stem(x.offset:length(x.data)+x.offset-1,x.data)
        end
        
        
        function z=conv(x,h)
  
            N = length(x.data);
            M = length(h.data);
            off=x.offset+h.offset;
               
            if N>=M
               H=zeros(M,M+N-1); 
            for i=1:M
                H(i,i:i+N-1)=x.data;  
            end
            z=sequence(h.data*H,off);

            else 
                H=zeros(N,M+N-1);
            for i=1:N
                H(i,i:i+M-1)=h.data;
                
            end
             z=sequence(x.data*H,off);
            end
         
        end 
             
       function x=deconv(y,h)
           
           off=y.offset-h.offset;
           
           Lx=length(y.data)-length(h.data)+1;
           
           y_cut=y.data(1:Lx);
          
               H=zeros(Lx,Lx);
               h_hat=[h.data zeros(1,Lx-length(h.data))];
            for i=1:Lx
                H(i,:)=h_hat;  
                h=circshift(h,[0,1]);
                h_hat(1)=0;
            end
            
            temp =y_cut/(H);
            
            x=sequence(temp,off);
   
       end
    
      
          function y = even(x)
          
           y=(0.5).*plus(x,flip(x));     
          end 

        
        function y = odd(x)

               y=(0.5).*minus(x,flip(x));          
        end 
            
    function y= trim(x)
    
        T=x.data;
            
  
        off=x.offset;
           
            
            while (T(1)==0)
                T(1)=[];
                off=off+1; 
            end
            
            while (T(end)==0)
                T(end)=[];
                
            end  
           
            y = sequence(T,off);    
    end

    end 
    end




	
    
