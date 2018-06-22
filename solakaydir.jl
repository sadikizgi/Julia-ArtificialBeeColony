#sola kaydırma
function solakaydir(besin,indis1,indis2)
# çözümde iğleştirme olmassa eski olan bozulmasın die
yenibesin=besin;
kucuk=min.(indis1,indis2);
buyuk=max.(indis1,indis2);
ilkeleman=yenibesin[kucuk];
for i=kucuk[1]:buyuk[1]-1
    yenibesin[i] = yenibesin[i+1];
end
yenibesin[buyuk]=ilkeleman;
return yenibesin
end
