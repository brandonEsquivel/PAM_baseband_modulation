%     Tarea 1 - IE-1116 - 25/03/19    Brandon Esquivel Molina - B52571 %
% clc;
% clear;

% NOTA: El script se realizó en Matlab online por lo que las carpetas de destino pueden generar error, o los archivos
% cargados.


[deep_HQ1,fsHQ] = audioread("Archivos de Audio/Deep _HQ_1min.wav");
[deep_LQ,fsLQ] = audioread("Archivos de Audio/DeepNorm_bajoFS.wav");
n_HQ = length(deep_HQ1);
n_LQ = length(deep_LQ);

%  Cortar a 20 s y reproducir:
deep_HQ = deep_HQ1(1:n_HQ*0.333333);
sound(deep_HQ,fsHQ,16);
pause(20);
sound(deep_LQ,fsLQ,8);

% Se puede notar que el sonido es muy diferente, ahora se  le asigna a
% deep_LQ fsHQ como frec de muestreo.

Bem = fsLQ/fsHQ;
deep_LQ_render = deep_LQ(1:Bem:end);
sound(deep_LQ_render,fsHQ,16);

%  Normalizacion

 Min_deep_HQ = min(deep_HQ);
 pos_deep_HQ = deep_HQ - Min_deep_HQ; 
 Max_deep_HQ = max(pos_deep_HQ);
 deep_HQ_Norm = pos_deep_HQ/Max_deep_HQ;
 
 Min_deep_LQ = min(deep_LQ_render);
 pos_deep_LQ = deep_LQ_render - Min_deep_LQ; 
 Max_deep_LQ = max(pos_deep_LQ);
 deep_LQ_Norm = pos_deep_LQ/Max_deep_LQ;
 
sound(deep_HQ_Norm,fsHQ,24);
pause(1);
sound(deep_LQ_Norm,fsHQ,24);

subplot(2,1,1);
plot(deep_HQ_Norm);
title("HQ");

subplot(2,1,2);
plot(deep_LQ_Norm);
title("LQ");


%  Obtener RMS %

rms_HQ = rms(deep_HQ_Norm);
rms_LQ = rms(deep_LQ_Norm);
Meb = rms_LQ/rms_HQ;

subplot(3,1,1);
plot(deep_HQ_Norm);
title("HQ");

subplot(3,1,2);
plot(deep_LQ_Norm);
title("LQ");

subplot(3,1,3);
plot(deep_LQ_Norm*0.7980682275);
title("LQ");

sound(deep_HQ_Norm,fsHQ,24);
sound(deep_LQ_Norm*0.7980682275,fsHQ,24);

m_HQ = median(deep_HQ_Norm);
sound(deep_LQ_Norm*m_HQ,fsHQ,24);

