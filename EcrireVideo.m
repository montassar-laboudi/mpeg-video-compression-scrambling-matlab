% EcrireVideo(Video, NomDeFichier, NbImagesParSeconde, Qualite);
%
% Ecriture d'une vidéo dans un fichier
%
% Video = variable contenant la vidéo à enregistrer. 
%         Il s'agit d'une structure de type "movie", préalablement créée 
%         en y plaçant les images de la vidéo à l'aide de la fonction im2frame. 
% NomDefichier = nom du fichier dans lequel on veut enregistrer la vidéo.
% NbImagesParSecondes = nombre d'images par seconde.
% Qualite = nombre entre 0 et 100 (100 correspond à la meilleure qualité)
%
% (C) Gilles Burel / Université de Brest / Département d'Electronique
%


function EcrireVideo(Video, NomDeFichier, NbImagesParSeconde, Qualite)

vidObj = VideoWriter(NomDeFichier, 'Motion JPEG AVI');
%vidObj = VideoWriter(NomDeFichier);  % 'Motion JPEG AVI' est la valeur par défaut

vidObj.FrameRate = NbImagesParSeconde;
vidObj.Quality = Qualite;

open(vidObj);

writeVideo(vidObj, Video);

close(vidObj);

end


