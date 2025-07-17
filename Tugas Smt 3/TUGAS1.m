% tugas praktikum 1

% 1. imread / untuk membaca citra %
img = imread('bangunan.png');

% 2. imshow / menampilkan citra &
imshow(img);


% 3. menampilkan ukuran citra&
Ukuran = size(img)
title('Citra Berwarna');

% 4. mengkonversi citra warna ke Grayscale
figure;
Abu = rgb2gray(img);
imshow(Abu);
title('Bangunan Hitam Putih');%untuk memberi teks

% 5. mengkonversi citra Grayscale ke binner
figure;
[tinggi, lebar] = size(img)
ambang = 100; % Nilai ini bisa diubah-ubah
Biner = zeros(tinggi, lebar);
for baris=1 : tinggi
for kolom=1 : lebar
if img(baris, kolom) >= ambang
Biner(baris, kolom) = 0;
else
Biner(baris, kolom) = 1;
end
end
end
imshow(Biner);
title('Citra ke Binner');


% 6. menyimpan citra
# a. grayscale
imwrite (Abu, 'bangunan grayscale.png'); %untuk yg bangunan itu nama file untuk disimpan
# b. binner
imwrite (Biner, 'bangunan biner.png', 'Quality', 100);





