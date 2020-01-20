% =========================================================================
% Sub-Function inside the main function for node distribution analysis based
% on Fourier transform
% =========================================================================
%% Save node positions
newskel = zeros(datas);
newskel(node(:,1))=1;
%% Fourier transform
F = @(x)abs((ifftshift(fftn(fftshift(x)))));
fftnode = F(newskel);%*(0.65^3);
fftnode = (fftnode - min(fftnode(:)))./(max(fftnode(:)) - min(fftnode(:)));
fftnode = fftnode./max(fftnode(:));
%% Plot
figure
thr = 0.5;
cor = find(fftnode>thr);
[a,b,value] = find(fftnode>thr);
[cor1,cor2,cor3] = ind2sub(datas,cor); % find nonzero component
scatter3(cor2(:,1),cor1(:,1),cor3(:,1),10,value,'filled');
colormap gray
axis image
set(gcf,'color','white')
%% Save Fourier transform results
fprintf('Start saving skeletonized volume in the folder.\n')
% indicate folder name to save
folder = '.\Result\FFT\';

if ~exist(folder, 'dir')
    fprintf('Generating new folder...\n')
    mkdir(folder)
    elsess
    fprintf('Folder already existed.\n')
end
% start saving the skeletonized volume
%  indicate image format to save
style = '.tif';
for i =1:size(fftnode,3)
    im = fftnode(:,:,i);
    imwrite(im,[folder, num2str(i),style]);
end
fprintf('Saving completed!\n')

%% Finish FFT section
fprintf('Node distribution analysis based Fourier transform completed!\n')
open main_dataAnalysis