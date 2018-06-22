function amacfonksiyonu(besin,ilmesafe,sehirsayisi)
ustlimit =(sehirsayisi-1);
uzaklik = 0;
y = besin[:];

for i=1:ustlimit
  all = y[i];

  all2 = y[(i+1)];
    yeniuzaklik=ilmesafe[all,all2];
    #üretmiş olduğumuz rastgele değerden 1.sinde başlayı i değeri artıcak
    uzaklik=uzaklik+yeniuzaklik;
end
#ilk şehirden son şehire kadar gidicek .burda da amaç fonctionum 2 ye ayrılacak
#son şehirden ilk şehire dönme olucak ayrılan kısım

return uzaklik
end
