function watershed_debug(path)
%frame(row) * feature(column)
clear all
path = '../../../Corpus_5034wav/N200108011200-01-02.wav'

M = getfeature(path);

I = dotplot(M,M);
[n temp ] = size(M)
Idist{1}=I;
iter=2;
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
imwrite(Idemo,'I2_1.bmp')
