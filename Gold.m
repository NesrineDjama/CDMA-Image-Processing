
% Génère la séquence de Gold correspondant à un décalage d
% à partir de deux m-séquences.
% Les polynômes générateurs des m-séquences sont polyA et polyB

% Entrées:
% polyA: vecteur ligne contenant les coefficients du polynôme
% générateur de la séquence A, dans le sens des puissances
% croissantes
% (exemple: A(x) = 1 + x + x^3 --> polyA = [1 1 0 1] )
% polyB: vecteur ligne contenant les coefficients du polynôme
% générateur de la séquence B, dans le sens des puissances
% croissantes
% d: décalage entre les deux séquences
% (goldbin(t) = seqA(t) + seqB(t+d) (mod 2))

% Sorties:
% gold: séquence de Gold codée en -1/+1
% goldbin: séquence de Gold codée en 0/1


function [gold, goldbin,N] = Gold(polyA, polyB, d)
    
    % Génération de deux séquences à partir d'un ou deux polynômes

  [~,An_bin,L_A]=msequence(polyA);
  [~,Bn_bin,L_B]=msequence(polyB);
    
    % Combiner les deux séquences avec un décalage donné

  Bnp=circshift(Bn_bin, [0,-d]);
  goldbin=mod(An_bin+Bnp,2);

    N=min(L_A, L_B);

    goldbin=goldbin(1:N);
    gold=goldbin*2-1;
    
end