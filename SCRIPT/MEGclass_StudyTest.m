function theData = MEGclass_StudyTest(thePath,SubjectNumber,block,saveName,isMEG,use_eyetracker,is_debugging)


if isMEG
    boxNum = AG3getBoxNumber;  % buttonbox
else 
    boxNum = AG3getKeyboardNumber;  % buttonbox
end

    
if SubjectNumber < 10
    SubjStr = ['0' num2str(SubjectNumber)];
else
    SubjStr = num2str(SubjectNumber);
end

screenNumber = max(Screen('Screens'));
resolution=Screen('Resolution', screenNumber);
scrsz = [1 1 resolution.width, resolution.height];
coordsPicLeft = [scrsz(3)/2 - 120, 150 + scrsz(4)/2];
coordsPicRight = [scrsz(3)/2 + 120, 150 + scrsz(4)/2];
coords = {coordsPicLeft, coordsPicRight};

%use this to debug the code
if is_debugging
    BlankScreenDur = .01;
    RestDur = Inf;
    StimDur = .02;
    wordTime = .05;
    fixTime = .00;
    longfixTime = .02;
    TestDur = .01;
    TestLoop = 1;
    getReadyDur = 2;
    oddevenrepeats = 4;
    oddevenTime = 1;
else
    debugmode = 0;
    BlankScreenDur = .25;
    RestDur = Inf;
    StimDur = 3.5;
    wordTime = 1.5;
    fixTime = 1.0;
    longfixTime = 5.0;
    FixDur = 1.5;
    TestDur = 4;
    TestLoop = 1;
    getReadyDur = 3;
    oddevenrepeats = 4;
    oddevenTime = 1;
end


PTBSetIsDebugging(is_debugging);

basedir = pwd;
% set experiment paths
stimdir = [basedir '/stim/'];
stimlistdir = [basedir '/LIST/'];
datadir = [basedir '/Data/'];
subdir = [datadir SubjStr];
mkdir([datadir SubjStr])
if is_debugging
    Screen('Preference', 'SkipSyncTests', 1);
end

% set some defaults
PTBSetExitKey('q');
PTBSetBackgroundColor([0 0 0]);
PTBSetTextColor([255 255 255]);		% This defaults to white = (255, 255, 255).
PTBSetTextFont('Arial');		% This defaults to Courier.
PTBSetTextSize(30);

%this is to set up the PTB log files
cd(subdir);
PTBSetLogFiles(['S' SubjStr '_' num2str(block) '_log_file.txt'], ['S' SubjStr '_' num2str(block) '_data_file.txt']);
PTBSetLogHeaders({'condition','item','itempos','itemcolor','targetloc'});
cd(basedir);

% set some global variables
global PTBLastPresentationTime;			%#ok<NUSED> % When the last display was presented.
global PTBLastKeyPressTime;				  %#ok<NUSED> % When the last response was given.clear screen
global PTBLastKeyPress;						   % The last response given.
global PTBScreenRes;
global PTBWaitForKey;% Has 'width' and 'height' of current display in pixels

%% Set up inputs

%load in all the lists
cd(stimlistdir);
aL = load('allLists');
theList = aL.allLists{SubjectNumber};
theData = theList;

cd(basedir);

% start experiment
PTBSetupExperiment('MEGclass');

% we want to listen to character output
ListenChar(1);
HideCursor;

if isMEG==1
    PTBInitStimTracker;
    collection_type = 'Char';
    PTBSetInputCollection(collection_type);
    
    %get the devices attached
    [a b] = GetKeyboardIndices;
    
    %find the button box index and pass it to kbcheck so that kbcheck only listens
    %for the button box
    BBidx = a(strmatch('904',b));
else
    BBidx = -1;
end

if use_eyetracker
    PTBInitEyeTracker();
    paragraph = {'Eyetracker initialized.','Get ready to calibrate.'};
    PTBDisplayParagraph(paragraph, {'center',30}, {'any'});
    PTBCalibrateEyeTracker;
    % actually starts the recording
    % name corresponding to MEG file (can only be 8 characters!!, no extension)
    
    PTBStartEyeTrackerRecording(['MB' SubjStr '_' num2str(iBlock)]);
end

%instructions
instr = {'In this experiment, you will view a word paired with a picture.','Your task is to try and remember the picture paired with each word', 'You will then be tested on your memory for these pairings', 'Press any key to go on.'};
PTBDisplayParagraph(instr,{'center',30},{'any'});
PTBDisplayBlank({.3},'Blank');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Study1
%Get Ready
getReady = {['Get Ready: First Study Block #' num2str(block)], 'Press any key to start.'};
PTBDisplayParagraph(getReady,{'center',30},{'any'});
PTBDisplayBlank({.3},'Blank');

%Fixation
PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {fixTime}, 'flag');

thisBlock = find(theData.Test.mb==block);
for Trial = thisBlock(1):thisBlock(end)
    
    word = theData.Study1.word{Trial}(3:end);
    PTBDisplayText(word,{'center'},{wordTime});
    picture = [theData.Study1.pic{Trial}(3:end) '.jpg'];
    
    if (theData.Study1.cond(Trial)== 1);
        channel= 1;
    elseif (theData.Study1.cond(Trial)==2);
        channel = 2;
    elseif (theData.Study1.cond(Trial)==3);
        channel = 4;
    end
    PTBDisplayPictures({picture}, {'center'}, {1}, {StimDur}, 'flag', channel, 0);
    trialOnset = GetSecs;
    
    %Record onset time and channel used
    theData.Study1.trialOnset(Trial) = trialOnset;
    theData.Study1.channel(Trial) = channel;
    
    save([subdir '/' saveName '.mat'],'theData','theList')
    
    %Fixation
    PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {fixTime}, 'flag');
end


%% Study2
%Get Ready
getReady = {['Get Ready: Second Study Block #' num2str(block)], 'Press any key to start.'};
PTBDisplayParagraph(getReady,{'center',30},{'any'});
PTBDisplayBlank({.3},'Blank');

%Fixation
PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {fixTime}, 'flag');

thisBlock = find(theData.Test.mb==block);
for Trial = thisBlock(1):thisBlock(end)
    
    word = theData.Study2.word{Trial}(3:end);
    PTBDisplayText(word,{'center'},{wordTime});
    picture = [theData.Study2.pic{Trial}(3:end) '.jpg'];
    
    if (theData.Study2.cond(Trial)== 1);
        channel= 1;
    elseif (theData.Study2.cond(Trial)==2);
        channel = 2;
    elseif (theData.Study2.cond(Trial)==3);
        channel = 4;
    end
    PTBDisplayPictures({picture}, {'center'}, {1}, {StimDur}, 'flag', channel, 0);
    trialOnset = GetSecs;
    
    %Record onset time and channel used
    theData.Study2.trialOnset(Trial) = trialOnset;
    theData.Study2.channel(Trial) = channel;
    
    save([subdir '/' saveName '.mat'],'theData','theList')
    
    %Fixation
    PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {fixTime}, 'flag');
end


%%LONG FIXATION
PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {longfixTime}, 'flag');
 
%% Test
getReady = {['Get Ready: Test Block #' num2str(block)],'Face - Scene - Object', 'Press any key to start.'};
PTBDisplayParagraph(getReady,{'center',30},{'any'});
PTBDisplayBlank({.3},'Blank');
PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {fixTime}, 'flag');

thisBlock = find(theData.Test.mb==block);
for Trial = thisBlock(1):thisBlock(end)
    ons_start = GetSecs;
    
    %set up words and pictures
    word = theData.Test.word{Trial}(3:end);
   
    PTBDisplayPictures({'box.jpg'}, {'center'}, {1}, {-1}, 'flag');
    if (theData.Test.cond(Trial)== 1);
        channel= 1;
    elseif (theData.Test.cond(Trial)==2);
        channel = 2;
    elseif (theData.Test.cond(Trial)==3);
        channel = 4;
    end
    PTBDisplayText(word,{'center'},{TestDur}, channel, 0);
    trialOnset = GetSecs;
    
    %get response
    goTime = TestDur;
    [keys RT] = qkeys(ons_start,goTime,boxNum);
    
    %Fixation
    PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {fixTime}, 'flag');
    goTime = goTime + fixTime;
    [keysFix RTFix] = qkeys(ons_start,goTime,boxNum);
    
    %Record Responses
    theData.Test.trialOnset(Trial) = trialOnset;
    theData.Test.buttonPress{Trial} = keys;
    theData.Test.buttonPressFix{Trial} = keysFix;
    theData.Test.RT{Trial} = RT;
    theData.Test.RTFix{Trial} = RTFix;
    
    save([subdir '/' saveName '.mat'],'theData','theList')  
end


%% Validation 2AFC task
getReady = {['Get Ready: Specific Test Block #' num2str(block)],'Face - Scene - Object', 'Press any key to start.'};
PTBDisplayParagraph(getReady,{'center',30},{'any'});
PTBDisplayBlank({.3},'Blank');
PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {fixTime}, 'flag');

thisBlock = find(theData.Validation.mb==block);
for Trial = thisBlock(1):thisBlock(end)
    ons_start = GetSecs;
    
    %set up words and pictures
    word = theData.Validation.word{Trial}(3:end);
    picture = [theData.Validation.pic{Trial}(3:end) '.jpg'];
    altPicture = [theData.Validation.altPic{Trial}(3:end) '.jpg'];
    picLatCond = theData.Validation.picLatCond(Trial);
    
    %PTBDisplayPictures({'box.jpg'}, {'center'}, {1}, {-1}, 'flag');
    PTBDisplayPictures({picture}, {coords{picLatCond}}, {1}, {-1}, 'flag');
    PTBDisplayPictures({altPicture}, {coords{3-picLatCond}}, {1}, {-1}, 'flag');
    PTBDisplayText(word,{'center'},{TestDur}, channel, 0);
    trialOnset = GetSecs;
    
    %get response
    goTime = TestDur;
    [keys RT] = qkeys(ons_start,goTime,boxNum);
    
    %Fixation
    PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {fixTime}, 'flag');
    goTime = goTime + fixTime;
    [keysFix RTFix] = qkeys(ons_start,goTime,boxNum);
    
    %Record Responses
    theData.Validation.trialOnset(Trial) = trialOnset;
    theData.Validation.buttonPress{Trial} = keys;
    theData.Validation.buttonPressFix{Trial} = keysFix;
    theData.Validation.RT{Trial} = RT;
    theData.Validation.RTFix{Trial} = RTFix;
    
    save([subdir '/' saveName '.mat'],'theData','theList')  
end
    
    
%% Eyelink Stuff

if use_eyetracker
    
    % retrieve the file
    PTBDisplayText('Saving Data...', {'center', center}, {.1});
    PTBStopEyeTrackerRecording; % <----------- (can take a while)
    
    % move the file to the logs directory
    destination = ['logs'];
    movefile([subject, '_' num2str(iBlock), '.edf'], [destination filesep subject, '.edf'])
end


%Save Data Files
save([subdir '/' saveName '.mat'],'theData','theList');
save([subdir '/' saveName '_study.mat']);


PTBCleanupExperiment;
fclose('all');
sca; ShowCursor;

end

