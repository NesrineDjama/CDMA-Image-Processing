
% Transforme un vecteur binaire en un multiple de 8

% Entrée:
% msg = message reconstruit

% Sorties:
% msg = message reconstruit (divisible par 8)

function msg=octify(msg)


    %verifier la divisibilite de nombre d'elements dans le message binaire par 8
    elements_manquants = mod(numel(msg), 8);


    if elements_manquants ~= 0
        %ajouter des 0 a gauche du message pour qu'il soit divisible par 8
        msg = [zeros(1, 8-elements_manquants),msg_bin1];
    end

    
end