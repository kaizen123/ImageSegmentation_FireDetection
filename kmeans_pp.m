%Kmeans
function kmeans_pp(k, inImg)
im=inImg;
%
%imshow(im);
%title('Input Image');
%
cform=makecform('srgb2lab');% create a color transformation structure
lab=applycform(im,cform); 
ab=double(lab(:,:,2:3));
nrows=size(lab,1);
ncols=size(lab,2);
X=reshape(ab,nrows*ncols,2)'; 
%
%figure
%scatter(X(1,:)',X(2,:)',3,'filled');
%box on;
%k=3;
%
max_iter=100; 
[centroids,labels]=run_kmeans(X,k,max_iter);
figure; 
scatter(X(1,:)',X(2,:)',3,labels,'filled');
hold on;
scatter(centroids(1,:),centroids(2,:),60,'r','filled');
hold on;
scatter(centroids(1,:),centroids(2,:),30,'g','filled');
box on;%adds a box to the current axes
hold off;
%
%pixel_labels=reshape(labels,nrows,ncols);
%rgb_labels=label2rgb(pixel_labels);%converts label matrix to RGB image.
%figure
%imshow(rgb_labels);
%title('segmented Image');
%
end

%Kmeans
function [centroids,labels]=run_kmeans(X,k,max_iter)
centroids=X(:,1+round(rand*(size(X,2)-1)));
labels=ones(1,size(X,2));
for i=2:k
    D=X-centroids(:,labels);
    D=cumsum(sqrt(dot(D,D,1)));
    if D(end)==0
        centroids(:,i:k)=X(:,ones(k-i+1,1));
        return;
    end
    centroids(:,i)=X(:,find(rand<D/D(end),1));
    [~,labels]=max(bsxfun(@minus,2*real(centroids'*X),dot(centroids,centroids,1).'));
end
%Kmeans
for iter=1:max_iter
    for i=1:k
        l=labels==i;
        centroids(:,i)=sum(X(:,l),2)/sum(l);
    end
    [~,labels]=max(bsxfun(@minus,2*real(centroids'*X),dot(centroids,centroids,1).'),[],1);
end
end

















