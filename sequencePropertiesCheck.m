% Vérifie les propriétés des séquences

% Entrée:
% seq = la séquence
% m = degré du polynôme

% Sorties:
% Le résultat de la vérification et le graphe d'autocorrelation



function sequencePropertiesCheck(seq, m)

   L = length(seq);

   % Vérification de l'uniformité
   numOnes = sum(seq == 1);
   numZeros = L - numOnes;
   if abs(numOnes - numZeros) <= 1
       fprintf('La distribution des 1 et des 0 est uniforme (1s: %d, 0s: %d).\n', numOnes, numZeros);
   else
       fprintf('La distribution des 1 et des 0 n\''est pas uniforme (1s: %d, 0s: %d).\n', numOnes, numZeros);
   end
  
   % Calcul de l'autocorrélation de la séquence
   [autocorrSeq, lags] = xcorr(seq - mean(seq), 'unbiased');
  
   % Affichage de l'autocorrélation
   figure;
   stem(lags, autocorrSeq, 'filled');
   title('Autocorrélation de la séquence');
   xlabel('Décalage');
   ylabel('Autocorrélation');
   grid on;
  
   % Vérifier la propriété d'autocorrélation (le pic maximal au centre)
   centralPeak = max(autocorrSeq);
   autocorrSeq(lags == 0) = 0; % Ignorer le pic central pour cette vérification
   fprintf('Le pic d''autocorrelation central est : %f\n', centralPeak);
   fprintf('Le maximum hors pic est : %f\n', max(abs(autocorrSeq)));

end

