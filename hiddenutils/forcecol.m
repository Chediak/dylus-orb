% forcecol.m
% function to force a vector to be a single column
%


function[out]=forcecol(in)
len=prod(size(in));
out=reshape(in,[len,1]);
