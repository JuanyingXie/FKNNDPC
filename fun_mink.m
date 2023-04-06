function [mink_dis,ind]=fun_mink(dist,nk)
%  Returns the first K minimum values of the vector and their corresponding labels
%  input : dist    Euclidean distance between  points
%  output: mink_dis  minimum values
%          ind       corresponding number

[mink_dis1,ind1]=sort(dist);
for i=1:nk
    mink_dis(i,:)=mink_dis1(i);
    ind(i,:)=ind1(i);
end
% 
% [mink_dis,ind]=sort(dist(1:nk));
% for i=nk+1:length(dist)
%     temi=dist(i);
%     if temi<mink_dis(nk)
%         mind=find(temi<mink_dis);       
%        mink_dis(mind(1):end)=[temi;mink_dis(mind(1):end-1)];
%        ind(mind(1):end)=[i ;ind(mind(1):end-1)];
%     end
% end
% end