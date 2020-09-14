

function [x_cnt,y_cnt] = spiral_dyn(n,a)
 % this keeps the same start time for each run of the calling function 
 % this will reset when any calling prog is re-saved or workspace is
 % cleared
  persistent tnot iter
 % find starting time
  if ~exist('tnot') | length(tnot)==0
     tnot = cputime;
   %  iter = 0;
  end
  %iter = iter+10 ;
  
 theta = cputime-tnot;
 %theta = iter/10000;
 
 r = a*(theta.^n);
 
 x_cnt = r*cos(theta);
 y_cnt = r*sin(theta);
 return
