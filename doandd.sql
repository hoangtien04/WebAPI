SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `ctdonhang` (
  `MaCT` int(11) NOT NULL,
  `MaDH` int(11) NOT NULL,
  `MaCTSP` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL,
  `DonGia` int(11) NOT NULL,
  `TongTien` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `ctsanpham` (
  `MaCTSP` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `MaMau` int(11) NOT NULL,
  `MaSize` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `danhgia` (
  `MaDG` int(11) NOT NULL,
  `MaND` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `DanhGia` double NOT NULL,
  `BinhLuan` varchar(200) NOT NULL,
  `NgayDG` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `danhsachyt` (
  `MaND` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `diachigh` (
  `MaDC` int(11) NOT NULL,
  `NguoiNhan` varchar(45) NOT NULL,
  `SDT` varchar(10) NOT NULL,
  `DiaChiMD` tinyint(4) NOT NULL,
  `TinhThanh` varchar(45) NOT NULL,
  `QuanHuyen` varchar(45) NOT NULL,
  `PhuongXa` varchar(45) NOT NULL,
  `CTDiaChi` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `donhang` (
  `MaDH` int(11) NOT NULL,
  `MaND` int(11) NOT NULL,
  `MaDC` int(11) NOT NULL,
  `NgayDat` date NOT NULL,
  `NgayTT` date NOT NULL,
  `TongTien` int(11) NOT NULL,
  `PhuongThucTT` varchar(45) NOT NULL,
  `TrangThaiTT` varchar(45) NOT NULL,
  `TrangThaiDH` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `giohang` (
  `MaND` int(11) NOT NULL,
  `MaCTSP` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `hinhanh` (
  `MaHA` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `MaMau` int(11) NOT NULL,
  `DuongDan` varchar(500) NOT NULL,
  `Avatar` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `loaisanpham` (
  `MaLoai` int(11) NOT NULL,
  `TenLoai` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `mausac` (
  `MaMau` int(11) NOT NULL,
  `TenMau` int(11) NOT NULL,
  `MauHex` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `nguoidung` (
  `MaND` int(11) NOT NULL,
  `HoTen` varchar(45) DEFAULT NULL,
  `GioiTinh` tinyint(4) DEFAULT NULL,
  `NgaySinh` date DEFAULT NULL,
  `SDT` varchar(10) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `TaiKhoan` varchar(45) NOT NULL,
  `MatKhau` varchar(45) NOT NULL,
  `isAdmin` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `sanpham` (
  `MaSP` int(11) NOT NULL,
  `MaLoai` int(11) NOT NULL,
  `TenSP` varchar(45) NOT NULL,
  `DonGia` int(11) NOT NULL,
  `MoTa` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `size` (
  `MaSize` int(11) NOT NULL,
  `MaCTSP` int(11) NOT NULL,
  `Size` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `ctdonhang`
  ADD PRIMARY KEY (`MaCT`),
  ADD KEY `ctdonhang_donhang` (`MaDH`),
  ADD KEY `ctdonhang_ctsanpham` (`MaCTSP`);

ALTER TABLE `ctsanpham`
  ADD PRIMARY KEY (`MaCTSP`),
  ADD KEY `ctsanpham_sanpham` (`MaSP`),
  ADD KEY `ctsanpham_mausac` (`MaMau`);

ALTER TABLE `danhgia`
  ADD PRIMARY KEY (`MaDG`),
  ADD KEY `dannhgia_nguoidung` (`MaND`),
  ADD KEY `danhgia_sanpham` (`MaSP`);

ALTER TABLE `danhsachyt`
  ADD PRIMARY KEY (`MaND`,`MaSP`),
  ADD KEY `danhsachyt_sanpham` (`MaSP`);

ALTER TABLE `diachigh`
  ADD PRIMARY KEY (`MaDC`);

ALTER TABLE `donhang`
  ADD PRIMARY KEY (`MaDH`),
  ADD KEY `donhang_nguoidung` (`MaND`),
  ADD KEY `donhang_diachigh` (`MaDC`);

ALTER TABLE `giohang`
  ADD PRIMARY KEY (`MaND`,`MaCTSP`),
  ADD KEY `giohang_ctsanpham` (`MaCTSP`);

ALTER TABLE `hinhanh`
  ADD PRIMARY KEY (`MaHA`),
  ADD KEY `hinhanh_ctsanpham_sanpham` (`MaSP`),
  ADD KEY `hinhanh_ctsanpham_mausac` (`MaMau`);

ALTER TABLE `loaisanpham`
  ADD PRIMARY KEY (`MaLoai`);

ALTER TABLE `mausac`
  ADD PRIMARY KEY (`MaMau`);

ALTER TABLE `nguoidung`
  ADD PRIMARY KEY (`MaND`);

ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`MaSP`),
  ADD KEY `sanpham_loaisanpham` (`MaLoai`);

ALTER TABLE `size`
  ADD PRIMARY KEY (`MaSize`),
  ADD KEY `size_ctsanpham` (`MaCTSP`);


ALTER TABLE `ctdonhang`
  MODIFY `MaCT` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `ctsanpham`
  MODIFY `MaCTSP` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `danhgia`
  MODIFY `MaDG` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `diachigh`
  MODIFY `MaDC` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `donhang`
  MODIFY `MaDH` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `hinhanh`
  MODIFY `MaHA` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `loaisanpham`
  MODIFY `MaLoai` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `mausac`
  MODIFY `MaMau` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `nguoidung`
  MODIFY `MaND` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `sanpham`
  MODIFY `MaSP` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `size`
  MODIFY `MaSize` int(11) NOT NULL AUTO_INCREMENT;


ALTER TABLE `ctdonhang`
  ADD CONSTRAINT `ctdonhang_ctsanpham` FOREIGN KEY (`MaCTSP`) REFERENCES `ctsanpham` (`MaCTSP`),
  ADD CONSTRAINT `ctdonhang_donhang` FOREIGN KEY (`MaDH`) REFERENCES `donhang` (`MaDH`);

ALTER TABLE `ctsanpham`
  ADD CONSTRAINT `ctsanpham_mausac` FOREIGN KEY (`MaMau`) REFERENCES `mausac` (`MaMau`),
  ADD CONSTRAINT `ctsanpham_sanpham` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`);

ALTER TABLE `danhgia`
  ADD CONSTRAINT `danhgia_sanpham` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`),
  ADD CONSTRAINT `dannhgia_nguoidung` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`);

ALTER TABLE `danhsachyt`
  ADD CONSTRAINT `danhsachyt_nguoidung` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`),
  ADD CONSTRAINT `danhsachyt_sanpham` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`);

ALTER TABLE `donhang`
  ADD CONSTRAINT `donhang_diachigh` FOREIGN KEY (`MaDC`) REFERENCES `diachigh` (`MaDC`),
  ADD CONSTRAINT `donhang_nguoidung` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`);

ALTER TABLE `giohang`
  ADD CONSTRAINT `giohang_ctsanpham` FOREIGN KEY (`MaCTSP`) REFERENCES `ctsanpham` (`MaCTSP`),
  ADD CONSTRAINT `giohang_nguoidung` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`);

ALTER TABLE `hinhanh`
  ADD CONSTRAINT `hinhanh_ctsanpham_mausac` FOREIGN KEY (`MaMau`) REFERENCES `ctsanpham` (`MaMau`),
  ADD CONSTRAINT `hinhanh_ctsanpham_sanpham` FOREIGN KEY (`MaSP`) REFERENCES `ctsanpham` (`MaSP`);

ALTER TABLE `sanpham`
  ADD CONSTRAINT `sanpham_loaisanpham` FOREIGN KEY (`MaLoai`) REFERENCES `loaisanpham` (`MaLoai`);

ALTER TABLE `size`
  ADD CONSTRAINT `size_ctsanpham` FOREIGN KEY (`MaCTSP`) REFERENCES `ctsanpham` (`MaCTSP`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
