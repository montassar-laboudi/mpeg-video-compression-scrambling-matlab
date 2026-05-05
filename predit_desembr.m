function Ip=predit_desembr(Iref,V,n)
cle=3141+n;            % La clé secrète calculée par : cleE+n (avec cleE est la clé principale daembrouillage et n est le numéro de l'image)
f=8;                    %la force de perturbation (embrouillage)
% prédiction le la frame P sans embrouillage 
for line=1:36
    for col=1:44  
                rng(cle);                               % Initialisation du générateur de nombres pseudo-aléatoires
                emb=randi([-f f],size(V.y));            % Le recalcul des perturbations d'embrouillage 
                Vx=double(V.x(line,col));
                Vy=double(V.y(line,col))-emb(line,col); % désembrouillage des composantes verticales
                X=line*16-15-Vy;
                Y=col*16-15-Vx;
                if X<1
                    X=X+Vy;
                end
                if Y<1
                    Y=Y+Vx;
                end
                if X+15>576
                    X=X+Vy;
                end
                if Y+15>704
                    Y=Y+Vx;
                end
                % La génération de l'image prédite désembrouillée 
                Ip(line*16-15:line*16, col*16-15:col*16, :)=Iref(X:X+15, Y:Y+15, :);

    end
end

end
%IMAGE PREDITE SANS EMBROUILLAGE 