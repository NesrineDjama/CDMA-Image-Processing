% Génère l'image originale envoyée à partir du message reconstruit 

% Entrée:
% msg = message reconstruit
% nbcoul = le nombre de couleur dans l'image (RGB ou niv de gris)

% Sorties:
% img = l'image reconstruite
% v_decimal = Les valeurs de chaque octet de l'image

function [img, v_decimal]=imgrec(msg, nbcoul)
  

    v=-msg/2 + 0.5;
    v=(reshape(v,[8, numel(v)/8]))';

 %transformer la matrice binaire en vecteur decimal
    v_decimal = (bin2dec(num2str(v)))';
    nblig = v_decimal(1);
    v_decimal=v_decimal(2:end);

 %calculer le nombre de colonnes
    nbcol=numel(v_decimal)/(nblig*nbcoul);

 %transformation de vecteur en matrice image
    v_decimal = reshape(v_decimal, [nblig,nbcol ,nbcoul]);
    img = uint8(v_decimal);

    
end