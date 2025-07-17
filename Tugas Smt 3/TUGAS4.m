##efek spiral
pkg load image;

img = im2double(imread("file (1).jpg"));
img = imresize(img, [512 512]);

[m, n, ~] = size(img);
cx = (n + 1) / 2;
cy = (m + 1) / 2;

[X, Y] = meshgrid(1:n, 1:m);
dx = X - cx;
dy = Y - cy;

% Hitung radius dan sudut asli
radius = sqrt(dx.^2 + dy.^2);
theta = atan2(dy, dx);

% Parameter distorsi spiral
max_radius = max(radius(:));
twist_strength = 2 * pi;  % Semakin besar, semakin berputar

% Tambahkan sudut twist yang tergantung jarak dari pusat
theta_new = theta + (1 - radius / max_radius) .* twist_strength;

% Hitung koordinat baru
Xnew = round(cx + radius .* cos(theta_new));
Ynew = round(cy + radius .* sin(theta_new));

% Clamp
Xnew = min(max(Xnew, 1), n);
Ynew = min(max(Ynew, 1), m);

% Bangun gambar baru
spiral_img = zeros(size(img));
for c = 1:3
  channel = img(:,:,c);
  for i = 1:m
    for j = 1:n
      spiral_img(i,j,c) = channel(Ynew(i,j), Xnew(i,j));
    end
  end
end

figure('name','Spiner','numbertitle','off');
subplot(1,2,1), imshow(img), title('Sebelum');
subplot(1,2,2), imshow(spiral_img), title('Sesudah)');





