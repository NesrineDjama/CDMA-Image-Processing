
% Génère le message reconstruit à partir du train symboles et 
% du sygnal de syncronisation

% Entrée:
% symboles = Train de symboles récupéré par le capteur
% start_index = Début du message
% end_index = Fin du message
% L_sync = Langueur de la séquence de synchronisation

% Sorties:
% msg = message reconstruit



function msg=msg_construct(symbols,start_index,end_index,L_sync)

%retrouver les symboles utiles d'apartir des indexes
    msg = symbols(start_index+1:end_index-L_sync);

    msg = mod((msg + 1)/2 ,2);%transformer le message en 0 et 1
    msg = msg(:)'; % Convertir le msg en une ligne vectorielle

%ajouter des 0 a gauche du message pour qu'il soit divisible par 8 si necessaire
    msg = octify(msg); 
    msg = msg*2-1;%retransformer le message en -1 et 1

end