function cl=fun_assignation(knn_dist,dist,knn_x,icl)
%   Assign Non-center
%    input:
%         dist£º  Euclidean distance between  points
%         knn_x:  k-nearest neighbor for each points
%         knn_dist:   The distance between each sample and its k-nearest neighbor
%         icl:    density peaks
%   output:
%         cl  :  label for each sample

[ns,nn]=size(knn_x);
nk=length(icl);

cl=zeros(1,ns)-1;
cl(icl)=1:nk;
%find outliers
knn_mdist=mean(knn_dist,2);
densi=knn_dist(:,end);
thr=mean(densi);
flag=densi<=thr;
%Assign non-outliers
for i=1:nk
    ck=icl(i);
    tem_knn=knn_x(ck,:);
    pipu=[tem_knn];
    cl(pipu)=i;
    
    while ~isempty(pipu)
        temck=pipu(1);
        tem_knn=knn_x(temck,:);  
        for j=1:nn
            temk=tem_knn(j);
            if cl(temk)==-1&& flag(temk)==1
                temdist=knn_dist(temck,j);
                if temdist<=knn_mdist(temk) %&& temdist<=knn_mdist(temck)
                    cl(temk)=cl(ck);
                    pipu=[pipu temk];
                end
            end
        end
        pipu(1)=[];
        

    end
end


%Assign the remaining points not assigned and the outliers 
wdist=1./(1+knn_dist);
tsw=sum(wdist,2);
sumw=repmat(tsw,1,nn);
wi=wdist.^2./sumw;
ulabel=find(cl==-1);
if ~isempty(ulabel)
    ll=[];
    for i=1:length(ulabel)
        l=[];
        for j=1:nk
            tenml=find(cl(knn_x(ulabel(i),:))==j);
            twi=wi(ulabel(i),tenml);
            tl=sum(twi);
            l=[l;tl];
        end
        ll=[ll l]; 
    end 
    
    count=1;
    lenll=length(ll);
    temll=ll;
    [maxl,indl]=max(temll);
    while count<=lenll
        
 
        [tmax,ind]=max(maxl);  
        if tmax==0   
            break;
        end
          
            temp=ulabel(ind); 
            cl(temp)=indl(1,ind);
            tknn=knn_x(temp,:);
            [isk,inisk]=intersect(tknn,ulabel);  
            if ~isempty(isk)
                for ii=1:length(isk)
                    tp=find(ulabel==isk(ii));
                    if ulabel(tp)~=-1
                        temll(cl(temp),tp)=temll(cl(temp),tp)+wi(temp,inisk(ii));

                    end
                    [tmax,tid]=max(temll(:,tp));
                    maxl(tp)=tmax;
                    indl(tp)=tid;
                end
                
            end
            count=count+1;
            ulabel(ind)=[];
            temll(:,ind)=[];
            indl(ind)=[];
            maxl(ind)=[];

        
    end
    uind=ulabel~=-1;  
    ulab=ulabel(uind);
    for i=1:length(ulab)
        ui= ulab(i);
        rlab=find(cl(knn_x(ui,:))~=-1);
        if ~isempty(rlab)  
            cl(ui)=cl(knn_x(ui,rlab(1)));
        else
            tdi=dist(ui,:);
            tdi(ui)=inf;
            [~,indi]=sort(tdi);
            rlab=find(cl(indi)~=-1);
            cl(ui)=cl(indi(rlab(1)));
            
        end
    end
    
end

end