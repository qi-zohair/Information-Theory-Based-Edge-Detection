%% This work belons to the following paper:
% Elaraby, A., & Al-Ameen, Z. (2022). 
% Multi-Phase Information Theory-Based Algorithm for Edge Detection of Aerial Images. 
% Journal of Information and Communication Technology, 21(2), 233-254.

clc; clear all; close all
d = imread('4.jpg');
figure; imshow(d); 
tic;
[M,N]=size(d);
p = zeros(256,3);
for ii=1:256 
    p(ii,1)=ii-1; 
end
p(:,2) = imhist(d);
p (p(:,2)==0,:) = []; % remove zero entries in p
%% Calling Tsallis 
[T1,Loc]=HillEntropy(p);
%% Calling Shannon Part1
pLow= p(1:Loc,:);         T2= Shannon(pLow);
%% Calling Shannon Part2
pHigh=p(Loc+1:size(p),:); T3=Shannon(pHigh);
%% Cerate binary matrices
f=zeros(M,N);
 for i=1:M 
   for j=1:N 
     if ((d(i,j)>= T2)&&(d(i,j)<T1))||(d(i,j)>= T3)
        f(i,j)=1; end
   end  
 end
%% Calling EdgeDetector 
[g]= EdgeDetector(f);
toc;
figure; imshow(g); 
% imwrite(g, 'out.jpg')