function a = onsetMaker(startsub,endsub)

subIDs = {'face_Recon_sub1_081813'};

modelNum = 1;

startDir = pwd;

for sub = startsub:endsub
    % load the BStudy file
    cmd = ['load ' subIDs{sub} '_StudyTest.mat'];
    eval(cmd);
    BStudy.face = theData.condition(1,:); % e.g., CCC_FO 
    BStudy.condID = theData.conID; % e.g., CCC_FO2
    BStudy.BitemID = theData.BitemID;
    BStudy.CitemID = theList(5,:);
    BStudy.word = theData.word;
    BStudy.Bitem= theData.Bitem;
    BStudy.Citem = theData.Citem;
    
    BcondIndices = varFinder(BStudy.condNames); % get the index number for all conditions (will be a variable with fields for each condition)
    
    %By Condition
    BStudy.onsets.BBB_FO = BcondIndices.BBB_FO;
    BStudy.onsets.BBB_FS = BcondIndices.BBB_FS;
    BStudy.onsets.BBB_SO = BcondIndices.BBB_SO;
    BStudy.onsets.BBB_SF = BcondIndices.BBB_SF;
    BStudy.onsets.BBB_OF = BcondIndices.BBB_OF;
    BStudy.onsets.BBB_OS = BcondIndices.BBB_OS;
    BStudy.onsets.CCC_FO = BcondIndices.CCC_FO;
    BStudy.onsets.CCC_FS = BcondIndices.CCC_FS;
    BStudy.onsets.CCC_SO = BcondIndices.CCC_SO;
    BStudy.onsets.CCC_SF = BcondIndices.CCC_SF;
    BStudy.onsets.CCC_OF = BcondIndices.CCC_OF;
    BStudy.onsets.CCC_OS = BcondIndices.CCC_OS;
    BStudy.onsets.INT_FO = BcondIndices.INT_FO;
    BStudy.onsets.INT_FS = BcondIndices.INT_FS;
    BStudy.onsets.INT_SO = BcondIndices.INT_SO;
    BStudy.onsets.INT_SF = BcondIndices.INT_SF;
    BStudy.onsets.INT_OF = BcondIndices.INT_OF;
    BStudy.onsets.INT_OS = BcondIndices.INT_OS;
    
    %By Image Category
    BStudy.onsets.face = superUnion([BcondIndices.BBB_FO BcondIndices.BBB_FS BcondIndices.CCC_FO BcondIndices.CCC_FS BcondIndices.INT_FO BcondIndices.INT_FS]);
    BStudy.onsets.scene = superUnion([BcondIndices.BBB_SO BcondIndices.BBB_SF BcondIndices.CCC_SO BcondIndices.CCC_SF BcondIndices.INT_SO BcondIndices.INT_SF]);
    BStudy.onsets.object = superUnion([BcondIndices.BBB_OF BcondIndices.BBB_OS BcondIndices.CCC_OF BcondIndices.CCC_OS BcondIndices.INT_OF BcondIndices.INT_OS]);
    BStudy.onsets.all = superUnion([BStudy.onsets.face BStudy.onsets.scene BStudy.onsets.object]);
    
    %By Instruction Type 
    BStudy.onsets.b = superUnion([BcondIndices.BBB_FO BcondIndices.BBB_FS BcondIndices.BBB_SO BcondIndices.BBB_SF BcondIndices.BBB_OF BcondIndices.BBB_OS]);
    BStudy.onsets.c = superUnion([BcondIndices.CCC_FO BcondIndices.CCC_FS BcondIndices.CCC_SO BcondIndices.CCC_SF BcondIndices.CCC_OF BcondIndices.CCC_OS]);
    BStudy.onsets.i = superUnion([BcondIndices.INT_FO BcondIndices.INT_FS BcondIndices.INT_SO BcondIndices.INT_SF BcondIndices.INT_OF BcondIndices.INT_OS]);
    
    BStudy = onsetConverter(BStudy.onsets,'BStudy');
    clear BcondIndices 

    % load the CStudy file
    cmd = ['load ' subIDs{sub} '_CStudy.mat_study.mat'];
    eval(cmd);
    CStudy.condNames = theData.condition(1,:); % e.g., CCC_FO 
    CStudy.condID = theData.conID; % e.g., CCC_FO2
    CStudy.BitemID = theData.BitemID;
    CStudy.CitemID = theList(5,:);
    CStudy.word = theData.word;
    CStudy.Bitem= theData.Bitem;
    CStudy.Citem = theData.Citem;
    
    CcondIndices = varFinder(CStudy.condNames); % get the index number for all conditions (will be a variable with fields for each condition)
    
    
    %By Condition
    CStudy.onsets.BBB_FO = CcondIndices.BBB_FO;
    CStudy.onsets.BBB_FS = CcondIndices.BBB_FS;
    CStudy.onsets.BBB_SO = CcondIndices.BBB_SO;
    CStudy.onsets.BBB_SF = CcondIndices.BBB_SF;
    CStudy.onsets.BBB_OF = CcondIndices.BBB_OF;
    CStudy.onsets.BBB_OS = CcondIndices.BBB_OS;
    CStudy.onsets.CCC_FO = CcondIndices.CCC_FO;
    CStudy.onsets.CCC_FS = CcondIndices.CCC_FS;
    CStudy.onsets.CCC_SO = CcondIndices.CCC_SO;
    CStudy.onsets.CCC_SF = CcondIndices.CCC_SF;
    CStudy.onsets.CCC_OF = CcondIndices.CCC_OF;
    CStudy.onsets.CCC_OS = CcondIndices.CCC_OS;
    CStudy.onsets.INT_FO = CcondIndices.INT_FO;
    CStudy.onsets.INT_FS = CcondIndices.INT_FS;
    CStudy.onsets.INT_SO = CcondIndices.INT_SO;
    CStudy.onsets.INT_SF = CcondIndices.INT_SF;
    CStudy.onsets.INT_OF = CcondIndices.INT_OF;
    CStudy.onsets.INT_OS = CcondIndices.INT_OS;
    
    %By Image Category
    CStudy.onsets.face = superUnion([CcondIndices.BBB_OF CcondIndices.BBB_SF CcondIndices.CCC_OF CcondIndices.CCC_SF CcondIndices.INT_OF CcondIndices.INT_SF]);
    CStudy.onsets.scene = superUnion([CcondIndices.BBB_OS CcondIndices.BBB_FS CcondIndices.CCC_OS CcondIndices.CCC_FS CcondIndices.INT_OS CcondIndices.INT_FS]);
    CStudy.onsets.object = superUnion([CcondIndices.BBB_FO CcondIndices.BBB_SO CcondIndices.CCC_FO CcondIndices.CCC_SO CcondIndices.INT_FO CcondIndices.INT_SO]);
    CStudy.onsets.all = superUnion([CStudy.onsets.face CStudy.onsets.scene CStudy.onsets.object]);
    
    %By Instruction Type 
    CStudy.onsets.b = superUnion([CcondIndices.BBB_FO CcondIndices.BBB_FS CcondIndices.BBB_SO CcondIndices.BBB_SF CcondIndices.BBB_OF CcondIndices.BBB_OS]);
    CStudy.onsets.c = superUnion([CcondIndices.CCC_FO CcondIndices.CCC_FS CcondIndices.CCC_SO CcondIndices.CCC_SF CcondIndices.CCC_OF CcondIndices.CCC_OS]);
    CStudy.onsets.i = superUnion([CcondIndices.INT_FO CcondIndices.INT_FS CcondIndices.INT_SO CcondIndices.INT_SF CcondIndices.INT_OF CcondIndices.INT_OS]);
    
    CStudy = onsetConverter(CStudy.onsets,'CStudy');


    % model 1 - just the prestudy conditions
    if modelNum == 1
        num = 1;
        names{num} = 'AB_BBB_FO';
        onsets{num} = BStudy.BBB_FO;
        durations{num}(1:length(onsets{num})) = 0;

        num = 2;
        names{num} = 'AB_BBB_FS';
        onsets{num} = BStudy.BBB_FS;
        durations{num}(1:length(onsets{num})) = 0;

        num = 3;
        names{num} = 'AB_BBB_SO';
        onsets{num} = BStudy.BBB_SO;
        durations{num}(1:length(onsets{num})) = 0;

        num = 4;
        names{num} = 'AB_BBB_SF';
        onsets{num} = BStudy.BBB_SF;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 5;
        names{num} = 'AB_BBB_OF';
        onsets{num} = BStudy.BBB_OF;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 6;
        names{num} = 'AB_BBB_OS';
        onsets{num} = BStudy.BBB_OS;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 7;
        names{num} = 'AB_CCC_FO';
        onsets{num} = BStudy.CCC_FO;
        durations{num}(1:length(onsets{num})) = 0;

        num = 8;
        names{num} = 'AB_CCC_FS';
        onsets{num} = BStudy.CCC_FS;
        durations{num}(1:length(onsets{num})) = 0;

        num = 9;
        names{num} = 'AB_CCC_SO';
        onsets{num} = BStudy.CCC_SO;
        durations{num}(1:length(onsets{num})) = 0;

        num = 10;
        names{num} = 'AB_CCC_SF';
        onsets{num} = BStudy.CCC_SF;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 11;
        names{num} = 'AB_CCC_OF';
        onsets{num} = BStudy.CCC_OF;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 12;
        names{num} = 'AB_CCC_OS';
        onsets{num} = BStudy.CCC_OS;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 13;
        names{num} = 'AB_INT_FO';
        onsets{num} = BStudy.INT_FO;
        durations{num}(1:length(onsets{num})) = 0;

        num = 14;
        names{num} = 'AB_INT_FS';
        onsets{num} = BStudy.INT_FS;
        durations{num}(1:length(onsets{num})) = 0;

        num = 15;
        names{num} = 'AB_INT_SO';
        onsets{num} = BStudy.INT_SO;
        durations{num}(1:length(onsets{num})) = 0;

        num = 16;
        names{num} = 'AB_INT_SF';
        onsets{num} = BStudy.INT_SF;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 17;
        names{num} = 'AB_INT_OF';
        onsets{num} = BStudy.INT_OF;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 18;
        names{num} = 'AB_INT_OS';
        onsets{num} = BStudy.INT_OS;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 19;
        names{num} = 'AC_BBB_FO';
        onsets{num} = CStudy.BBB_FO;
        durations{num}(1:length(onsets{num})) = 0;

        num = 20;
        names{num} = 'AC_BBB_FS';
        onsets{num} = CStudy.BBB_FS;
        durations{num}(1:length(onsets{num})) = 0;

        num = 21;
        names{num} = 'AC_BBB_SO';
        onsets{num} = CStudy.BBB_SO;
        durations{num}(1:length(onsets{num})) = 0;

        num = 22;
        names{num} = 'AC_BBB_SF';
        onsets{num} = CStudy.BBB_SF;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 23;
        names{num} = 'AC_BBB_OF';
        onsets{num} = CStudy.BBB_OF;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 24;
        names{num} = 'AC_BBB_OS';
        onsets{num} = CStudy.BBB_OS;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 25;
        names{num} = 'AC_CCC_FO';
        onsets{num} = CStudy.CCC_FO;
        durations{num}(1:length(onsets{num})) = 0;

        num = 26;
        names{num} = 'AC_CCC_FS';
        onsets{num} = CStudy.CCC_FS;
        durations{num}(1:length(onsets{num})) = 0;

        num = 27;
        names{num} = 'AC_CCC_SO';
        onsets{num} = CStudy.CCC_SO;
        durations{num}(1:length(onsets{num})) = 0;

        num = 28;
        names{num} = 'AC_CCC_SF';
        onsets{num} = CStudy.CCC_SF;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 29;
        names{num} = 'AC_CCC_OF';
        onsets{num} = CStudy.CCC_OF;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 30;
        names{num} = 'AC_CCC_OS';
        onsets{num} = CStudy.CCC_OS;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 31;
        names{num} = 'AC_INT_FO';
        onsets{num} = CStudy.INT_FO;
        durations{num}(1:length(onsets{num})) = 0;

        num = 32;
        names{num} = 'AC_INT_FS';
        onsets{num} = CStudy.INT_FS;
        durations{num}(1:length(onsets{num})) = 0;

        num = 33;
        names{num} = 'AC_INT_SO';
        onsets{num} = CStudy.INT_SO;
        durations{num}(1:length(onsets{num})) = 0;

        num = 34;
        names{num} = 'AC_INT_SF';
        onsets{num} = CStudy.INT_SF;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 35;
        names{num} = 'AC_INT_OF';
        onsets{num} = CStudy.INT_OF;
        durations{num}(1:length(onsets{num})) = 0;
        
        num = 36;
        names{num} = 'AC_INT_OS';
        onsets{num} = CStudy.INT_OS;
        durations{num}(1:length(onsets{num})) = 0;
    
    elseif modelNum == 2
      
    elseif modelNum == 99
        

    end
    
    cd /Users/avichanales/Documents/Experiments/fMRI/REI/fmri_data/;
    if sub<10
        eval(['cd REI_sub0' num2str(sub)]);
    else
        eval(['cd REI_sub' num2str(sub)]);
    end
    dir = pwd;
    onsetsFolder = ['behavioral_model' num2str(modelNum)];
    checkDir = exist(fullfile(dir,onsetsFolder));
    if checkDir ~= 7
        eval(['mkdir ' onsetsFolder]);
        eval(['cd ' onsetsFolder]);
    else
        eval(['cd ' onsetsFolder]);
    end
    onsetdir = pwd;
    checkOnsets = exist(fullfile(onsetdir,'onsets.mat'));
    if checkOnsets == 2
        error('onsets file already exists for this model number.  I refuse to overwrite');
    else
        save onsets.mat onsets names durations;
    end
    eval(['cd ' startDir]);
    
end    