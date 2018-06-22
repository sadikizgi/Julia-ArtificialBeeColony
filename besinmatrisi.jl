function besinmatrisi(besinsayisi,sehirsayisi)
ustlimit = sehirsayisi;
matris =zeros(Int,besinsayisi,sehirsayisi);
for i = 1:besinsayisi
  matris[i,:]=randperm(sehirsayisi);
end
return matris
end
