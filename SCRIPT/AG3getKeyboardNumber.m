
function k = AG1getKeyboardNumber
% Gets laptop internal keyboard for Ben's laptop, INERTIA

d=PsychHID('Devices');
k = 0;

for n = 1:length(d)
    if (d(n).productID==594)&&(strcmp(d(n).usageName,'Keyboard'));  
        k=n;
        break
    end
end
