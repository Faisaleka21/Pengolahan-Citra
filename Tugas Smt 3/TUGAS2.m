##Praktikum 2 Histogram
##resize dlu gambarnya agar tidak lemot
## Pakai Citra Sendiri
pkg load image; #pkg untuk liat histiogram

## 1. GAMBAR
img = imread('IMG_5084.jpg');
IMG = im2uint8(img);
figure
subplot (2,1,1),imshow (IMG), title 'gambar normal';
subplot (2,1,2),imhist (IMG);
##PISAHKAN CHANNEL RGB
r = IMG(:, :,1);
g = IMG(:, :,2);
b = IMG(:, :,3);
##TAMPILKAN HISTOGRM UNTUK MASING2 CHANNEL
figure ('name','Histogram Channel','numbertitle','off');
subplot (3,1,1), imhist(r), title 'histogram red', xlim([0,255]);
subplot (3,1,2), imhist(g), title 'histogram green', xlim([0,255]);
subplot (3,1,3), imhist(b), title 'histogram blue', xlim([0,255]);
## ubah ke grayscale
grey = rgb2gray(IMG);
figure ('name','Gambar GreyScale','numbertitle','off');
subplot (1,2,1), imshow (grey), title 'gambar grey';
subplot (1,2,2), imhist (grey);

## 2. Meningkatkan Kecerahan
## hal 50
C = grey + 60;
figure ('name','Gambar Penigkatan Cahaya','numbertitle','off');
subplot(2,1,1),imshow(C),title 'Penigkatan Cahaya';
subplot(2,1,2),imhist(C), title 'histo gambr';

## 3. Meregangkan Kontras
#### hal 53
K = imadjust(grey, stretchlim(grey), []); #imadjust digunakan untuk meregangkan atau menyesuaikan kontras gambar.
figure ('name','Gambar Meregangkan Kontras','numbertitle','off');
subplot(2,1,1), imshow(K), title 'Peregangan Kontras';
subplot(2,1,2), imhist(K), title 'histo gambr peregangan kontras';

## 4. Kombinasi Kecerahan dan Kontras
## hal 55
KK = imadjust(grey+ 30, stretchlim(grey), []); #stretchlim(grey) : Fungsi ini menghitung batas bawah dan atas intensitas piksel (misalnya [0.05 0.95]) yang akan digunakan sebagai referensi untuk peregangan kontras.
figure ('name','Gambar Kecerahan & Kontras','numbertitle','off');
subplot(2,1,1),imshow(KK),title 'Kombinasi Cerah & Kontras';
subplot(2,1,2),imhist(KK), title 'histo gambr';

## 5. Membalik Citra
## hal 56
R = 255-grey;
figure ('name','Gambar Membalik Citra','numbertitle','off');
subplot(2,1,1),imshow(R),title 'Membalik Citra';
subplot(2,1,2),imhist(R), title 'histo gambr';

## 6. Pemetaan Nonlinear
## hal 57
C = log(1+double(grey));
C2 = im2uint8(mat2gray(C));
figure ('name','Gambar Pemetaan Nonlinear','numbertitle','off');
subplot(2,1,1),imshow(C2),title 'Pemetaan Nonlinear';
subplot(2,1,2),imhist(C2), title 'histo gambr';

## 7. Pemotongan Aras Keabuan (menghilangkan background)
## hal 59
H = imread('flashdisk grayscale.tif');
h = potong('flashdisk grayscale.tif',100,30);
figure ('name','Pemotongan aras keabuan','numbertitle','off');
subplot(2,2,1),imshow(H),title 'Sebelum';
subplot(2,2,3),imhist(H), title 'histo sebelum gambr';
subplot(2,2,2),imshow(h),title 'Setelah';
subplot(2,2,4),imhist(h), title 'histo setelah gambr';


## 8. Ekualisasi Histogram
# hal 63
[jum_baris, jum_kolom] = size(grey);
L = 256;
Histog = zeros(L, 1);  # histogram awal
# Hitung histogram grayscale
for baris = 1 : jum_baris
  for kolom = 1 : jum_kolom
    intensity = grey(baris, kolom) + 1;  # +1 karena indeks Octave mulai dari 1
    Histog(intensity) = Histog(intensity) + 1;
  end
end
# Hitung distribusi kumulatif (CDF)
alpha = (L - 1) / (jum_baris * jum_kolom);
C = zeros(L, 1);
C(1) = round(alpha * Histog(1));
for i = 2 : L
  C(i) = C(i-1) + round(alpha * Histog(i));
end
# Pemetaan hasil
Hasil = zeros(jum_baris, jum_kolom);
for baris = 1 : jum_baris
  for kolom = 1 : jum_kolom
    intensity = grey(baris, kolom) + 1;
    Hasil(baris, kolom) = C(intensity);
  end
end
Hasil = uint8(Hasil);
figure('name','Ekualisasi Histogram','numbertitle','off');
subplot(2,1,1), imshow(Hasil), title('Gambar Hasil Ekualisasi');
subplot(2,1,2), imhist(Hasil), title('Histogram Setelah Ekualisasi');





