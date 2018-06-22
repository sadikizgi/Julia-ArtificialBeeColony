function icindemevcutmu(dizi,aranandeger)
var = false;
for i=1:length(dizi)
    if dizi[i] == aranandeger
        var=true;
        break;
    end
end
return var
display("$(var)")
end
