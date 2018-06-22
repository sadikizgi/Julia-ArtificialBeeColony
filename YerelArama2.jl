#yerelarama2 yi burda yazıcam
#kaşif arının araması için
function YerelArama2(besin,cozumdegeri,ilmesafe,sehirsayisi)
    #ilgili çözüm bozulmasın die burda hafızaya alıyorum
    sonucbesin=besin; #ilgili çözüm bozulmasın die burda hafızaya alıyorum
    sonuccozumdegeri=cozumdegeri;
    for i=1:length(sonucbesin)-1
    for j=1:length(sonucbesin)
        yenibesin=diziyiterscevir(sonucbesin,i,j);
        yeniamacfonksiyonu=amacfonksiyonu(yenibesin,ilmesafe,sehirsayisi);
        if yeniamacfonksiyonu<sonuccozumdegeri
            sonuccozumdegeri=yeniamacfonksiyonu;
            sonucbesin=yenibesin;
        end
    end
    end
    return [sonucbesin,sonuccozumdegeri]
  end
    #DİZİYİ TERSÇEVİRME KULLANDIM bu aramada
