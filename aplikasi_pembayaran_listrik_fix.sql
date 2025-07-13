
DROP DATABASE IF EXISTS aplikasi_pembayaran_listrik_pascabayar;
CREATE DATABASE aplikasi_pembayaran_listrik_pascabayar;
USE aplikasi_pembayaran_listrik_pascabayar;

CREATE TABLE level (
  id_level INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nama_level VARCHAR(50) DEFAULT NULL
);

INSERT INTO level (id_level, nama_level) VALUES (1, 'Admin'), (2, 'User');

CREATE TABLE tarif (
  id_tarif INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  daya INT DEFAULT NULL,
  tarifperkwh DECIMAL(10,2) DEFAULT NULL
);

INSERT INTO tarif (id_tarif, daya, tarifperkwh) VALUES (1, 900, 1350.00);

CREATE TABLE pelanggan (
  id_pelanggan INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nama_pelanggan VARCHAR(50) DEFAULT NULL,
  alamat VARCHAR(100) DEFAULT NULL,
  daya INT DEFAULT NULL,
  id_tarif INT DEFAULT NULL,
  FOREIGN KEY (id_tarif) REFERENCES tarif(id_tarif)
);

INSERT INTO pelanggan (nama_pelanggan, alamat, daya, id_tarif) VALUES
('nanang', 'kuningan', NULL, NULL),
('Budi', 'Jl. Merdeka No.1', 900, 1);

CREATE TABLE penggunaan (
  id_penggunaan INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_pelanggan INT DEFAULT NULL,
  bulan VARCHAR(20) DEFAULT NULL,
  meter_awal INT DEFAULT NULL,
  meter_akhir INT DEFAULT NULL,
  FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
);

INSERT INTO penggunaan (id_pelanggan, bulan, meter_awal, meter_akhir) VALUES
(1, '', 0, 0),
(1, 'Juli', 1200, 1350);

CREATE TABLE tagihan (
  id_tagihan INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_penggunaan INT DEFAULT NULL,
  jumlah_meter INT DEFAULT NULL,
  status VARCHAR(20) DEFAULT NULL,
  FOREIGN KEY (id_penggunaan) REFERENCES penggunaan(id_penggunaan)
);

INSERT INTO tagihan (id_penggunaan, jumlah_meter, status) VALUES
(1, 0, 'Belum Bayar');

CREATE TABLE user (
  id_user INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) DEFAULT NULL,
  password VARCHAR(50) DEFAULT NULL,
  nama_admin VARCHAR(50) DEFAULT NULL,
  id_level INT DEFAULT NULL,
  FOREIGN KEY (id_level) REFERENCES level(id_level)
);

INSERT INTO user (username, password, nama_admin, id_level) VALUES
('admin1', 'pass123', 'Admin Utama', 1);

CREATE TABLE pembayaran (
  id_pembayaran INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_tagihan INT DEFAULT NULL,
  id_pelanggan INT DEFAULT NULL,
  bulan_bayar VARCHAR(20) DEFAULT NULL,
  tanggal_pembayaran DATE DEFAULT NULL,
  total_bayar DECIMAL(10,2) DEFAULT NULL,
  id_user INT DEFAULT NULL,
  FOREIGN KEY (id_tagihan) REFERENCES tagihan(id_tagihan),
  FOREIGN KEY (id_user) REFERENCES user(id_user),
  FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
);
