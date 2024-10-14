
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                 %              Main du signal Difficile                %
                 %   BELMIR El-myria   et   DJAMA Meriem Nesrine        %
                 %      e22307955                 e22307544             %
                 %                   2023/2024                          %
                 %                   M1 E3A ST                          %
                 %TAL Traitement du Signal dans les Réseaux de Capteurs %                                                                          %             
                 %                    Groupe 1                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc 
close all
clear

nbcoul = 3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Charger le fichier SignalRecu_facile.mat qui contient le signal reçu
load SignalRecu.mat;

% Convertir le vecteur au format réel pour pouvoir l'utiliser
SignalRecu = single(SignalRecu);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Définir les polynômes utilisés pour la séquence de Gold et la synchro
A = [1 0 0 1 0 1]; % A(x) = 1 + x^2 + x^5
B = [1 0 1 1 1 1]; % B(x) = 1 + x + x^2 + x^3 + x^5
C = [1 1 1 0 0 1 1]; % C(x) = 1 + x + x^4 + x^5 + x^6

%Calculer les sequences de gold
[cap1, cap1_bin, L1] = Gold(A,B,1);
[cap2, cap2_bin, L2] = Gold(A,B,2);

[seq_A, seqbin_A, La] = msequence(A);
[seq_B, seqbin_B, Lb] = msequence(B);
[seq_C, seqbin_C, Lc] = msequence(C);


%  Vérification des Propriétés des m-Séquences
sequencePropertiesCheck(seq_A, La-1);
sequencePropertiesCheck(seq_B, Lb-1);
sequencePropertiesCheck(seq_C, Lc-1);
sequencePropertiesCheck(cap1, L1-1);
sequencePropertiesCheck(cap2, L2-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Faire la corrélation croisée entre la séquence A et le signal reçu
cor1 = conv(fliplr(cap1), SignalRecu);
cor1_abs = abs(cor1);

cor2 = conv(fliplr(cap2), SignalRecu);
cor2_abs = abs(cor2);

 figure
 subplot(2,1,1)
 hist1 = histogram(cor1_abs(1:10e6));
 title('L’histogramme des modules en sortie du corrélateur ''pour capteur 1','FontSize',9);
grid on;
 subplot(2,1,2)
 hist2 = histogram(cor2_abs(1:10e6));
 title('L’histogramme des modules en sortie du corrélateur''pour capteur 2','FontSize',9);
grid on;

seuil1 = 27;
seuil2 = 23;

% Trouver les indices des valeurs absolues des corrélations croisées supérieures au seuil
indices1 = find(cor1_abs > seuil1);
val1 = cor1(indices1);
symbol1 = sign(val1);
corC1 = filter(seq_C(Lc:-1:1), 1, symbol1);
corCabs1 = abs(corC1);

indices2 = find(cor2_abs > seuil2);
val2 = cor2(indices2);
symbol2 = sign(val2);
corC2 = filter(seq_C(Lc:-1:1), 1, symbol2);
corCabs2 = abs(corC2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Afficher les résultats de la corrélation croisée de la séquence Sync
 figure
 subplot(2,1,1)
 stem1=stem(corCabs1);
 title('Detection de la syncro image pour capteur 1','FontSize',9);
 xlim([0 300]);
grid on;
 subplot(2,1,2)
 stem2=stem(corCabs2);
 title('Detection de la syncro image pour capteur 2','FontSize',9);
 xlim([0 300]);
grid on;


%trouver le debut et la fin des sequences des synchronisation par correlion
start_index1 = find(conv(symbol1, fliplr(seq_C))==Lc);
end_index1 = find(conv(symbol1, fliplr(-seq_C))==Lc);

start_index2 = find(conv(symbol2, fliplr(seq_C))==Lc);
end_index2 = find(conv(symbol2, fliplr(-seq_C))==Lc);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


msg1 = msg_construct(symbol1, start_index1, end_index1, Lc);
msg2 = msg_construct(symbol2, start_index2, end_index2, Lc);


[image1,v_decimal1]=imgrec(msg1,nbcoul);
[image2,v_decimal2]=imgrec(msg2,nbcoul);



figure
subplot(2,1,1)
imshow(image1);
title('Image Reconstruite 1');
subplot(2,1,2)
imshow(image2);
title('Image Reconstruite 2');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


                        % Merci d'avoir utilisé notre programme :D %