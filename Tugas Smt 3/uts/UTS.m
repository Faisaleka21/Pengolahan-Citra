## UTS SMT 3
pkg load image;
####1
#### RGB
##img=imread("file (1).jpg");
##figure ('name','RGB','numbertitle','off');
##imshow(img), title "RGB";
##
#### grayscale
##gray=rgb2gray(img);
##figure ('name','Gray','numbertitle','off');
##imshow(gray), title "GRAYSCALE";
##
#### binner
##[tinggi, lebar] = size(gray)
##ambang = 100; % Nilai ini bisa diubah-ubah
##Biner = zeros(tinggi, lebar);
##for baris=1 : tinggi
##for kolom=1 : lebar
##if img(baris, kolom) >= ambang
##Biner(baris, kolom) = 0;
##else
##Biner(baris, kolom) = 1;
##end
##end
##end
##figure ('name','Binner rgb','numbertitle','off');
##imshow(Biner), title "Binner";


####2
#### Kuantisasi 2 tingkat
##gray2 = uint8(floor(double(gray) / 128) * 128);
##figure('name', 'Kuantisasi 2 Tingkat', 'numbertitle', 'off');
##imshow(gray2), title("Kuantisasi 2 Tingkat");
##
#### Kuantisasi 4 tingkat
##gray4 = uint8(floor(double(gray) / 64) * 64);
##figure('name', 'Kuantisasi 4 Tingkat', 'numbertitle', 'off');
##imshow(gray4), title("Kuantisasi 4 Tingkat");
##
#### Kuantisasi 8 tingkat
##gray8 = uint8(floor(double(gray) / 32) * 32);
##figure('name', 'Kuantisasi 8 Tingkat', 'numbertitle', 'off');
##imshow(gray8), title("Kuantisasi 8 Tingkat");


##3
##img = imread ('images.jpg');
##figure('name', 'Sebelum', 'numbertitle', 'off');
##subplot(1,2,1),imshow(img);
##subplot(1,2,2),imhist(img);
##
##C = img + 90;
##figure('name', 'Sesudah', 'numbertitle', 'off');
##subplot(1,2,1),imshow(C);
##subplot(1,2,2),imhist(C);


####4
##Img = imread('wajah ai.png');
##Abu2 = rgb2gray(Img);
##figure('name', 'Gray-Kuantisasi', 'numbertitle', 'off');
##subplot(1,2,1),imshow(Abu2);
##subplot(1,2,2),imhist(Abu2);
##
##[jum_baris, jum_kolom] = size(Abu2);
##L = 256;
##Histog = zeros(L, 1);
##for baris=1 : jum_baris
##for kolom=1 : jum_kolom
##Histog(Abu2(baris, kolom)+1) = ...
##Histog(Abu2(baris, kolom)+1) + 1;
##end
##end
##alpha = (L-1) / (jum_baris * jum_kolom);
##C(1) = alpha * Histog(1);
##for i=1 : L-2
##C(i+1) = C(i) + round(alpha * Histog(i+1));
##end
##for baris=1 : jum_baris
##for kolom=1 : jum_kolom
##Hasil(baris, kolom) = C(Abu2(baris, kolom));
##end
##end
##Hasil = uint8(Hasil);
##figure('name', 'Kuantisasi', 'numbertitle', 'off');
##subplot(1,2,1),imshow(Hasil);
##subplot(1,2,2),imhist(Hasil);


##5
##a
##img = imread('mobil-noise.png');
##F = rgb2gray(img);
##[tinggi, lebar] = size(F);
##for baris=2 : tinggi-1
##for kolom=2 : lebar-1
##data = [F(baris-1, kolom-1) ...
##F(baris-1, kolom) ...
##F(baris-1, kolom+1) ...
##F(baris, kolom-1) ...
##F(baris, kolom) ...
##F(baris, kolom+1) ...
##F(baris+1, kolom-1) ...
##F(baris+1, kolom) ...
##F(baris+1, kolom+1)];
##% Urutkan
##for i=1 : 8
##for j=i+1 : 9
##if data(i) > data(j)
##tmp = data(i);
##data(i) = data(j);
##data(j) = tmp;
##end
##end
##end
##% Ambil nilai median
##G(baris, kolom) = data(5);
##end
##end
#### menampilkan
##figure ('name','Filter Median','numbertitle','off');
##subplot (1,2,1), imshow (F), title 'SBLM';
##subplot (1,2,2), imshow (G), title 'SSDH';
##
####b
##[tinggi, lebar] = size(G);
##F2 = double(G);
##for baris=2 : tinggi-1
##for kolom=2 : lebar-1
##jum = F2(baris-1, kolom-1)+ ...
##F2(baris-1, kolom) + ...
##F2(baris-1, kolom-1) + ...
##F2(baris, kolom-1) + ...
##F2(baris, kolom) + ...
##F2(baris, kolom+1) + ...
##F2(baris+1, kolom-1) + ...
##F2(baris+1, kolom) + ...
##F2(baris+1, kolom+1);
##J(baris, kolom) = uint8(1/9 * jum);
##end
##end
##figure ('name','Filter Mean','numbertitle','off');
##subplot (1,2,1), imshow (G), title 'Median';
##subplot (1,2,2), imshow (J), title 'Perataan';


####6
##% Membaca gambar dan konversi ke grayscale
##img = imread("tulisan.jpg");
##gray = rgb2gray(img);
##
##% Membuat filter rata-rata (low-pass) untuk smoothing
##h = fspecial('average', 3); % kernel 3x3
##lowpass = imfilter(gray, h);
##
##% High-boost filtering
##A = 3; % Faktor penguat (A > 1)
##mask = double(gray) - double(lowpass);
##highboost = uint8(double(gray) + A * mask);
##
##% Menampilkan hasil
##figure('name','Hight-Boost','numbertitle','off');
##subplot(2,1,1),imshow(gray), title("Citra Grayscale Asli");
##subplot(2,1,2),imshow(highboost), title("Citra Hasil High-Boost");



##7
##a
img = imread('spanduk.jpg');
grey = rgb2gray(img);
F = im2double(grey);
[tinggi, lebar, kanal] = size(F);
sudut = -8;
rad = pi * sudut / 180;
cosa = cos(rad);
sina = sin(rad);

R = [cosa -sina; sina cosa];
corners = [1, 1; lebar, 1; 1, tinggi; lebar, tinggi];
rotated_corners = (R * (corners' - [lebar/2; tinggi/2])) + [lebar/2; tinggi/2];
min_x = floor(min(rotated_corners(1,:)));
max_x = ceil(max(rotated_corners(1,:)));
min_y = floor(min(rotated_corners(2,:)));
max_y = ceil(max(rotated_corners(2,:)));
lebar_baru = max_x - min_x + 1;
tinggi_baru = max_y - min_y + 1;
xc_baru = lebar_baru / 2;
yc_baru = tinggi_baru / 2;
xc = lebar / 2;
yc = tinggi / 2;
G = zeros(tinggi_baru, lebar_baru, kanal);

for y = 1 : tinggi_baru
    for x = 1 : lebar_baru
        xt = x - xc_baru;
        yt = y - yc_baru;
        x2 =  xt * cosa + yt * sina + xc;
        y2 = -xt * sina + yt * cosa + yc;
        if x2 >= 1 && x2 <= lebar - 1 && y2 >= 1 && y2 <= tinggi - 1
            x1 = floor(x2);
            y1 = floor(y2);
            a = x2 - x1;
            b = y2 - y1;
            for c = 1 : kanal
                G(y,x,c) = ...
                    (1-a)*(1-b)*F(y1,x1,c) + ...
                    a*(1-b)*F(y1,x1+1,c) + ...
                    (1-a)*b*F(y1+1,x1,c) + ...
                    a*b*F(y1+1,x1+1,c);
            end
        else
            G(y,x,:) = 0;
        end
    end
end

% Simpan hasil rotasi ke file
save('hasil_rotasi.m', 'G');

% Tampilkan perbandingan
figure('name','Interpolasi Bilinear','numbertitle','off');
subplot(1,2,1), imshow(F), title('Sebelum (Sudut Miring)');
subplot(1,2,2), imshow(G), title('Setelah Diluruskan (Rotasi -8°)');


##b
% Load hasil rotasi dari file
load('hasil_rotasi.m', 'G');
% Perbesar hasil rotasi
scale = 2.0;
G_perbesar = imresize(G, scale, 'bilinear');
figure('Name','Setelah Rotasi','NumberTitle','off');
imshow(G);
title('Setelah Rotasi -8°');
figure('Name','Setelah Diperbesar','NumberTitle','off');
imshow(G_perbesar);
title('Setelah Rotasi & Diperbesar 2x');

##otomatis
% 1. Baca gambar
##img = imread('spanduk.jpg');
##imshow(img);
##title('Gambar Asli (Sudut Miring)');
##% 2. Titik sudut spanduk di gambar asli (diisi manual dari koordinat citra)
##% Format: [x y] - sesuaikan dengan posisi di gambar kamu
##src_points = [
##    120 100;   % kiri atas
##    400 90;    % kanan atas
##    420 300;   % kanan bawah
##    100 310    % kiri bawah
##];
##% 3. Titik target tegak lurus (misalnya hasil ingin ukuran 300x150 px)
##dst_points = [
##    0 0;
##    200 0;
##    200 100;
##    0 100
##];
##% 4. Hitung transformasi perspektif (homografi)
##T = cp2tform(src_points, dst_points, 'projective');
##% 5. Lakukan transformasi dengan interpolasi bilinear
##transformed = imtransform(img, T, 'bilinear', 'XData', [0 200], 'YData', [0 100]);
##% 6. Tampilkan hasil transformasi
##figure;
##imshow(transformed);
##title('Hasil Transformasi Otomatis (Interpolasi Bilinear)');

##manual
% 1. Baca gambar (ganti dengan path gambar kamu)
##img = imread('spanduk.jpg');
##imshow(img);
##title('Gambar Asli (Sudut Miring)');
##% 2. Tentukan 4 titik sudut dari spanduk di gambar miring
##% Misal kamu pilih manual pakai ginput (klik 4 titik dari sudut spanduk)
##disp('Klik 4 titik sudut spanduk (urutan: kiri atas, kanan atas, kanan bawah, kiri bawah)');
##[x, y] = ginput(4);
##src_points = [x y];
##% 3. Tentukan titik tujuan (misalnya akan jadi 300x150 px kotak lurus)
##dst_points = [0 0;
##              300 0;
##              300 150;
##              0 150];
##% 4. Hitung transformasi perspektif (homografi)
##T = cp2tform(src_points, dst_points, 'projective');
##% 5. Lakukan transformasi dengan interpolasi bilinear
##output_size = [150, 300]; % tinggi, lebar
##transformed = imtransform(img, T, 'bilinear', 'XData', [0 300], 'YData', [0 150]);
##% 6. Tampilkan hasil
##figure;
##imshow(transformed);
##title('Hasil Transformasi (Tegak Lurus, Interpolasi Bilinear)');




##8
##img = imread("unnamed ai.png");
##gray = rgb2gray(img);  % Citra grayscale
##function G = ripple(F, ax, ay, tx, ty)
##  [tinggi, lebar] = size(F);
##  G = zeros(tinggi, lebar);  % Inisialisasi G
##  for y = 1 : tinggi
##    for x = 1 : lebar
##      x2 = x + ax * sin(2 * pi * y / tx);
##      y2 = y + ay * sin(2 * pi * x / ty);
##      if (x2 >= 1) && (x2 <= lebar - 1) && (y2 >= 1) && (y2 <= tinggi - 1)
##        p = floor(y2);
##        q = floor(x2);
##        a = y2 - p;
##        b = x2 - q;
##        % Interpolasi bilinear
##        intensitas = (1 - a) * ((1 - b) * F(p, q) + b * F(p, q + 1)) + ...
##                      a * ((1 - b) * F(p + 1, q) + b * F(p + 1, q + 1));
##        G(y, x) = intensitas;
##      else
##        G(y, x) = 0;
##      end
##    end
##  end
##  G = uint8(G);
##end
##% Panggil fungsi ripple dengan parameter
##hasil = ripple(gray, 5, 5, 30, 30);
##% Tampilkan hasil
##figure('name','Citra Ripple','numbertitle','off');
##subplot(1,2,1), imshow(gray), title("Sebelum");
##subplot(1,2,2), imshow(hasil), title("Sesudah");


##9
##AG = imread('parkiran.jpg');
##AG = rgb2gray(AG);
##% Buat kernel Gaussian ukuran 10x10 dan sigma = 2
##kernel = fspecial('gaussian', [10 10], 5);  % memaki filter 'gaussian',[ukuran] dan [sigma]
##% Terapkan filter Gaussian
##GA = imfilter(AG, kernel, 'same');
##figure('name', 'Gaussian Blur Otomatis', 'numbertitle', 'off');
##subplot(1, 2, 1), imshow(AG), title('Sebelum');
##subplot(1, 2, 2), imshow(GA), title('Sesudah');


##10
##img = imread('bangunan.jpg');
##F = rgb2gray(img);
##% Parameter transformasi gabungan
##rad = pi / 6;  % rotasi 30 derajat
##scale = 2;     % skala (perbesar 2x)
##tx = -30;      % translasi X
##ty = -50;      % translasi Y
##a11 = scale * cos(rad);
##a12 = scale * sin(rad);
##a21 = -scale * sin(rad);
##a22 = scale * cos(rad);
##
##G = taffine(F, a11, a12, a21, a22, tx, ty);
##
##figure('name', 'Transformasi Affine Gabungan', 'numbertitle', 'off');
##subplot(1, 2, 1), imshow(F), title('Citra Asli');
##subplot(1, 2, 2), imshow(G), title('Setelah Transformasi');
##
##function G = taffine(F, a11, a12, a21, a22, tx, ty)
##    [tinggi, lebar] = size(F);
##    G = zeros(tinggi, lebar);
##    for y = 1 : tinggi
##        for x = 1 : lebar
##            x2 = a11 * x + a12 * y + tx;
##            y2 = a21 * x + a22 * y + ty;
##            if (x2 >= 1) && (x2 <= lebar - 1) && (y2 >= 1) && (y2 <= tinggi - 1)
##                p = floor(y2);
##                q = floor(x2);
##                a = y2 - p;
##                b = x2 - q;
##                % Interpolasi bilinear
##                intensitas = (1 - a) * ((1 - b) * F(p, q) + b * F(p, q + 1)) + ...
##                             a * ((1 - b) * F(p + 1, q) + b * F(p + 1, q + 1));
##                G(y, x) = intensitas;
##            else
##                G(y, x) = 0;
##            end
##        end
##    end
##    G = uint8(G);
##end



