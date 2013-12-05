function [respTime, RT] = collectKeys(BBidx)

onekey = KbName('1!'); %face
twokey = KbName('2@'); %scene
threekey = KbName('3#'); %object

[keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
RT = NaN;
respTime = NaN;
if keyIsDown
    if strcmp(KbName(keyCode),'p')
        pause(.1)
        while 1
            [keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
            if keyIsDown
                if strcmp(KbName(keyCode),'p')
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
        elseif keyCode(twokey)
            resp = 3;
        end
    end
    respTime = TimeSecs;
    RT = TimeSecs - trialOnset;
    
end

