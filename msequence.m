
% Génère la m-séquence seq à partir du polynôme p(x)
% (implémentation de Galois, initialisation 0...01)

% Entrée:
% p = vecteur ligne contenant les coefficients du polynôme
% dans le sens des puissances croissantes
% (exemple: p(x) = 1 + x + x^3 --> p = [1 1 0 1] )

% Sorties:
% seq = séquence codée en -1/+1
% seqbin = séquence codée en 0/1
% L = Langueur de la séquence
% Message disant si ou non la longueur est maximale 
% (polynôme primitif ou pas)

function [seq, seqbin,L] = msequence(p)


% Détermination du degré du polynôme
m = length(p) - 1;

% Longueur maximale de la séquence
Lm = 2^m - 1;

% Initialisation du registre de décalage
r = [1, zeros(1, m-1)];

% Génération de la séquence
seqbin = zeros(1, Lm);

init_r = r; %registre initial pour la comparaison
for i=1:Lm
    if i>1 && all(r==init_r)
        seqbin=seqbin(1:i-1);
        break
    end
    % Stocker la dernière valeur du registre dans la séquence
    seqbin(i) = r(m);
    % Calculer la nouvelle valeur du registre en effectuant une somme pondéré des valeurs du registre actuel et en appliquant une opération de modulo 2
    retour = mod(sum(r .* p(2:end)), 2);
    r(2:end) = r(1:end-1);
    r(1) = retour;
    i=i+1;
end
% Convertir la séquence binaire en séquence de +1/-1
seq = 2 * seqbin - 1;

% Longueur réelle de la séquence
L = length(seq);

if L ~= Lm
fprintf('Attention! le Polynôme nétant pas primitif, la langueur de la séquence nest pas maximale!\n')
else
fprintf('La langueure de la séquence est maximale!\n')
end


end