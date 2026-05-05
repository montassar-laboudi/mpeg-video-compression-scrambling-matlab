function Ip=predite_embr(Iref,V)

% prédiction le la frame P avec embrouillage 
for line=1:36
    for col=1:44

                Vx=double(V.x(line,col));
                Vy=double(V.y(line,col)); 

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
                % La génération de l'image prédite embrouillée
                Ip(line*16-15:line*16, col*16-15:col*16, :)=Iref(X:X+15, Y:Y+15, :);

    end
end

end
% IMAGE PREDITE AVEC EMBROUILLAGE