-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 14, 2025 lúc 06:11 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `doandd`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ctdonhang`
--

CREATE TABLE `ctdonhang` (
  `MaCT` int(11) NOT NULL,
  `MaDH` int(11) NOT NULL,
  `MaCTSP` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL,
  `DonGia` int(11) NOT NULL,
  `TongTien` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ctsanpham`
--

CREATE TABLE `ctsanpham` (
  `MaCTSP` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `MaMau` int(11) NOT NULL,
  `MaSize` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhgia`
--

CREATE TABLE `danhgia` (
  `MaDG` int(11) NOT NULL,
  `MaND` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `DanhGia` double NOT NULL,
  `BinhLuan` varchar(200) NOT NULL,
  `NgayDG` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhsachyt`
--

CREATE TABLE `danhsachyt` (
  `MaND` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `diachigh`
--

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

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `donhang`
--

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

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giohang`
--

CREATE TABLE `giohang` (
  `MaND` int(11) NOT NULL,
  `MaCTSP` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hinhanh`
--

CREATE TABLE `hinhanh` (
  `MaHA` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `MaMau` int(11) NOT NULL,
  `DuongDan` varchar(500) NOT NULL,
  `Avatar` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `hinhanh`
--

INSERT INTO `hinhanh` (`MaHA`, `MaSP`, `MaMau`, `DuongDan`, `Avatar`) VALUES
(2, 1, 1, 'https://i.ibb.co/Mh5tDdR/vngoods-476766-sub7-3x4.jpg', 1),
(3, 2, 1, 'https://i.ibb.co/Mh5tDdR/vngoods-476766-sub7-3x4.jpg', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `loaisanpham`
--

CREATE TABLE `loaisanpham` (
  `MaLoai` int(11) NOT NULL,
  `TenLoai` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `loaisanpham`
--

INSERT INTO `loaisanpham` (`MaLoai`, `TenLoai`) VALUES
(1, 'Đồ Dệt Kim');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `mausac`
--

CREATE TABLE `mausac` (
  `MaMau` int(11) NOT NULL,
  `TenMau` varchar(45) NOT NULL,
  `MauHex` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `mausac`
--

INSERT INTO `mausac` (`MaMau`, `TenMau`, `MauHex`) VALUES
(1, 'Trắng xám', 'CBCCCC');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoidung`
--

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

--
-- Đang đổ dữ liệu cho bảng `nguoidung`
--

INSERT INTO `nguoidung` (`MaND`, `HoTen`, `GioiTinh`, `NgaySinh`, `SDT`, `Email`, `TaiKhoan`, `MatKhau`, `isAdmin`) VALUES
(2, 'tai', 1, '2004-01-02', '0981585608', 'tai23@gmail.com', 'vuongtam123', 'vuongtam123', 1),
(3, 'Hoàng Tiến', 1, '2004-02-04', '0981585608', 'hoangtien123gmail.com', 'hoangtien123', 'hoangtien123', 1),
(6, 'tien', 1, '2004-01-04', '0981575131', 'trantien@gmail.com', 'tien123', 'tien123', 1),
(7, 'tai', 1, '2004-01-04', '0981575131', 'trantien@gmail.com', 'tien123', 'tien123', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sanpham`
--

CREATE TABLE `sanpham` (
  `MaSP` int(11) NOT NULL,
  `MaLoai` int(11) NOT NULL,
  `TenSP` varchar(45) NOT NULL,
  `DonGia` int(11) NOT NULL,
  `MoTa` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `sanpham`
--

INSERT INTO `sanpham` (`MaSP`, `MaLoai`, `TenSP`, `DonGia`, `MoTa`) VALUES
(1, 1, 'Áo Len Cổ Trong', 489000, 'Áo dẹt bằng sợi polime cao cấp'),
(2, 1, 'Áo Polo Vải Len Dệt 3D', 356000, 'The soft feel of 100% cotton.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `size`
--

CREATE TABLE `size` (
  `MaSize` int(11) NOT NULL,
  `MaCTSP` int(11) NOT NULL,
  `Size` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `ctdonhang`
--
ALTER TABLE `ctdonhang`
  ADD PRIMARY KEY (`MaCT`),
  ADD KEY `ctdonhang_donhang` (`MaDH`),
  ADD KEY `ctdonhang_ctsanpham` (`MaCTSP`);

--
-- Chỉ mục cho bảng `ctsanpham`
--
ALTER TABLE `ctsanpham`
  ADD PRIMARY KEY (`MaCTSP`),
  ADD KEY `ctsanpham_sanpham` (`MaSP`),
  ADD KEY `ctsanpham_mausac` (`MaMau`);

--
-- Chỉ mục cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  ADD PRIMARY KEY (`MaDG`),
  ADD KEY `dannhgia_nguoidung` (`MaND`),
  ADD KEY `danhgia_sanpham` (`MaSP`);

--
-- Chỉ mục cho bảng `danhsachyt`
--
ALTER TABLE `danhsachyt`
  ADD PRIMARY KEY (`MaND`,`MaSP`),
  ADD KEY `danhsachyt_sanpham` (`MaSP`);

--
-- Chỉ mục cho bảng `diachigh`
--
ALTER TABLE `diachigh`
  ADD PRIMARY KEY (`MaDC`);

--
-- Chỉ mục cho bảng `donhang`
--
ALTER TABLE `donhang`
  ADD PRIMARY KEY (`MaDH`),
  ADD KEY `donhang_nguoidung` (`MaND`),
  ADD KEY `donhang_diachigh` (`MaDC`);

--
-- Chỉ mục cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD PRIMARY KEY (`MaND`,`MaCTSP`),
  ADD KEY `giohang_ctsanpham` (`MaCTSP`);

--
-- Chỉ mục cho bảng `hinhanh`
--
ALTER TABLE `hinhanh`
  ADD PRIMARY KEY (`MaHA`),
  ADD KEY `hinhanh_sanpham` (`MaSP`),
  ADD KEY `hinhanh_mausac` (`MaMau`);

--
-- Chỉ mục cho bảng `loaisanpham`
--
ALTER TABLE `loaisanpham`
  ADD PRIMARY KEY (`MaLoai`);

--
-- Chỉ mục cho bảng `mausac`
--
ALTER TABLE `mausac`
  ADD PRIMARY KEY (`MaMau`);

--
-- Chỉ mục cho bảng `nguoidung`
--
ALTER TABLE `nguoidung`
  ADD PRIMARY KEY (`MaND`);

--
-- Chỉ mục cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`MaSP`),
  ADD KEY `sanpham_loaisanpham` (`MaLoai`);

--
-- Chỉ mục cho bảng `size`
--
ALTER TABLE `size`
  ADD PRIMARY KEY (`MaSize`),
  ADD KEY `size_ctsanpham` (`MaCTSP`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `ctdonhang`
--
ALTER TABLE `ctdonhang`
  MODIFY `MaCT` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `ctsanpham`
--
ALTER TABLE `ctsanpham`
  MODIFY `MaCTSP` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  MODIFY `MaDG` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `diachigh`
--
ALTER TABLE `diachigh`
  MODIFY `MaDC` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `donhang`
--
ALTER TABLE `donhang`
  MODIFY `MaDH` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `hinhanh`
--
ALTER TABLE `hinhanh`
  MODIFY `MaHA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `loaisanpham`
--
ALTER TABLE `loaisanpham`
  MODIFY `MaLoai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `mausac`
--
ALTER TABLE `mausac`
  MODIFY `MaMau` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `nguoidung`
--
ALTER TABLE `nguoidung`
  MODIFY `MaND` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `MaSP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `size`
--
ALTER TABLE `size`
  MODIFY `MaSize` int(11) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `ctdonhang`
--
ALTER TABLE `ctdonhang`
  ADD CONSTRAINT `ctdonhang_ctsanpham` FOREIGN KEY (`MaCTSP`) REFERENCES `ctsanpham` (`MaCTSP`),
  ADD CONSTRAINT `ctdonhang_donhang` FOREIGN KEY (`MaDH`) REFERENCES `donhang` (`MaDH`);

--
-- Các ràng buộc cho bảng `ctsanpham`
--
ALTER TABLE `ctsanpham`
  ADD CONSTRAINT `ctsanpham_mausac` FOREIGN KEY (`MaMau`) REFERENCES `mausac` (`MaMau`),
  ADD CONSTRAINT `ctsanpham_sanpham` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`);

--
-- Các ràng buộc cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  ADD CONSTRAINT `danhgia_sanpham` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`),
  ADD CONSTRAINT `dannhgia_nguoidung` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`);

--
-- Các ràng buộc cho bảng `danhsachyt`
--
ALTER TABLE `danhsachyt`
  ADD CONSTRAINT `danhsachyt_nguoidung` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`),
  ADD CONSTRAINT `danhsachyt_sanpham` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`);

--
-- Các ràng buộc cho bảng `donhang`
--
ALTER TABLE `donhang`
  ADD CONSTRAINT `donhang_diachigh` FOREIGN KEY (`MaDC`) REFERENCES `diachigh` (`MaDC`),
  ADD CONSTRAINT `donhang_nguoidung` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`);

--
-- Các ràng buộc cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `giohang_ctsanpham` FOREIGN KEY (`MaCTSP`) REFERENCES `ctsanpham` (`MaCTSP`),
  ADD CONSTRAINT `giohang_nguoidung` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`);

--
-- Các ràng buộc cho bảng `hinhanh`
--
ALTER TABLE `hinhanh`
  ADD CONSTRAINT `hinhanh_mausac` FOREIGN KEY (`MaMau`) REFERENCES `mausac` (`MaMau`),
  ADD CONSTRAINT `hinhanh_sanpham` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`);

--
-- Các ràng buộc cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD CONSTRAINT `sanpham_loaisanpham` FOREIGN KEY (`MaLoai`) REFERENCES `loaisanpham` (`MaLoai`);

--
-- Các ràng buộc cho bảng `size`
--
ALTER TABLE `size`
  ADD CONSTRAINT `size_ctsanpham` FOREIGN KEY (`MaCTSP`) REFERENCES `ctsanpham` (`MaCTSP`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
