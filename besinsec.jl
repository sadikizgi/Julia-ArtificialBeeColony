function besinsec(uygunluk)
toplam=0.0;
r=rand();
bs = 0;
for i=1:length(uygunluk)
    toplam=toplam+uygunluk[i];
    if r<toplam
        bs=i;
        break;
    end
end
#rulet tekerleği seçim yöntemi ile besin seçilmesi
return bs
end
