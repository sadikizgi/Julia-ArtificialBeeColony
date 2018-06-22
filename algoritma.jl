tic()
#Fonksiyonların pathleri gösterildi
path = "C:/Users/sadik/Desktop/yapayarijulia"
path2 = "C:/Users/sadik/Desktop/yapayarijulia/data"
#Fonksiyonlar burada okutuldu .içindekileri kullanabilmek için
include(joinpath(path2, "ilmesafe.jl"));
include(joinpath(path, "icindemevcutmu.jl"));
include(joinpath(path, "rakamlarifarklidizi.jl"));
include(joinpath(path, "besinmatrisi.jl"));
include(joinpath(path, "amacfonksiyonu.jl"));
include(joinpath(path, "yerdegistir.jl"));
include(joinpath(path, "solakaydir.jl"));
include(joinpath(path, "diziyiterscevir.jl"));
include(joinpath(path, "besinsec.jl"));
include(joinpath(path, "yerelarama1.jl"));
include(joinpath(path, "yerelarama2.jl"));

ilmesafe = deepcopy(ilmes);
sehirsayisi = 81;
isciarisayisi = 15;
gozcuarisayisi = 15;
#kaşif arisayisini 1 olarak kabul edicem onu girmicem
besinsayisi = 50;
limit = 100;

eniyicozumdegeri = Inf;
besin = besinmatrisi(besinsayisi, sehirsayisi);
denemesayisi = zeros(Int, size(besin[:, 1]));
cozumdegeri = zeros(Float64, besinsayisi);
#cozumdegeri = zeros(besinsayisi + 1);
#sonsuz döngüye girmemesi için denemesayisi yaptık
for i = 1:besinsayisi
  cozumdegeri[i] = amacfonksiyonu(besin[i, :], ilmesafe, sehirsayisi);
  #herbir çözüm satırının çözüm degerini elde edicez ve karşılaştırmyı
  #sağlıyacağız
  if eniyicozumdegeri > cozumdegeri[i]
    eniyicozumdegeri = cozumdegeri[i];
    eniyicozum = besin[i, :];
  end
end
yenibesin = zeros(sehirsayisi);
degisecekbesinno = 0;
for iterasyon = 1:10000
  #işçi arı safhası başlar
  for i = 1:isciarisayisi
    degisecekbesinno = rand(1:besinsayisi, 1); # rastgele bir satırı seçtik
    r = rand();
    indis1 = rand(1:sehirsayisi, 1);
    indis2 = rand(1:sehirsayisi, 1);
    while indis1 == indis2
      indis2 = rand(1:sehirsayisi, 1);
    end
    #En iyi çözüm için dizi yi  yenileme operatörleri uygulandı
    if r < (1 / 3)
      yenibesin = yerdegistir(besin[degisecekbesinno, :], indis1, indis2);

    elseif r < (2 / 3)
      yenibesin = solakaydir(besin[degisecekbesinno, :], indis1, indis2);

    else
      yenibesin = diziyiterscevir(besin[degisecekbesinno, :], indis1, indis2);

    end
  end

  # eğer daha iyi bir çözüm kalitesi elde edersek bunu hafızaya alalım
  yenicozumdegeri = amacfonksiyonu(yenibesin, ilmesafe, sehirsayisi);
  if any(eniyicozumdegeri.<cozumdegeri[degisecekbesinno])
    cozumdegeri[degisecekbesinno] = yenicozumdegeri;
    besin[degisecekbesinno, :] = yenibesin; # matrise atma da yapalım
    denemesayisi[degisecekbesinno] = 0;
    if eniyicozumdegeri > yenicozumdegeri
      eniyicozumdegeri = yenicozumdegeri;
      eniyicozum = yenibesin;
    end
  else
    denemesayisi[degisecekbesinno] = denemesayisi[degisecekbesinno] + 1;
  end

  #işçi ari safhası bitti şimdide gözcü arı safhasına geçtim

  sabit = 1;
  minicinuygunluk = zeros(Float64, besinsayisi);
  uygunluk = zeros(Float64, besinsayisi);
  for i = 1:besinsayisi
    minicinuygunluk[i] = sabit / cozumdegeri[i];
  end
  cozumdegerleritoplami = 0;
  for i = 1:besinsayisi
    cozumdegerleritoplami = cozumdegerleritoplami + minicinuygunluk[i];
  end
  for i = 1:besinsayisi
    uygunluk[i] = minicinuygunluk[i] / cozumdegerleritoplami;
  end
  for i = 1:gozcuarisayisi
    degisecekbesinno = besinsec(uygunluk);
    r = rand();
    indis1 = rand(1:sehirsayisi, 1);
    indis2 = rand(1:sehirsayisi, 1);
    while indis1 == indis2
      indis2 = rand(1:sehirsayisi, 1);
    end
    # indis1 ile indis2 değerinin birbirine eşit olmasını istemiyorum. bu
    # yüzden rastgele bir degeer daha oluşucak
    if r < 1 / 3
      yenibesin = yerdegistir(besin[degisecekbesinno, :], indis1, indis2);

    elseif r < 2 / 3
      yenibesin = diziyiterscevir(besin[degisecekbesinno, :], indis1, indis2);

    else
      yenibesin = solakaydir(besin[degisecekbesinno, :], indis1, indis2);

    end
    yenicozumdegeri = amacfonksiyonu(yenibesin, ilmesafe, sehirsayisi);

    if yenicozumdegeri < cozumdegeri[degisecekbesinno]
      cozumdegeri[degisecekbesinno] = yenicozumdegeri;
      besin[degisecekbesinno, :] = yenibesin;
      denemesayisi[degisecekbesinno] = 0;
      if eniyicozumdegeri > yenicozumdegeri
        eniyicozumdegeri = yenicozumdegeri;
        eniyicozum = yenibesin;

      end
    else
      denemesayisi[degisecekbesinno] = denemesayisi[degisecekbesinno] + 1;
    end
  end
  #gözcü ari safhası bitti
  #kaşif arı safhası başlar
  for i = 1:besinsayisi # ilgili besin satırında tek tek bakıcak ve rastgele besin satırını seçicek
    if denemesayisi[i] > limit
      denemesayisi[i] = 0;
      besin[i, :], cozumdegeri[i] = YerelArama1(besin[i, :], cozumdegeri[i], ilmesafe, sehirsayisi);
      if eniyicozumdegeri > cozumdegeri[i]
        eniyicozumdegeri = cozumdegeri[i];
        eniyicozum = besin[i, :];
      end
      besin[i, :], cozumdegeri[i] = YerelArama2(besin[i, :], cozumdegeri[i], ilmesafe, sehirsayisi);
      if eniyicozumdegeri > cozumdegeri[i]
        eniyicozumdegeri = cozumdegeri[i];
        eniyicozum = besin[i, :];
      end
    end
  end
  #kaşif arı safhası bitti
  @printf("iterasyon : %d En iyi çözüm: %d \n",iterasyon,eniyicozumdegeri);

end


toc()
