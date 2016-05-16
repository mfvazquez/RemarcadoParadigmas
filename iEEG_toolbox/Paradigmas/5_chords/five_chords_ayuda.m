% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5 CHORDS - Congruent/Incongruent final chord
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%
% INITIALIZE ENVIRONMENT
%%%%%%%%%%%%%%%%%%%%%%

%% Clear Matlab/Octave window:
clc;
clear all

%% Seteo del Experimento
% TrainSubject=1;
N_practice_trials=5;
Nrep=1; % Number of repetition

%Seteo del blink para intra
PHOTODIODE=true; %true= habilito los blinks, false= los inhabilito
pdpix=[100 50];
blink_left=[0 0 pdpix];

parallel_port=false;



%Codigo de marcas:
%1#: donde # es el numero de evento (archivo de audio --eventOrder(eventCount);
%Respuestas: 1 al 4. (teclado numerico del KeyBoard)

direc= pwd; % Path al experimento
% cd(direc)
%% Input de datos del sujeto

prompt = {'Apellido:','Nombre:', 'Edad: ', 'Sexo: (0=F 1=M)' };
dlg_title = 'Input';
answer = inputdlg(prompt,dlg_title);

apellido= char(answer(1));
nombre= char(answer(2));
edad= char(answer(3));
sexo= char (answer(4));

Info={nombre apellido edad sexo clock};

% prompt = {'Apellido:','Nombre:', 'Edad: ', 'Sexo: (0=F 1=M)' };
% dlg_title = 'Input';
% answer = inputdlg(prompt,dlg_title);
% 
% apellido= char(answer(1));
% nombre= char(answer(2));
% edad= char(answer(3));
% sexo= char (answer(4));
% 
% Info={nombre apellido edad sexo clock};


%% Inicializacion de variables

AssertOpenGL;

ListenChar(2)

% % Fotodiodo para registros intracraneales 
% PHOTODIODE=true;
% pdpix=[100 50];
% white = [1 1 1]*255;

PsychJavaTrouble

global hd 

%% Marcas para EEG Biosemi LPEN

% 
% Init Puerto Paralelo (io32.dll debe estar en la carpeta del proyecto y la 
% input32.dll en c:\windows\system32 y/o c:\windows\system)

% global pportobj pportaddr
% 
% pportaddr = 'C020';
% % pportaddr = '378';
% 
% if exist('pportaddr','var') && ~isempty(pportaddr)
%    
%     fprintf('Connecting to parallel port 0x%s.\n', pportaddr);
%     pportaddr = hex2dec(pportaddr);
%     pportobj = io32;
%     io32status = io32(pportobj);
%     io32(pportobj,pportaddr,0)
%     
%     if io32status ~= 0
%         error('io32 failure: could not initialise parallel port.\n');
%     end
%   
% end

%%  Load Audio

% Estímulos Auditivos
listMEB=dir(fullfile(direc, 'Stimuli','*.wav'));

cd([direc '\Stimuli'])

wavedata=cell(size(listMEB,1),1);

for nfile=1:size(listMEB,1)
    
    [x, freq] = wavread(listMEB(nfile).name);
    wavedata{nfile} = x'; %rotates sound matrix
%     wavedata{nfile}(2,:) = x'; %rotates sound matrix
%    nrchannels = size(wavedata{nfile},1);
    
end


for nfile1=1:size(listMEB,1)
    
    condit{1}=strfind(listMEB(nfile1,1).name, 'DD');
    condit{2}=strfind(listMEB(nfile1,1).name, 'SP');
    condit{3}=strfind(listMEB(nfile1,1).name, 'TC');
    
    index(nfile1) = find(~cellfun(@isempty,condit));
    
    stim_list{nfile1} = listMEB(nfile1,1).name;

end
index

%% Config Audio

% Init psychtoolbox sound
if ~isfield(hd,'pahandle')
    
    hd.f_sample = 44100;
    f_sample2=11000;
    fprintf('Initialising audio.\n');
    
    InitializePsychSound
    
    if PsychPortAudio('GetOpenDeviceCount') == 1
        PsychPortAudio('Close',0);
    end
    
    %Mac
    if ismac
        audiodevices = PsychPortAudio('GetDevices');
        outdevice = strcmp('Built-in Output',{audiodevices.DeviceName});
        hd.outdevice = 1;
    elseif ispc
        audiodevices = PsychPortAudio('GetDevices',3);
        if ~isempty(audiodevices)
            %DMX audio
            outdevice = strcmp('DMX 6Fire USB ASIO Driver',{audiodevices.DeviceName});
            hd.outdevice = 2;
        else
            %Windows default audio
            audiodevices = PsychPortAudio('GetDevices',2);
            outdevice = strcmp('Microsoft Sound Mapper - Output',{audiodevices.DeviceName});
            hd.outdevice = 3;
        end
    else
        error('Unsupported OS platform!');
    end
  
    audiodevices = PsychPortAudio('GetDevices');
    hd.pahandle = PsychPortAudio('Open',audiodevices(1,9).DeviceIndex,[],1,hd.f_sample,2);
    PsychPortAudio('Volume', hd.pahandle , 1.25);
%     pahandle2 = PsychPortAudio('Open',audiodevices(1,3).DeviceIndex,[],1,f_sample2,2);
%     PsychPortAudio('Volume', pahandle2 , 1.25);
    
%     InitializePsychSound(1);
    
%     hd.pahandle = PsychPortAudio('Open',audiodevices(outdevice).DeviceIndex,[],[0],hd.f_sample,2);
%       hd.pahandle = PsychPortAudio('Open',audiodevices(outdevice).DeviceIndex);
%       hd.pahandle = PsychPortAudio('Open',audiodevices(outdevice).DeviceIndex,1,1,hd.f_sample,1);
%     hd.pahandle = PsychPortAudio('Open',audiodevices(1,5).DeviceIndex);
end

%% Load Image
% 
% im{1}=imread('ChanLoc_name.png');
% % image(im{1})

%% Load Video
% 
% moviefile{1}='CAM00257.mp4';

%% Setup psychtoolbox display


hd.bgcolor = [0 0 0] ;
hd.dispscreen = 0;
hd.itemsize = 100;
hd.wsize = (hd.itemsize/2)+30;
hd.textsize = 30;
hd.textfont = 'Helvetica';
hd.textcolor = [255 255 255];%[255 255 255]
hd.ontime = 150/1000;
hd.offtime = 850/1000;

blacktime=500/1000;
debounce=100/1000;

Screen('Preference', 'ConserveVRAM', 64);  %agregado
Screen('Preference', 'Verbosity', 0);
Screen('Preference', 'SkipSyncTests',1);
Screen('Preference', 'VisualDebugLevel',0);
Screen('Preference', 'ConserveVRAM', 64);

Screen('Preference', 'VBLTimestampingMode', 1);
Screen('Preference', 'TextRenderer', 1);
Screen('Preference', 'TextAntiAliasing', 2);
Screen('Preference', 'TextAlphaBlending',1);


% Open Psychtoolbox main window

[window,scrnsize] = Screen('OpenWindow', hd.dispscreen, hd.bgcolor);
hd.window = window;
hd.centerx = scrnsize(3)/2;
hd.centery = scrnsize(4)/2;
hd.bottom = scrnsize(4);
hd.right = scrnsize(3);

% Adjust requested SOA so that it is an exact multiple of the base refresh
% interval of the monitor at the current refresh rate.

refreshInterval = Screen('GetFlipInterval',hd.window);
hd.ontime = ceil(hd.ontime/refreshInterval) * refreshInterval;
hd.offtime = ceil(hd.offtime/refreshInterval) * refreshInterval;
fprintf('\nUsing ON time of %dms with OFF time of %dms.\n', round(hd.ontime*1000), round(hd.offtime*1000));
Screen('TextSize',hd.window,hd.textsize);
Screen('TextFont',hd.window,hd.textfont);

% Get screenNumber of stimulation display. We choose the display with
% the maximum index, which is usually the right one, e.g., the external
% display on a Laptop:
screens         = Screen('Screens');
whichScreen     = max(screens);


% % Make sure keyboard mapping is the same on all supported operating systems
% % Apple MacOS/X, MS-Windows and GNU/Linux:

%KbName('UnifyKeyNames');

%Screen settings

[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Define black, white and grey
black = BlackIndex(whichScreen);
white = WhiteIndex(whichScreen);
grey = white / 2;

% % Seteo del fotodiodo
% two_blinks=[0 0 pdpix; screenXpixels-pdpix(1) 0 screenXpixels pdpix(2)];
% blink_left=[0 0 pdpix];
% blink_right=[screenXpixels-pdpix(1) 0 screenXpixels pdpix(2)];

HideCursor;
 %% Response Buttons
 
% respB(1)=KbName('1');
% respB(2)=KbName('2');
% respB(3)=KbName('3');
% respB(4)=KbName('4');

% respB(1)=97;
% respB(2)=98;
% respB(3)=99;
% respB(4)=95; 
 
%% Comienzo del programa
%% Text

% Instrucciones
line1 = 'Ahora comienza la tarea';
line2 = '\n\n';
line3 = '\n\n Presione una tecla cuando esté listo';

% Draw all the text in one go
Screen('TextSize', window, 40);
DrawFormattedText(window, [line1 line2 line3],...
    'center', screenYpixels * 0.25, white, [] , [], [], 1.5);

% Flip to the screen
Screen('Flip', window);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo
% KbStrokeWait;

KeyCode(27) = 0;
Continuar   = 0;

while Continuar == 0 % Se queda en este loop hasta que presione cualquier tecla para continuar o esc para salir;
    
    [~,~,KeyCode] = KbCheck;
    WaitSecs(0.001);
    if KeyCode(27) == 1  % Salgo del programa con esc
        
        ListenChar(0)       
        
        % Close the audio device:
        PsychPortAudio('Close', hd.pahandle);
        Screen('CloseAll');
        
    elseif ~all(~KeyCode)
        
        Continuar = 1;
        
    end
    
end

DrawFormattedText(window, '+','center', screenYpixels * 0.5, white);

Screen('Flip', window);

%% Presentación de estímulos

% eventOrder=[1 2 3 4];

options='Congruente o Incongruente';

eventOrder=1:size(wavedata,1);

wave_dd={'Fis_TC.wav','Exmpl_SP.wav','Exmpl_DD.wav','F_TC.wav','G_SP.wav','Gis_TC.wav','Ais_SP.wav','A_SP.wav','Ais_TC.wav','H_SP.wav','D_SP.wav','Gis_DD.wav','G_DD.wav','Ais_DD.wav','C_TC.wav','E_SP.wav','Fis_SP.wav','C_SP.wav','Gis_SP.wav','Exmpl_TC.wav','Cis_TC.wav','E_TC.wav','Fis_DD.wav','Cis_SP.wav','H_DD.wav','C_DD.wav','H_TC.wav','E_DD.wav','D_TC.wav','F_DD.wav','G_TC.wav','A_DD.wav','Cis_DD.wav','D_DD.wav','A_TC.wav','F_SP.wav';};
for i=1:36
    eventOrder(i)=find(strcmp([stim_list], wave_dd{i}));
end
%eventOrder=eventOrder(randperm(length(eventOrder)));

eventCount=1;


startSecs=GetSecs;



resp_time=[4.38754174773931;4.56211849729516;0.794433064635996;0.429588402574154;0.482218991211994;0.477257157518579;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;3.84236353139931;0.383957322158494;];
for i=1:size(eventOrder,2)
  
    
       PsychPortAudio('FillBuffer', hd.pahandle, wavedata{eventOrder(eventCount),1});    % Fill the audio playback buffer with the audio data 'wavedata':
           t1 = PsychPortAudio('Start', hd.pahandle, 1, 0, 1);
        
        stimuli_time= GetSecs;
        
        if parallel_port
            enviar_marca(100+eventOrder(eventCount));
        end
        
        if PHOTODIODE
            Screen('FillRect', window ,255, blink_left);
            Screen('Flip', window, 0 , 1);
            waitsecs(0.1);
            Screen('FillRect', window ,0, blink_left);
            Screen('Flip', window, 0 , 1);
            % [startTime endPositionSecs xruns estStopTime] = PsychPortAudio('Stop', pahandle [, waitForEndOfPlayback=0] [, blockUntilStopped=1] [, repetitions] [, stopTime]);
        end
        
        PsychPortAudio('Stop', hd.pahandle, 1,0);

        Screen('TextSize', window, 40);
        DrawFormattedText(window, options,...
            'center', screenYpixels * 0.20, white);

        Screen('Flip', window);

        tr_time=GetSecs;
        
        waitsecs(resp_time(i));

%          while GetSecs < tr_time + 10  %key can be pressed for response during this wait time.
%                                                  
%                         keyCode(27) =0;
%                         [ keyIsDown, seconds, keyCode ] = KbCheck;
%                         
%                         if keyCode(27) == 1  % Salgo del programa con esc
%                             
%                             %Salgo del programa
%                             
%                             PsychPortAudio('Close',hd.pahandle);
% %                             PsychPortAudio('Close',pahandle2);
%                             Screen('CloseAll'); % Cierro ventana del Psychtoolbox
%                             save([direc '\' apellido nombre 'ESC_log.mat'])
%                             
%                             ShowCursor;
%                             ListenChar(1);
%                             
%                         end
%                         if keyIsDown                %if any key is pressed, first GetSecs value is stored in keyTime for this trial
%                             if parallel_port
%                                 enviar_marca(find(keyCode));
%                             end
%                             if PHOTODIODE   %blink de respuesta
%                                 Screen('FillRect', window ,255, blink_left);
%                                 Screen('Flip', window, 0 , 1);
%                                 waitsecs(0.1);
%                                 Screen('FillRect', window ,0, blink_left);
%                                 Screen('Flip', window, 0 , 1);
%                                 % [startTime endPositionSecs xruns estStopTime] = PsychPortAudio('Stop', pahandle [, waitForEndOfPlayback=0] [, blockUntilStopped=1] [, repetitions] [, stopTime]);
%                             end
%         
%                             log.Trials(i,2) = seconds - tr_time;
%                             log.Trials(i,3) = find(keyCode);
% %                             if log.Trials(i,3)==respB(1), log.Trials(i,4)=1; elseif log.Trials(i,3)==respB(2), log.Trials(i,4)=2; ...
% %                             elseif log.Trials(i,3)==respB(3), log.Trials(i,4)=3; elseif log.Trials(i,3)==respB(4), log.Trials(i,4)=4; ...
% %                             end
%                             
%                         end
%             if keyIsDown, break, end
%          end   
%          
%          log.Trials(i,1) = seconds; %stores time key is pressed
% 
%          log.Trials(i,4)=index(eventOrder(eventCount));
%          
          log.Trials(i,6) = GetSecs;
          log.Trials(i,5) = stimuli_time;
         
         
%          if log.Trials(i,4)==log.Trials(i,5), log.Trials(i,6)=1; else log.Trials(i,6)=0; end
         
    DrawFormattedText(window, '+','center', screenYpixels * 0.5, white);

    Screen('Flip', window);
         
    eventCount=eventCount+1;
    WaitSecs(3);
    
end

% score=nanmean(log.Trials(:,6),1);
% disp(['Score: ' num2str(score)])

log.Info=Info;
stim_list{nfile1} = listMEB(nfile1,1).name;

Stim_order = stim_list(eventOrder);
log.Stimuli = Stim_order;

% log.Score=score;
%Guardo los datos en el archivo log
save([direc '\' apellido nombre '_log.mat'],'log');

%Salgo del programa

PsychPortAudio('Close',hd.pahandle);
% PsychPortAudio('Close',pahandle2);
Screen('CloseAll'); % Cierro ventana del Psychtoolbox

ShowCursor;
ListenChar(1);


% catch
%   disp('Error')  
%     
%     ListenChar(1);
% 
% 
%     PsychPortAudio('Close',hd.pahandle);
%     PsychPortAudio('Close',pahandle2);
%     Screen('CloseAll'); % Cierro ventana del Psychtoolbox
% end
sca
