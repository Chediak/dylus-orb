function [out,varargout]=normmat(x,newminmax,flag)
---------------------------------------------------------------------------------------------
if flag==0

  a=min(min((x)));
  b=max(max((x)));
  if abs(a)>abs(b)
     large=a;
     small=b;
  else
     large=b;
     small=a;
  end
  temp=size(newminmax);
  if temp(1)~=1
     error('Error: for method=0, range vector must be a 2 element row vector');
  end  
  den=abs(large-small);  
  range=newminmax(2)-newminmax(1);
  if den==0
     out=x;
  else     
     z21=(x-a)/(den);  
     out=z21*range+newminmax(1)*ones(size(z21));
  end
  
%--------------------------------------------------------------------------------------------------------  
elseif flag==1
 a=min(x,[],1);
 b=max(x,[],1);
  for i=1:length(b)
     if abs(a(i))>abs(b(i))
        large(i)=a(i);
        small(i)=b(i);
     else
        large(i)=b(i);
        small(i)=a(i);
     end
  end
  den=abs(large-small);
  temp=size(newminmax);
  if temp(1)*temp(2)==2
     newminmaxA(1,:)=newminmax(1).*ones(size(x(1,:)));
     newminmaxA(2,:)=newminmax(2).*ones(size(x(1,:)));
  elseif temp(1)>2
     error('Error: for method=1, range matrix must have 2 rows and same columns as input matrix');
  else
     newminmaxA=newminmax;
  end
  
  range=newminmaxA(2,:)-newminmaxA(1,:);  
  for j=1:length(x(:,1))    
     for i=1:length(b)
        if den(i)==0
           out(j,i)=x(j,i);
        else
           z21(j,i)=(x(j,i)-a(i))./(den(i));
           out(j,i)=z21(j,i).*range(1,i)+newminmaxA(1,i);
        end
     end     
  end  
%--------------------------------------------------------------------------------------------------------  
elseif flag==2
  a=min(x,[],2);
  b=max(x,[],2);
  for i=1:length(b)
     if abs(a(i))>abs(b(i))
        large(i)=a(i);
        small(i)=b(i);
     else
        large(i)=b(i);
        small(i)=a(i);
     end 
  end
  den=abs(large-small);
  temp=size(newminmax);
  if temp(1)*temp(2)==2
     newminmaxA(:,1)=newminmax(1).*ones(size(x(:,1)));
     newminmaxA(:,2)=newminmax(2).*ones(size(x(:,1)));    
  elseif temp(2)>2
     error('Error: for method=2, range matrix must have 2 columns and same rows as input matrix');
  else
     newminmaxA=newminmax;
  end
  
  range=newminmaxA(:,2)-newminmaxA(:,1);  
  for j=1:length(x(1,:))
     for i=1:length(b)
        if den(i)==0
           out(i,j)=x(i,j);
        else           
           z21(i,j)=(x(i,j)-a(i))./([forcecol(den(i))]);
           out(i,j)=z21(i,j).*range(i,1)+newminmaxA(i,1);
        end
     end     
  end  
  
end
%--------------------------------------------------------------------------------------------------------
varargout{1}=a;
varargout{2}=b;

return
