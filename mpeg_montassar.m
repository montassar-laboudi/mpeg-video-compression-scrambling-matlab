%% TP MPEG
%% Montassar Laboudi
%% M2 Signal & Télécommunications 2024/2025

close all                            
clear                             
load videoMPEG.mat         % Le chargement de la video MPEG
load TabVref               % Le chargement de tabVref 
Nbr_frames=95;             %nombre des images dans la video 
% La création d'une matrice de quantification Q de taille  8*8 
Q=1+K*(1+ones(8,1)*(0:7)+(0:7).'*ones(1,8)); % La création d'une m3atrice de quantification Q de taille  8*8 
%La reconstruction de la vidéo avec embrouillage
for n=1:Nbr_frames 
    %construction des frames I de chaque GOP
    if (mod(n-1,12)==0)                                  
        Ir=decomp(TabEq(1,n).Y,TabEq(1,n).Cb,TabEq(1,n).Cr,Q); % La décompression 
        frame_embr(n)=im2frame(ycbcr2rgb(uint8(Ir)));            %conversion image en frame
    % construction des frames P de chaque GOP 
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
EcrireVideo(frame_embr,'video_embr',10,100);          % création de la video avec 10 images par secondes et une qualité de 100
                                            
 % la construction des frames I et P de chaque GOP
 % et désembrouillage en appelant la focntion predite_desembrouillee 
 for n=1:Nbr_frames
    % la construction des frames I de chaque GOP  
    if (mod(n-1,12)==0)                                       
        Ir=decomp(TabEq(1,n).Y,TabEq(1,n).Cb,TabEq(1,n).Cr,Q); % La décompression 
        frame_desembr(n)=im2frame(ycbcr2rgb(uint8(Ir)));            % La conversion image en frame   
    % la construction des frames P de chaque GOP
    else
        Ip=predit_desembr(Ir,TabV(n),n);           % prediction des images P (desembrouillées)
                                           % desembrouillage en appelant la
                                           % focntion Predit qui contient
                                           % partie desmbrouillage

        Er=decomp(TabEq(1,n).Y,TabEq(1,n).Cb,TabEq(1,n).Cr,Q); %decompression de la matrice d'erreur       
        Ir= Er+double(Ip);                                     %image reconstruite en retirant les erreur 
        if n==6 
            figure;
            imshow(ycbcr2rgb(uint8(Ip)));                      % Affichage de la 6ème image P prédite
            figure;
            imshow(ycbcr2rgb(uint8(Er)));                      % Affichage de la 6ème image de décompression de la matrice d'erreur
            figure;
            imshow(ycbcr2rgb(uint8(Ir)));                      % Affichage de la 6ème image P reconstruite
        end
        frame_desembr(n)=im2frame(ycbcr2rgb(uint8(Ir)));            %conversion image en frame
    end
    
    
end
EcrireVideo(frame_desembr,'video_desembr',10,100);   
                                            
%Tatouage Extraction de la marque
cle_s_t = 1618;
caracteres = [];

for img = 1:length(TabVref)
    if mod(img - 1, 12) ~= 0
        Vect_x = double(TabV(img).x);
        Vect_x_ref = double(TabVref(img).x);
        cle_t = cle_s_t + img;
        rng(cle_t);
        
        pos = randperm(1584, 24);
        
        Vx = Vect_x(:);    
        Vxref = Vect_x_ref(:);
        
        V_char = abs(Vx(pos) - Vxref(pos));
        
        % Convertir les valeurs binaires en caractères ASCII
        binstr = char(V_char + '0');
        
        % Ajouter les caractères extraits à la séquence
        caracteres = [caracteres, binstr];
    end
end

% Diviser les caractères en octets de 8 bits et les convertir en caractères ASCII
octets = reshape(caracteres, 8, []).';
dec = bin2dec(octets);

resultat = char(dec.');

disp(resultat)  

