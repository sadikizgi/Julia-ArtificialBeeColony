#2 tane yerel arama yapıcam bunlardan 1.si burda yerelarama1 olucak
#bunlar kaşif arilar açin aramadır
function YerelArama1(besin,cozumdegeri,ilmesafe,sehirsayisi)
sonucbesin=besin;
sonuccozumdegeri=cozumdegeri;
for i=1:length(sonucbesin)-1
    for j=1:length(sonucbesin)
        yenibesin=solakaydir(sonucbesin,i,j);
        yeniamacfonksiyonu=amacfonksiyonu(yenibesin,ilmesafe,sehirsayisi);
        if yeniamacfonksiyonu<sonuccozumdegeri
            sonuccozumdegeri=yeniamacfonksiyonu;
            sonucbesin=yenibesin;
        end
    end
end
#elde ettiğimiz çözüm değeri diğerinden daha iyi ise değişicek. eğer
#değilse aynı kalıcak
#SOLAKAYDİRMA KULLANDIM bu aramada
return [sonucbesin,sonuccozumdegeri]
end
