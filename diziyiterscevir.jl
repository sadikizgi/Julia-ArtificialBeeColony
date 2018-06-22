function diziyiterscevir(besin,indis1,indis2)
yenibesin=besin;
kucuk=min.(indis1,indis2);
buyuk=max.(indis1,indis2);
while kucuk[1] < buyuk[1]
    degisgen=yenibesin[kucuk];
    yenibesin[kucuk]=yenibesin[buyuk];
    yenibesin[buyuk]=degisgen;
    kucuk = kucuk+1;
    buyuk = buyuk-1;
end
return yenibesin
end
