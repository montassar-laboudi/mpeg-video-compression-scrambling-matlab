function Er = decomp(Yq,Cbq,Crq,Q)
x = 8; y = 8;%La taille du bloc
%multiplication de Yq, Cbq, Crq par la matrice de quantification
Y_dct  =  blkproc(Yq,[y,x], 'dequantification',Q);
Cb_dct  = blkproc(Cbq,[y,x],'dequantification',Q);
Cr_dct  = blkproc(Crq,[y,x],'dequantification',Q);
%La transformé cosinus inverse
Y =  blkproc(Y_dct,[y,x], 'idct2'); 
Cb = blkproc(Cb_dct,[y,x],'idct2');
Cr = blkproc(Cr_dct,[y,x],'idct2');


Cb = imresize(Cb, 2, 'bilinear');
Cr = imresize(Cr, 2, 'bilinear');

Er(:,:,1) = Y;
Er(:,:,2) = Cb;
Er(:,:,3) = Cr;

end