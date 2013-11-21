function MEGclassrun(thePath)

if nargin == 0
    error('Must specify thePath')
end

KbName('UnifyKeyNames');


% WAB: Might wanna take this out, just makes the matlab screen stuff work
 Screen('Preference', 'SkipSyncTests', 1);

%% Take some inputs and specify some variables
sName = input('Enter date as string (using single quotes): ');
sNum =  input('Enter subject number: ');
expPhase = 'S';
if strcmp(expPhase,'S')
        block = input('Enter start block number: ');
end
% S.scanner = 0; We shouldn't need this?
S.YadjustmentFactor =  0; %input('Enter adjustment factor (e.g., -98): ');
S.scanner = 2; % input('In scanner [1] or behavioral [2] ? ');
isMEG = input('In MEG [1] or behavioral [0] ? ');
use_eyetracker = 0; % input('Using eyetracker [1] or no eyetracker [0] ? ');
is_debugging = input('debugging [1] or not debugging [0] ? ');
S.OS = 'mac'; % input('mac or pc? ','s');

if strcmp(S.OS,'mac');
    % Set input device (keyboard or buttonbox)  
    if S.scanner == 1
        S.boxNum = getBoxNumber;  % buttonbox
        S.kbNum = BH1getKeyboardNumber; % keyboard
    else % Behavioral 
         S.boxNum = BH1getKeyboardNumber;  % buttonbox
         S.kbNum = BH1getKeyboardNumber; % keyboard
    end
else
        S.boxNum = 0;
        S.kbNum = 0; 
end
    
%% Specify some screen commands
% % S is a variable that gets passed to the scripts for each phase
% S.triggerKey = KbName('5%');     % key to start scanner
% S.quitKey = KbName('q');        % key to abort
% S.continueKey = KbName('c');    % key to continue to the next block

if S.scanner==1
    S.screenNumber = 1;
else
    S.screenNumber = 0;
end
%  S.screenColor = 0;
%  S.textColor = 255;  % 110209 changed from 0 to 255
%  S.endtextColor = 255;
%  S.cueTextSize = 32;  % the size of the font that the cue word appears.  It's
%  % also the size that the messages (e.g., 'get ready' will appear in)
%  S.imageNameTextSize = 20; % size of the font for the label underneath each image
%  S.numTextSize = 50; % size of the font for the label underneath each image
%  S.font = 'Arial';
% [S.Window, S.myRect] = Screen(S.screenNumber, 'OpenWindow', S.screenColor, [], 32);
%  Screen('TextSize', S.Window, 24);
%  Screen('TextStyle', S.Window, 1);
% S.on = 1;  % Screen now on

%% Start appropriate phase

if (strcmp(expPhase,'S')) 
    while block < 26
     saveName = ['MEGclass_sub' num2str(sNum) '_' sName  '_StudyTest'];
     study.theData = MEGclass_StudyTest(thePath,sNum,block,saveName,isMEG,use_eyetracker,is_debugging);
     block = block +1;
    end
end   

        
%% End
% message = 'End of script. Press any key to exit.';
% 
% DrawFormattedText(S.Window,message,'center','center',S.endtextColor);
% Screen(S.Window,'Flip');
pause; % pause until user response
clear screen;
end

