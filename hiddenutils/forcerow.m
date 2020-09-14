% forcerow.m
% function to force a vector to be a single row
%

function[out]=forcerow(in)
len=prod(size(in));
out=reshape(in,[1,len]);
