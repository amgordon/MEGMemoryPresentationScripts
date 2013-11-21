function [] = MEGclass_StudyTest(thePath,sNum,block,saveName,isMEG,use_eyetracker)

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


%use this to debug the code
if is_debugging
    BlankScreenDur = .01;
    RestDur = Inf;
    StimDur = 2.5;
    ITI = .1;
    FixDur = .1;
    TestDur = 'any';
    TestLoop = 1;
else
    debugmode = 0;
    BlankScreenDur = .25;
    RestDur = Inf;
    StimDur = 4.0;
    ITI = 1.0;
    FixDur = 1.5;
    TestDur = 'any';
    TestLoop = 1;
end

PTBSetIsDebugging(is_debugging);

if is_debugging
    Screen('Preference', 'SkipSyncTests', 1);
end


% set some defaults
PTBSetExitKey('ESCAPE');
PTBSetBackgroundColor([128 128 128]);
PTBSetTextColor([255 255 255]);		% This defaults to white = (255, 255, 255).
PTBSetTextFont('Arial');		% This defaults to Courier.
PTBSetTextSize(30);

%this is to set up the PTB log files
PTBSetLogFiles(['S' SubjStr '_' num2str(block) '_log_file.txt'], ['S' SubjStr '_' num2str(block) '_data_file.txt']);
PTBSetLogHeaders({'condition','item','itempos','itemcolor','targetloc'});



% set some global variables
global PTBLastPresentationTime;			%#ok<NUSED> % When the last display was presented.
global PTBLastKeyPressTime;				  %#ok<NUSED> % When the last response was given.
global PTBLastKeyPress;						   % The last response given.
global PTBScreenRes;
global PTBWaitForKey;% Has 'width' and 'height' of current display in pixels





try
    % start experiment
    PTBSetupExperiment('MEGBound_Task');
    
    
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
    
    %load in all the lists
    
    load allLists
    theListStudy1 = lists{SubjectNumber}.Study1;
    Study1Length = length(theListStudy1);
    theListStudy2 = lists{SubjectNumber}.Study2;
    Study2Length = length(theListStudy2);
    theListTest = lists{SubjectNumber}.Test;
    TestLength = length(theListTest);
    clear lists
    
    theData.Study1.condition = theListStudy1(1,:);
    theData.Study1.conID = theListStudy1(2,:);
    theData.Study1.word = theListStudy1(5,:);
    theData.Study1.wordID = theListStudy1(3,:);
    theData.Study1.image = theListStudy1(6,:);
    theData.Study1.imageID= theListStudy1(4,:);
    theData.Study1.miniblock = theListStudy1(7,:);
    
    theData.Study2.condition = theListStudy2(1,:);
    theData.Study2.conID = theListStudy2(2,:);
    theData.Study2.word = theListStudy2(5,:);
    theData.Study2.wordID = theListStudy2(3,:);
    theData.Study2.image = theListStudy2(6,:);
    theData.Study2.imageID= theListStudy2(4,:);
    theData.Study2.miniblock = theListStudy2(7,:);
    
    theData.Test.condition = theListTest(1,:);
    theData.Test.conID = theListTest(2,:);
    theData.Test.word = theListTest(5,:);
    theData.Test.wordID = theListTest(3,:);
    theData.Test.image = theListTest(6,:);
    theData.Test.imageID= theListTest(4,:);
    theData.Test.miniblock = theListTest(7,:);
    
    
    %initiate encoding output data
    study1DataFile = cell(Study1Length+1,8);
    study1DataFile{1,1} = 'trialnum';
    study1DataFile{1,2} = 'trialID';
    encodingDataFile{1,3} = 'time';
    encodingDataFile{1,4} = 'respTime';
    encodingDataFile{1,5} = 'RT';
    encodingDataFile{1,6} = 'resp';
    
    %initiate test output data
    testDataFile = cell(23,10);
    testDataFile{1,1} = 'trialnum';
    testDataFile{1,2} = 'itemTrialID';
    testDataFile{1,3} = 'TOCorrectTrialID';
    testDataFile{1,4} = 'TOIncorrectTrialID';
    testDataFile{1,5} = 'time';
    testDataFile{1,6} = 'respTime';
    testDataFile{1,7} = 'RT';
    testDataFile{1,8} = 'resp';
    testDataFile{1,9} = 'boundType';
    testDataFile{1,10} = 'itemEncodingColor';
    testDataFile{1,11} = 'TOPosCbal';
    testDataFile{1,11} = 'LurePosition';
    
    
    
    %instructions
    instr = {'Welcome to the Memory Experiment!', 'In this task, you will view a series of objects embedded on a color background.','For each trial, please visualize the object in the color background and decide whether the', 'object/color background combination is pleasing to you. Then, you will be tested','on your memory for the object/color combinations as well as the','order in which the objects were presented. Press any key to go on.'};
    PTBDisplayParagraph(instr,{'center',30},{'any'});
    PTBDisplayBlank({.3},'Blank');
    
    instr = {'In this practice experiment, you will see 6 objects, one at a time.',' For each object, please indicate whether the object/color combination',' is pleasing to you. Try to remember the color of the background for each object,','as well as the order of the objects because you will be tested after this study period.','In this practice, you will have as much time as you need to make your decision.','Press any key to give it a try.'};
    PTBDisplayParagraph(instr,{'center',30},{'any'});
    PTBDisplayBlank({2},'Blank');
    
    
    for iTrial = 1:nTrials
        
        if (theData.Study1.miniblock{Trial}==block)
            goTime = goTime + stimTime; %
            
            PTBSetTextColor([0 0 0]);
            word = theData.Study1.word{Trial}(3:end);
            PTBDisplayText(word,{'center',30},{-1});
            
            PTBDisplayPictures(itemfile(iTrial), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {StimDur}, 'flag', 1, 0);
            trialOnset = GetSecs;
            
            
        end
        
            %write out encoding data after every trial
        encodingDataFile{iTrial+1,1}= iTrial;
        encodingDataFile{iTrial+1,2}= itemfile(iTrial);
        encodingDataFile{iTrial+1,3}= trialOnset;
        encodingDataFile{iTrial+1,4}= respTime;
        encodingDataFile{iTrial+1,5}= RT;
        encodingDataFile{iTrial+1,6}= resp;
        encodingDataFile{iTrial+1,7}= boundtype(iTrial);
        encodingDataFile{iTrial+1,8}= encodingColor(iTrial);
        encodingDataFile{iTrial+1,9}= withinEventPos(iTrial);
        encodingDataFile{iTrial+1,10}= currentWord{1,1};
    
        save([subdir '/encodingDataFileSub' SubjStr 'Block' num2str(iBlock) '.mat'],'encodingDataFile')
        
    end
    
    
    
    
    %get response
        while GetSecs - trialOnset < StimDur
            
            
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
                    
                    resp = kbname(keyCode);
                    
                else
                    
                    resp = 'm';
                    
                end
                
                
                
                respTime = TimeSecs;
                RT = TimeSecs - trialOnset;
                disp(num2str(RT))
            end
            
        end
    
    

    
    
    
    
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
    
    
    % finish up
    PTBDisplayText('The end.  Press any key to go to next run.',{'center'},{'any'});
    PTBDisplayBlank({.1},'Final Screen');
    
catch %#ok<CTCH>
    cd /Volumes/davachilab/MEGbound_freeRecall/
    PTBHandleError;
    
end


PTBCleanupExperiment;
fclose('all');
%unix(['mv S' SubjStr '*_file.txt ' datadir '.']);
%unix(['mv encodingDataFileSub' SubjStr 'Block' num2str(iBlock) '*_file.txt ' datadir '.']);
%unix(['mv testDataFileSub' SubjStr 'Block' num2str(iBlock) '*_file.txt ' datadir '.']);
sca; ShowCursor;



