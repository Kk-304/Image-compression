clc
A= imread('E:\Matlab projects/Snorlax.png');
subplot(2,4,1)
imshow(A)
title('Given image');
xlabel('(512 x 512 pixels)')
B= rgb2gray(A);
subplot(2,4,2)
imshow(B)
title('Grey scaled image');
xlabel('(512 x 512 pixels)')
Bt = fft2(B);
Blog= log(abs(fftshift(Bt)+1));
%Fourier Coefficients are converted in log as 
%they are very small and tend to disolved very easily.
subplot(2,4,4)
imshow(mat2gray(Blog));
title('Fourier Transform of grey scaled image');
Btsort = sort(abs(Bt(:)));
counter = 1;    
for keep= [.99 .05 .01 .002]
    subplot(2,4,counter+4)
    thresh = Btsort(floor((1-keep)*length(Btsort)));
    %This is the most important value, it signifies the maximum amount of
    %values to avoid
    ind =abs(Bt)> thresh;
    Atlow= Bt.*ind;
    Alow = uint8(ifft2(Atlow));
    imshow(Alow)
    title(['Compressed to: ',num2str(keep*100),'%'])
    xlabel("Grey Scaled Image");
    counter= counter + 1;
end
subplot(2,4,3)
surf(Alow(10:10:end,10:10:end))
%distributed in every 10th pixel
title('FFT compressed image')