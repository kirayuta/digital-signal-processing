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
        
function y = flip(x)
% FLIP Flip a Matlab sequence structure, x, so y = x[-n]
           
LI=length(x.data)+x.offset-1;
z=x.data;
z(1:end)= x.data(end:-1:1);
y= sequence(z, -LI);
           
%{
z(1:length(x.data))=x.data(end:-1:1);
sequence(z,-(x.offset + length(x.data)))
%}
end
        
function y = shift(x, n0)
% SHIFT Shift a Matlab sequence structure, x, by integer amount n0 so that y[n] = x[n - n0]
y = sequence(x.data, x.offset + n0);
     
            
end
        
    
            
function z = plus(x, y)
% PLUS  Add x and y. Either x and y will both be sequence structures, or one of them may be a number.
 
if isa(x,'sequence')==0
    x = sequence(x*ones(1,length(y.data)),y.offset);
end   
 
if isa(y,'sequence')==0
    y = sequence(y*ones(1,length(x.data)),x.offset);
end
 
LIx = x.offset+length(x.data)-1;
LIy = y.offset+length(y.data)-1;
%this get the last index number of each
 
x.data = [zeros(1, x.offset-y.offset) x.data zeros(1,LIy-LIx)];
y.data = [zeros(1, y.offset-x.offset) y.data zeros(1,LIx-LIy)];
%this matches length and ads zeros to match length
 
total = x.data+y.data;
minindex = min(x.offset,y.offset);
%this gets the lowest index of the two sequences
    
if sum(total==0)==length(total)
z=sequence(0,0);
return
end
 
while total(end)==0
    total(end)=[];
end
 
while total(1)==0
    
total=[];
minindex = minindex+1;
end
    
z=sequence(total,minindex);
 
end
 
            
    
function z = minus(x, y)
% MINUS Subtract x and y. Either x and y will both be sequence structures, or one of them may be a number.
if(isa(x,'sequence')==0)
x = sequence(x*ones(1,length(y.data)),y.offset);
end   
 
if(isa(y,'sequence')==0)
    y = sequence(y*ones(1,length(x.data)),x.offset);
end
 
LIx = x.offset+length(x.data)-1;
LIy = y.offset+length(y.data)-1;
% apply offset to function 
x.data = [zeros(1, x.offset-y.offset) x.data zeros(1,LIy-LIx)];
y.data = [zeros(1, y.offset-x.offset) y.data zeros(1,LIx-LIy)];
 
total = x.data-y.data;
off = min(x.offset,y.offset);
% Gather lowest index of the two sequences
    
if (sum(total==0))==length(total)
z=sequence(0,0);
return
end
 
while total(end)==0
    total(end)=[];
end
 
while total(1)==0
    total(1)=[];
    off = off+1;
end
    
z=sequence(total,off);
 
end
        
function z = times(x, y)
% TIMES Multiply x and y (i.e. .*) Either x and y will both be sequence structures, or one of them may be a number.
end
        
function stem(x)
% STEM Display a Matlab sequence, x, using a stem plot.
            
stem(x.offset:length(x.data)+x.offset-1,x.data,'filled');

end
        
        
end
end
