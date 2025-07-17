import os
import cv2
import numpy as np
from PIL import Image, ImageTk
import tkinter as tk
from tkinter import filedialog, messagebox
from sklearn.metrics.pairwise import cosine_similarity

# ======== Ekstraksi Fitur (Warna + Bentuk) ========
def extract_histogram_and_shape(image_path):
    image = cv2.imread(image_path)
    if image is None:
        return None
    image = cv2.resize(image, (200, 200))

    # Histogram warna (HSV)
    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    hist = cv2.calcHist([hsv], [0, 1, 2], None, [8, 8, 8], [0, 180, 0, 256, 0, 256])
    hist = cv2.normalize(hist, hist).flatten()

    # Ekstraksi bentuk (Hu Moments)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    _, thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
    moments = cv2.moments(thresh)
    huMoments = cv2.HuMoments(moments).flatten()

    return np.concatenate([hist, huMoments])

# ======== Load Dataset ========
def load_dataset_features(folder):
    features = []
    image_paths = []

    for file in os.listdir(folder):
        if file.lower().endswith((".jpg", ".png", ".jpeg")):
            path = os.path.join(folder, file)
            feat = extract_histogram_and_shape(path)
            if feat is not None:
                features.append(feat)
                image_paths.append(path)

    return np.array(features), image_paths

# ======== GUI Class ========
class CBIRApp:
    def __init__(self, root):
        self.root = root
        self.root.title("CBIR Bunga Berbasis Warna & Bentuk")
        self.root.geometry("900x600")

        self.dataset_folder = "flowers"  # Pastikan folder ini ada dan berisi gambar
        self.query_image_path = None
        self.features, self.image_paths = load_dataset_features(self.dataset_folder)

        self.query_label = tk.Label(root, text="Gambar Query")
        self.query_label.pack()

        self.query_panel = tk.Label(root)
        self.query_panel.pack()

        self.load_button = tk.Button(root, text="Pilih Gambar Query", command=self.select_query_image)
        self.load_button.pack(pady=10)

        self.result_frame = tk.Frame(root)
        self.result_frame.pack()

    def select_query_image(self):
        file_path = filedialog.askopenfilename(filetypes=[("Images", "*.jpg *.png *.jpeg")])
        if not file_path:
            return
        self.query_image_path = file_path
        self.show_query_image()
        self.search_similar_images()

    def show_query_image(self):
        image = Image.open(self.query_image_path).resize((200, 200))
        img = ImageTk.PhotoImage(image)
        self.query_panel.config(image=img)
        self.query_panel.image = img

    def search_similar_images(self):
        if self.query_image_path is None:
            return

        query_feat = extract_histogram_and_shape(self.query_image_path)
        if query_feat is None:
            messagebox.showerror("Error", "Gagal membaca gambar.")
            return

        query_feat = query_feat.reshape(1, -1)
        sims = cosine_similarity(query_feat, self.features)[0]
        top_idx = sims.argsort()[::-1][:3]

        # Hapus hasil sebelumnya
        for widget in self.result_frame.winfo_children():
            widget.destroy()

        tk.Label(self.result_frame, text="Top 3 Gambar Mirip (dengan Skor)", font=("Arial", 12, "bold")).pack()

#        Tampilkan gambar-gambar mirip
        for idx in top_idx:
            img = Image.open(self.image_paths[idx]).resize((100, 100))
            tk_img = ImageTk.PhotoImage(img)

            item_frame = tk.Frame(self.result_frame)
            item_frame.pack(side=tk.LEFT, padx=10)

            panel = tk.Label(item_frame, image=tk_img)
            panel.image = tk_img
            panel.pack()

            score = sims[idx]
            score_label = tk.Label(item_frame, text=f"Skor: {score:.4f}")
            score_label.pack()

# ======== Jalankan Aplikasi ========
if __name__ == "__main__":
    root = tk.Tk()
    app = CBIRApp(root)
    root.mainloop()
