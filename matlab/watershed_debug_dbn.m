function watershed_debug(path)
%frame(row) * feature(column)
clear all
path = '../../Semester 9.5/Corpus_TIMIT_train/train_dr1_fcjf0_sa1.wav'
M = getfeature(path);

%path = '../../Semester 10/TCCGMM/Corpus_TIMIT_train/train_dr1_fcjf0_sa1.wav.mat'
%load(path)
%M = feature_dbn


I = dotplot(M,M);
[n temp ] = size(M)
Idist{1}=I;
iter=4;
for i =1:iter-1
    Idist{i+1} = im2bw(Idist{i},graythresh(Idist{i}));
    Idist{i+1} = bwdist(~Idist{i+1});
    Idist{i+1} = Idist{i+1}./max(max(Idist{i+1}));
end

Iwater = watershed(1-Idist{iter});


Idemo = zeros(n,n,3);
for i = 1:n
    for j = 1:n
        for c = 1:3
            Idemo(i,j,c)= Idist{1}(i,j);
        end
        if Iwater(i,j)==0
            Idemo(i,j,1) = 1;
            Idemo(i,j,2) = 0;
            Idemo(i,j,3) = 0;
        end
    end
end
imshow(Idemo)
imwrite(Idemo,'water_mfcc.bmp')
