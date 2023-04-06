function [dist,knn_x,knn_dist]=fun_dis_matrix1(data,nk)
% Find k-nearest neighbor
%  input:  
%         data: all experimental data
%         nk: number of k-nearest neighbor
%  output: 
%         dist: Euclidean distance between  points
%         knn_x:  k-nearest neighbor for each points
%         knn_dist:   The distance between each sample and its k-nearest neighbor

[m,n]=size(data);
tdis=pdist(data);


dist=squareform(tdis);
knn_dist=zeros(m,nk);
knn_x=zeros(m,nk);
for i=1:m
    tdi=dist(:,i);
    tdi(i)=inf;
    [dis,ind]=fun_mink(tdi,nk);
    knn_dist(i,:)=dis;
   knn_x(i,:)=ind;
end

end
