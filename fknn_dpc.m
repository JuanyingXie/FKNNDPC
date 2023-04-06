
%load data and label
data=load('dataset\iris_data.csv');
label=load('dataset\iris_label.csv');
%size of points
[ns nd ]=size(data);
%%min-max normalization
for i=1:nd
    maxi=max(data(:,i));
    mini=min(data(:,i));
    if maxi~=mini
        data(:,i)=(data(:,i)-mini)./(maxi-mini);
    else
        data(:,i)=0.5;
    end
end

%Find k-nearest neighbor
 k=7;%For Iris , FKNN-DPC does best when parameter K=7
 [dist,knn_x,knn_dist]=fun_dis_matrix1(data,k);
 [ND,NM]=size(dist);

%Calculate \rho
  rho=sum(exp(-knn_dist),2);

 %Calculate \delta
maxd=max(dist(:));
[rho_sorted,ordrho]=sort(rho,'descend');
delta(ordrho(1))=-1.;
for ii=2:ns
   delta(ordrho(ii))=maxd;
   td=dist(ordrho(ii),ordrho(1:ii-1));
   [del,nei]=min(td);
   delta(ordrho(ii))=del;
end
delta(ordrho(1))=max(delta(:));

%Calculate \gamma
for i=1:ns
    ind(i)=i;
    gamma(i)=rho(i)*delta(i);
end
[gam_sorted,ordgam]=sort(gamma,'descend');

%select density peaks(cluster centers)
gamin=gam_sorted(4);%For the Iris data set, select the three points with the highest gamma value
NCLUST=0;
cl=zeros(1,ns)-1;
for i=1:ns
    if gamma(i)>gamin
        NCLUST=NCLUST+1;
        cl(i)=NCLUST;
        icl(NCLUST)=i;
    end
end
center=icl; 

%FKNN-DPC assign non-center 
cl=fun_assignation(knn_dist,dist,knn_x,icl);
algorithem1 ={'FKNN-DPC'};
[newL2, c] = bestMap(label,cl);% match label
Acc= length(find(label == newL2))/length(label);%Calculate Clustering Accuracy (Acc)
ARI=adjrand(label, newL2); % Calculate adjusted rand index (ARI)
[AMI]=ami(label,newL2);  % Calculate Adjusted Mutual Information (AMI)
result = [k,Acc,AMI,ARI] ;% Save clustering Result
