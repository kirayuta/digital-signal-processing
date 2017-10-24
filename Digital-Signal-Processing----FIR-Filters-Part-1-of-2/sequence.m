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
%            Ernesto Casillas & Farnam Adelkhani  17 Feb. 2017
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
% Flip the Matlab structure sequence (x), so y = x[-n]
    data= fliplr(x.data);
    offset= -x.offset-length(x.data)+1;
    y = sequence(data,offset);
            
end
		
function y = shift(x, n0)
% Shift a Matlab sequence structure (x) by integer amount n0 so that y[n] = x[n - n0]
	offset= x.offset + n0;
    data=[x.data];
y=sequence(data,offset);
        
end
		
function z = plus(x, y)
   if(isa(x, 'sequence') ==1)
      off1 = x.offset;
     x1 = [x.data];  
  end
   if(isa(y, 'sequence') ==1)
      off2 = y.offset;
      y1 = [y.data];
  end
    if(isa(x, 'double')==1)
      x1=[repmat(x,1,length(y.data))];
     off1 = y.offset;
  end
    if(isa(y, 'double')==1)
      y1=[repmat(y,1,length(x.data))];
      off2 = x.offset;
  end
   lz1=length(x1)+ off1;
   lz2=length(y1)+ off2;         
   temp1 = [zeros(1,off1-off2) x1 zeros(1 ,lz2-lz1)];
   temp2 = [zeros(1,off2-off1) y1 zeros(1 ,lz1-lz2)];
     if(off1>off2)
   offset=off2;
end
   if(off1<off2)
     offset=off1;
end
   if(off1 == off2)
     offset =off2;
end
                   
  data = temp1+temp2;
  if(data(1)==0)
  data = [data(2:end)];
  offset=offset+1;
end
  if(data(end) == 0)
    data = [data(1:end-1)];
end
  z = sequence(data,offset);
    return
% Plus function - Add x and y. 
% X and Y will both be sequence structures, or one of them may be a number.
                                                                         
end
function y = conv(x, h)
   if (length(x.data)>= length(h.data))
      temp = x;   
      x=h;
      h=temp;
end
      off1 = x.offset;
      x1 = [x.data];  
      off2 = h.offset;
      h1 = [h.data];
      lx=length(x1);
      repnum=1;             
      total = length(h1)+lx;
      H = zeros(lx-1 ,total-1);
             
      n=0;
      stop = lx;
      for fill = 1:stop
                 
         H(n+1,1+n:length(h.data)+n)=h1;
         n=n+1;
  end
             
     X = repmat(x1',repnum,total-1);
       [up,across]= size(H);
     if (up == 1)
        y= sequence(X.*H,off1+off2);
    else
        z = sum(X.*H);
           y= sequence(z,off1+off2);
end
             
end
function y = even(x)
% Even function - Take a Matlab sequence object (x)... it may be complex, 
% then create a Matlab sequence structure (y) that corresponds to the even part
    xd= fliplr(x.data);
    y0ff= -x.offset-length(x.data)+1;
    xe = sequence([xd],y0ff);
    yt = .5.*(x+xe);
    y=sequence([yt.data],y0ff);      
    
end
function y = odd(x)
% Odd function - Take a Matlab sequence object (x)... it may be complex, 
% then create a Matlab sequence structure (y) that corresponds to the odd part
     xd= fliplr(x.data);
     y0ff= -x.offset-length(x.data)+1;
     xe = sequence([xd],y0ff);
     yt = .5.*(x-xe);
     y=sequence([yt.data],y0ff);
end
function y = trim(x)
% Trim function - Remove leading and trailing zeros, take a Matlab sequence
% object apropriately adjusting offset
        
while (x.data(1)==0)
      x.offset = x.offset+1;
      x.data = [x.data(2:length(x.data))];
      xd=x.data;
end
xd = x.data;
while(xd(length(xd))==0)
      xd = [xd(1:length(xd)-1)];
end
x.data = xd;
y = sequence(xd,x.offset);
end
        
		
function z = minus(x, y)
     if(isa(x, 'sequence') ==1)
        off1 = x.offset;
            x1 = [x.data];  
end
     if(isa(y, 'sequence') ==1)
        off2 = y.offset;
            y1 = [y.data];
end
     if(isa(x, 'double')==1)
         x1=[repmat(x,1,length(y.data))];
         off1 = y.offset;
end
         if(isa(y, 'double')==1)
             y1=[repmat(y,1,length(x.data))];
                off2 = x.offset;
end
     lz1=length(x1)+ off1;
     lz2=length(y1)+ off2;         
     temp1 = [zeros(1,off1-off2) x1 zeros(1 ,lz2-lz1)];
     temp2 = [zeros(1,off2-off1) y1 zeros(1 ,lz1-lz2)];
      if(off1>off2)
          offset=off2;
end
      if(off1<off2)
      offset=off1;
end
      if(off1 == off2)
      offset =off2;
end
      data = temp1-temp2;
       if(data(1)==0)
          data = [data(2:end)];
          offset=offset+1;
end
       if(data(end) == 0)
          data = [data(1:end-1)];
end
       z=sequence( data , offset);
          return
          
% Minus Function - Subtract x and y. 
% x and y will both be sequence structures or one of them may be a number.
end
		
  function z = times(x, y)
     if(isa(x, 'sequence') ==1)
        off1 = x.offset;
          x1 = [x.data];  
end
     if(isa(y, 'sequence') ==1)
        off2 = y.offset;
           y1 = [y.data];
end
     if(isa(x, 'double')==1)
        x1=[repmat(x,1,length(y.data))];
        off1 = y.offset;
end
     if(isa(y, 'double')==1)
        y1=[repmat(y,1,length(x.data))];
        off2 = x.offset;
end
     lz1=length(x1)+ off1;
     lz2=length(y1)+ off2;         
     temp1 = [zeros(1,off1-off2) x1 zeros(1 ,lz2-lz1)];
     temp2 = [zeros(1,off2-off1) y1 zeros(1 ,lz1-lz2)];
     if(off1>off2)
     offset=off2;
end
if(off1<off2)
     offset=off1;
end
     if(off1 == off2)
     offset =off2;
end
             
           
data = temp1.*temp2;
if(data(1)==0)
    data = [data(2:end)];
    offset=offset+1;
end
if(data(end) == 0)
    data = [data(1:end-1)];
end
   z = sequence (data,offset);
      return
% Times Function - Multiply x and y (i.e. .*) 
% x and y will both be sequence structures or one of them may be a number.
end

function x = deconv(y, h)
% Deconv function - Convolve finite-length Matlab sequence object (y)
% given impulse response sequence object (h) returning sequence object, x.
ly=length(y.data);
lh=length(h.data);
offy=y.offset;
offh=h.offset;
yd=y.data;
for i=1:ly
   temp = [zeros(1,i-1) h.data zeros(1,ly-i)];
   m(i,:)=temp;
end
H = m(1:ly,1:ly);
S = yd/H;
x = sequence(S(:,1:ly-lh+1),offy-offh);
end
	
function stem(x)
	% Display a matlab sequence using the stem function
    i=x.offset: x.offset+length(x.data)-1;
    stem(i,x.data)
end
        
end
end
