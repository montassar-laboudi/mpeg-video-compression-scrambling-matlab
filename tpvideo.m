close all                            
clear                             
load videoMPEG.mat         % Le chargement de la video MPEG
load TabVref               % Le chargement de tabVref 
Nbr_frames=95;             %nombre des images dans la video 
% La création d'une matrice de quantification Q de taille  8*8 
Q=1+K*(1+ones(8,1)*(0:7)+(0:7).'*ones(1,8));
for n=1:Nbr_frames
    % la construction des frames I de chaque GOP

    if (mod(n-1,12)==0)                                        
        Ir=decomp(TabEq(1,n).Y,TabEq(1,n).Cb,TabEq(1,n).Cr,Q); % La décompression 
        frame_embr(n)=im2frame(ycbcr2rgb(uint8(Ir)));            %conversion image en frame

    % la construction des frames P de chaque GOP
    
    else
        Ip=predite_embr(Ir,TabV(n));                                % La prédiction des images P embrouillées                                           
        Er=decomp(TabEq(1,n).Y,TabEq(1,n).Cb,TabEq(1,n).Cr,Q); % La décompression de la matrice d'erreur 
        Ir= Er+double(Ip);                                     % image reconstruite en retirant les erreur  
        if n==6 
            figure;
            imshow(ycbcr2rgb(uint8(Ip)));                      % Affichage de la 6ème image P prédite
            figure;
            imshow(ycbcr2rgb(uint8(Er)));                      % Affichage de la 6ème image de décompression de la matrice d'erreur
            figure;
            imshow(ycbcr2rgb(uint8(Ir)));                      % Affichage de la 6ème image P reconstruite
        end
        frame_embr(n)=im2frame(ycbcr2rgb(uint8(Ir)));            
    end
    
    
end
EcrireVideo(frame_embr,'video_embrouillee',10,100);    