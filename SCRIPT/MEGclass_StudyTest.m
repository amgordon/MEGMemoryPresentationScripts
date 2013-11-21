function theData = MEGclass_StudyTest(thePath,SubjectNumber,block,saveName,isMEG,use_eyetracker,is_debugging)

% if SubjectNumber < 10
%     SubjStr = ['0' num2str(SubjectNumber)];
% else
%     SubjStr = num2str(SubjectNumber);
% end
% basedir = pwd;


% % set experiment paths
% encdir = [basedir];
% 
% imagedir = [basedir '/stim/']; addpath(genpath(imagedir));
% 
% datadir = [basedir '/Data/'];
% 
% subdir = [datadir SubjStr];
% 
% mkdir([datadir SubjStr])
%set subject directory and numbe
if SubjectNumber < 10
    SubjStr = ['0' num2str(SubjectNumber)];
else
    SubjStr = num2str(SubjectNumber);
end

%use this to debug the code
if is_debugging
    BlankScreenDur = .01;
    RestDur = Inf;
    StimDur = .2;
    wordTime = .5;
    fixTime = 1.0;
    longfixTime = 2.0;
    TestDur = 1;
    TestLoop = 1;
    getReadyDur = 2;
    oddevenrepeats = 4;
    oddevenTime = 1;
else
    debugmode = 0;
    BlankScreenDur = .25;
    RestDur = Inf;
    StimDur = 2.5;
    wordTime = .5;
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
 onekey = KbName('1!'); %remeber
 twokey = KbName('2@'); %dont remember
 %threekey = KbName('3#'); %object
 %fourkey = KbName('4$'); %not sure


    %load in all the lists 
    cd(stimlistdir);
    checkname = [saveName '.mat'];
    if exist(checkname)
        load(checkname)
        Study1Length = length(theList.Study1);
        Study2Length = length(theList.Study2);
        TestLength = length(theList.Test);
        clear lists
    else

    load allLists
    theList.Study1 = lists{SubjectNumber}.Study1;
    Study1Length = length(theList.Study1);
    theList.Study2 = lists{SubjectNumber}.Study2;
    Study2Length = length(theList.Study2);
    theList.Test = lists{SubjectNumber}.Test;
    TestLength = length(theList.Test);
    clear lists
    
    theData.Study1.condition = theList.Study1(1,:);
    theData.Study1.conID = theList.Study1(2,:);
    theData.Study1.word = theList.Study1(5,:);
    theData.Study1.wordID = theList.Study1(3,:);
    theData.Study1.image = theList.Study1(6,:);
    theData.Study1.imageID= theList.Study1(4,:);
    theData.Study1.miniblock = theList.Study1(7,:);
    theData.Study1.category = theList.Study1(8,:);
    
    theData.Study2.condition = theList.Study2(1,:);
    theData.Study2.conID = theList.Study2(2,:);
    theData.Study2.word = theList.Study2(5,:);
    theData.Study2.wordID = theList.Study2(3,:);
    theData.Study2.image = theList.Study2(6,:);
    theData.Study2.imageID= theList.Study2(4,:);
    theData.Study2.miniblock = theList.Study2(7,:);
    theData.Study2.category = theList.Study2(8,:);
    
    theData.Test.condition = theList.Test(1,:);
    theData.Test.conID = theList.Test(2,:);
    theData.Test.word = theList.Test(5,:);
    theData.Test.wordID = theList.Test(3,:);
    theData.Test.image = theList.Test(6,:);
    theData.Test.imageID= theList.Test(4,:);
    theData.Test.miniblock = theList.Test(7,:);
    theData.Test.category = theList.Test(8,:);
    end
    cd(basedir);




try
    % start experiment
    PTBSetupExperiment('MEGclass');
    
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
    

    
%     %initiate encoding output data
%     study1DataFile = cell(Study1Length+1,8);
%     study1DataFile{1,1} = 'trialnum';
%     study1DataFile{1,2} = 'trialID';
%     encodingDataFile{1,3} = 'time';
%     encodingDataFile{1,4} = 'respTime';
%     encodingDataFile{1,5} = 'RT';
%     encodingDataFile{1,6} = 'resp';
%     
%     %initiate test output data
%     testDataFile = cell(23,10);
%     testDataFile{1,1} = 'trialnum';
%     testDataFile{1,2} = 'itemTrialID';
%     testDataFile{1,3} = 'TOCorrectTrialID';
%     testDataFile{1,4} = 'TOIncorrectTrialID';
%     testDataFile{1,5} = 'time';
%     testDataFile{1,6} = 'respTime';
%     testDataFile{1,7} = 'RT';
%     testDataFile{1,8} = 'resp';
%     testDataFile{1,9} = 'boundType';
%     testDataFile{1,10} = 'itemEncodingColor';
%     testDataFile{1,11} = 'TOPosCbal';
%     testDataFile{1,11} = 'LurePosition';
%     
%     
    
    %instructions
    instr = {'In this experiment, you will view a word paired with a picture.','Your task is to try and remember the picture paired with each word', 'You will then be tested on your memory for these pairings', 'Press any key to go on.'};
    PTBDisplayParagraph(instr,{'center',30},{'any'});
    PTBDisplayBlank({.3},'Blank');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %% Study1    
    %Get Ready
    PTBSetTextSize(30);
    getReady = {['Get Ready: First Study Block #' num2str(block)], 'Press any key to start.'};
    PTBDisplayParagraph(getReady,{'center',30},{'any'});
    PTBDisplayBlank({.3},'Blank');
    
    %Fixation
    PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {fixTime}, 'flag');

    for Trial = 1:Study1Length
        if (theData.Study1.miniblock{Trial}==block)
            PTBSetTextColor([255 255 255]);
            PTBSetTextSize(33);
            word = theData.Study1.word{Trial}(3:end);
            PTBDisplayText(word,{'center'},{wordTime});
            picture = [theData.Study1.image{Trial}(3:end) '.jpg'];
            if strcmp(theData.Study1.condition(Trial),'F')== 1;
                channel= 1;
            elseif strcmp(theData.Study1.condition(Trial),'S')== 1;
                channel = 2;
            elseif strcmp(theData.Study1.condition(Trial),'O')== 1;
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
             
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Study2
    %Get Ready
    PTBSetTextSize(30);
    getReady = {['Get Ready: Second Study Block #' num2str(block)], 'Press any key to start.'};
    PTBDisplayParagraph(getReady,{'center',30},{'any'});
    PTBDisplayBlank({.3},'Blank');
    
    %Fixation
    PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {fixTime}, 'flag');
    
    for Trial = 1:Study2Length
        if (theData.Study2.miniblock{Trial}==block)
            PTBSetTextColor([255 255 255]);
            PTBSetTextSize(33);
            word = theData.Study2.word{Trial}(3:end);
            PTBDisplayText(word,{'center'},{wordTime});
            picture = [theData.Study2.image{Trial}(3:end) '.jpg'];
             if strcmp(theData.Study2.condition(Trial),'F')== 1;
                channel= 1;
            elseif strcmp(theData.Study2.condition(Trial),'S')== 1;
                channel = 2;
            elseif strcmp(theData.Study2.condition(Trial),'O')== 1;
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
             
    end
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    %LONG FIXATION

                 PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {longfixTime}, 'flag');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
   %% Test
    %Get Ready
    PTBSetTextSize(30);
    getReady = {['Get Ready: Test Block #' num2str(block)],'Remember - Forgot', 'Press any key to start.'};
    PTBDisplayParagraph(getReady,{'center',30},{'any'});
    PTBDisplayBlank({.3},'Blank');
    
    %blockcorrect = 0;
    %Fixation
    PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {fixTime}, 'flag');
    
    for Trial = 1:TestLength
        if (theData.Test.miniblock{Trial}==block)
            PTBSetTextColor([255 255 255]);
             PTBSetTextSize(33);
            word = theData.Test.word{Trial}(3:end);
            PTBDisplayPictures({'box.jpg'}, {'center'}, {1}, {-1}, 'flag');
            if strcmp(theData.Test.condition(Trial),'F')== 1;
                channel= 8;
            elseif strcmp(theData.Test.condition(Trial),'S')== 1;
                channel = 16;
            elseif strcmp(theData.Test.condition(Trial),'O')== 1;
                channel = 32;
            end
            PTBDisplayText(word,{'center'},{TestDur}, channel, 0);
            trialOnset = GetSecs; 
            
            %get response
            resp = 0;
            RT = 0;
            respTime = 0;
             while GetSecs - trialOnset < TestDur
            
            [keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
            if keyIsDown
                if strcmp(kbname(keyCode),'p')
                    pause(.1)
                    while 1
                        [keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
                        if keyIsDown
                            if strcmp(kbname(keyCode),'p')
                                resp = 'p';
                                clear keyIsDown
                                pause(.1)
                                break
                            end
                        end
                    end 
                elseif sum(keyCode)==1
                     if keyCode(onekey)
                            resp = 1;
                    elseif keyCode(twokey)
                        resp = 2;
%                     elseif keyCode(threekey)
%                         resp = 3;
%                     elseif keyCode(fourkey)
%                         resp = 4;
                        
                    end
                end
                respTime = TimeSecs;
                RT = TimeSecs - trialOnset;

            end
            
        end
    
            

        
        %Fixation
         PTBDisplayPictures({'fix.jpg'}, {'center'}, {1}, {fixTime}, 'flag');
 
         
        %continue collecting while fixation is up
         while (GetSecs - trialOnset) < (fixTime + TestDur)
            
            [keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
            if keyIsDown
                if strcmp(kbname(keyCode),'p')
                    pause(.1)
                    while 1
                        [keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
                        if keyIsDown
                            if strcmp(kbname(keyCode),'p')
                                resp = 'p';
                                clear keyIsDown
                                pause(.1)
                                break
                            end
                        end
                    end 
                elseif sum(keyCode)==1
                    if keyCode(onekey)
                            resp = 1;
                    elseif keyCode(twokey)
                        resp = 2;
%                     elseif keyCode(threekey)
%                         resp = 3;
%                     elseif keyCode(fourkey)
%                         resp = 4;  
                    end
                end
                respTime = TimeSecs;
                RT = TimeSecs - trialOnset;

            end
            
         end
         
            %Record Responses
            theData.Test.trialOnset(Trial) = trialOnset;
            theData.Test.channle(Trial) = channel;
            theData.Test.buttonPress(Trial) = resp;
            theData.Test.RT(Trial) = RT;
            theData.Test.timeofresponse(Trial) = respTime;
            
            %calulate if correct

            theData.Test.buttonpress(Trial) = resp;
            if resp == 1
                theData.Test.remember(Trial)= 1;
                theData.Test.forgot(Trial) = 0;
            elseif resp == 2
                theData.Test.forgot(Trial) = 1;
                theData.Test.remember(Trial) = 0;
            else
                theData.Test.forgot(Trial) = 0;
                theData.Test.remember(Trial) = 0;
                
            end
            
            save([subdir '/' saveName '.mat'],'theData','theList')
         
        end
             
    end
    
    
   % theData.Test.blockaccuracy(block) = blockcorrect/.12;
    

    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Eyelink file
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if use_eyetracker
        
        % retrieve the file
        PTBDisplayText('Saving Data...', {'center', center}, {.1});
        PTBStopEyeTrackerRecording; % <----------- (can take a while)
        
        % move the file to the logs directory
        destination = ['logs'];
        movefile([subject, '_' num2str(iBlock), '.edf'], [destination filesep subject, '.edf'])
    end

    %% DISPLAY ACCURACY 
    PTBSetTextSize(30);
    endblock = {'End of block.','Press any key to go to next block.'};
    PTBDisplayParagraph(endblock,{'center',30},{'any'});
    PTBDisplayBlank({.1},'Final Screen');
    
catch %#ok<CTCH>
%    cd /Volumes/davachilab/MEGbound_freeRecall/
    PTBHandleError;
    
end

%Save Data Files
     save([subdir '/' saveName '.mat'],'theData','theList');
     save([subdir '/' saveName '_study.mat']);


PTBCleanupExperiment;
fclose('all');
%unix(['mv S' SubjStr '*_file.txt ' datadir '.']);
%unix(['mv encodingDataFileSub' SubjStr 'Block' num2str(iBlock) '*_file.txt ' datadir '.']);
%unix(['mv testDataFileSub' SubjStr 'Block' num2str(iBlock) '*_file.txt ' datadir '.']);
sca; ShowCursor;

end

