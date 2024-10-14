
% G�n�re la m-s�quence seq � partir du polyn�me p(x)
% (impl�mentation de Galois, initialisation 0...01)

% Entr�e:
% p = vecteur ligne contenant les coefficients du polyn�me
% dans le sens des puissances croissantes
% (exemple: p(x) = 1 + x + x^3 --> p = [1 1 0 1] )

% Sorties:
% seq = s�quence cod�e en -1/+1
% seqbin = s�quence cod�e en 0/1
% L = Langueur de la s�quence
% Message disant si ou non la longueur est maximale 
% (polyn�me primitif ou pas)

function [seq, seqbin,L] = msequence(p)


% D�termination du degr� du polyn�me
m = length(p) - 1;

% Longueur maximale de la s�quence
Lm = 2^m - 1;

% Initialisation du registre de d�calage
r = [1, zeros(1, m-1)];

% G�n�ration de la s�quence
seqbin = zeros(1, Lm);

init_r = r; %registre initial pour la comparaison
for i=1:Lm
    if i>1 && all(r==init_r)
        seqbin=seqbin(1:i-1);
        break
    end
    % Stocker la derni�re valeur du registre dans la s�quence
    seqbin(i) = r(m);
    % Calculer la nouvelle valeur du registre en effectuant une somme pond�r� des valeurs du registre actuel et en appliquant une op�ration de modulo 2
    retour = mod(sum(r .* p(2:end)), 2);
    r(2:end) = r(1:end-1);
    r(1) = retour;
    i=i+1;
end
% Convertir la s�quence binaire en s�quence de +1/-1
seq = 2 * seqbin - 1;

% Longueur r�elle de la s�quence
L = length(seq);

if L ~= Lm
fprintf('Attention! le Polyn�me n�tant pas primitif, la langueur de la s�quence nest pas maximale!\n')
else
fprintf('La langueure de la s�quence est maximale!\n')
end


end