from typing import Union
from fastapi import FastAPI
from mysql.connector import Error
import json
import db

app = FastAPI()


@app.get("/dsnd")
def get_danh_sach_nguoi_dung():
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        sql = "SELECT * FROM `nguoidung`"
        cursor.execute(sql)
        rows = cursor.fetchall()
        data = []
        for row in rows:
            data.append(
                {
                    "MaND": row[0],
                    "HoTen": row[1],
                    "GioiTinh": row[2],
                    "NgaySinh": row[3].strftime("%Y/%m/%d"),
                    "SDT": str(row[4]),
                    "Email": row[5],
                    "TaiKhoan": row[6],
                    "MatKhau": row[7],
                    "isAdmin": row[8],
                }
            )
        # Đóng con trỏ và kết nối
        cursor.close()
        conn.close()
        return data
    else:
        print(f"Lỗi kết nối: {conn}")


@app.get("/nd/{mand}")
def get_nguoi_dung(mand: int):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        sql = "SELECT * FROM `nguoidung` WHERE MaND = %s"
        adr = (mand,)
        cursor.execute(sql, adr)
        rows = cursor.fetchall()
        if len(rows) > 0:
            data = []
            data.append(
                {
                   "MaND": rows[0][0],
                    "HoTen": rows[0][1],
                    "GioiTinh": rows[0][2],
                    "NgaySinh": rows[0][3].strftime("%Y/%m/%d"),
                    "SDT": str(rows[0][4]),
                    "Email": rows[0][5],
                    "TaiKhoan": rows[0][6],
                    "MatKhau": rows[0][7],
                    "isAdmin": rows[0][8],
                }
            )
            # Đóng con trỏ và kết nối
            cursor.close()
            conn.close()
            return data
        else:
            # Đóng con trỏ và kết nối
            conn.close()
            return {"message": "Không tìm thấy dữ liệu."}
    else:
        print(f"Lỗi kết nối: {conn}")


@app.post("/thennd")
def add_nguoi_dung(
    HoTen: str,
    GioiTinh: str,
    NgaySinh: str,
    SDT: str,
    Email: str,
    TaiKhoan: str,
    MatKhau: str,
    isAdmin: str,
):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        sql = """INSERT INTO `nguoidung`(`HoTen`, `GioiTinh`, `NgaySinh`, `SDT`, `Email`, `TaiKhoan`, `MatKhau`, `isAdmin`) 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"""
        adr = (
            HoTen,
            GioiTinh,
            NgaySinh,
            SDT,
            Email,
            TaiKhoan,
            MatKhau,
            isAdmin
        )

        try:
            cursor.execute(sql, adr)
            conn.commit()
            # Đóng con trỏ và kết nối
            cursor.close()
            conn.close()
            return {"message": "Thêm người dùng thành công."}
        except Error as e:
            # Đóng con trỏ và kết nối
            conn.close()
            return {"message": "Thêm người dùng thất bại:" + str(e)}
    else:
        print(f"Lỗi kết nối: {conn}")


@app.put("/suand/{MaND}")
def edit_nguoi_dung(
    MaND: int,
    HoTen: str = None,
    GioiTinh: str = None,
    NgaySinh: str = None,
    SDT: str = None,
    Email: str = None,
    TaiKhoan: str = None,
    MatKhau: str = None,
    isAdmin: str = None,
):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()

        try:
            # Thực hiện cập nhật dữ liệu, các trường không cung cấp sẽ được đặt NULL
            sql = """
                UPDATE nguoidung
                SET HoTen = %s, GioiTinh = %s, NgaySinh = %s, SDT = %s, Email = %s, TaiKhoan = %s, MatKhau = %s, isAdmin = %s
                WHERE MaND = %s
            """
            cursor.execute(
                sql,
                (
                    HoTen,
                    GioiTinh,
                    NgaySinh,
                    SDT,
                    Email,
                    TaiKhoan,
                    MatKhau,
                    isAdmin,
                    MaND,
                ),
            )
            conn.commit()

            # Đóng kết nối
            cursor.close()
            conn.close()

            return {"message": "Cập nhật người dùng thành công."}
        except Error as e:
            conn.close()
            return {"message": "Cập nhật người dùng thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}


#Kiểm tra đăng nhập
@app.post("/dangnhap")
def kiem_tra_dang_nhap(TaiKhoan: str, MatKhau: str):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()

        try:
            # Truy vấn kiểm tra tài khoản và mật khẩu
            sql = "SELECT * FROM nguoidung WHERE TaiKhoan = %s AND MatKhau = %s"
            cursor.execute(sql, (TaiKhoan, MatKhau))
            user = cursor.fetchone()

            # Kiểm tra kết quả
            if user:
                # Nếu tài khoản và mật khẩu đúng
                return {"message": "Đăng nhập thành công.", "user": user}
            else:
                # Nếu không khớp
                return {"message": "Sai tài khoản hoặc mật khẩu."}
        except Error as e:
            # Xử lý lỗi truy vấn
            return {"message": "Lỗi khi kiểm tra đăng nhập: " + str(e)}
        finally:
            # Đóng kết nối
            cursor.close()
            conn.close()
    else:
        return {"message": f"Lỗi kết nối: {conn}"}


#Thêm loaisanpham
@app.post("/loaisanpham")
def them_loai_san_pham(TenLoai: str):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()

        try:
            # Thêm loại sản phẩm
            sql = "INSERT INTO loaisanpham (TenLoai) VALUES (%s)"
            cursor.execute(sql, (TenLoai,))
            conn.commit()

            # Đóng kết nối
            cursor.close()
            conn.close()

            return {"message": "Thêm loại sản phẩm thành công."}
        except Error as e:
            conn.close()
            return {"message": "Thêm loại sản phẩm thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}

#Sửa loaisanpham
@app.put("/loaisanpham/{MaLoai}")
def sua_loai_san_pham(MaLoai: int, TenLoai: str):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()

        try:
            # Sửa tên loại sản phẩm
            sql = "UPDATE loaisanpham SET TenLoai = %s WHERE MaLoai = %s"
            cursor.execute(sql, (TenLoai, MaLoai))
            conn.commit()

            # Kiểm tra số hàng bị ảnh hưởng
            if cursor.rowcount == 0:
                conn.close()
                return {"message": "Không tìm thấy loại sản phẩm để cập nhật."}

            # Đóng kết nối
            cursor.close()
            conn.close()

            return {"message": "Cập nhật loại sản phẩm thành công."}
        except Error as e:
            conn.close()
            return {"message": "Cập nhật loại sản phẩm thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}

#Xoá loaisanpham
@app.delete("/loaisanpham/{MaLoai}")
def xoa_loai_san_pham(MaLoai: int):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()

        try:
            # Xóa loại sản phẩm
            sql = "DELETE FROM loaisanpham WHERE MaLoai = %s"
            cursor.execute(sql, (MaLoai,))
            conn.commit()

            # Kiểm tra số dòng dữ liệu bị xoá
            if cursor.rowcount == 0:
                conn.close()
                return {"message": "Không tìm thấy loại sản phẩm để xóa."}

            # Đóng kết nối
            cursor.close()
            conn.close()

            return {"message": "Xóa loại sản phẩm thành công."}
        except Error as e:
            conn.close()
            return {"message": "Xóa loại sản phẩm thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}

# Thêm sản phẩm
@app.post("/sanpham")
def them_san_pham(TenSP: str, DonGia: int, MoTa: str, MaLoai: int):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        try:
            sql = """
                INSERT INTO sanpham (TenSP, DonGia, MoTa, MaLoai)
                VALUES (%s, %s, %s, %s)
            """
            cursor.execute(sql, (TenSP, DonGia, MoTa, MaLoai))
            conn.commit()

            cursor.close()
            conn.close()
            return {"message": "Thêm sản phẩm thành công."}
        except Error as e:
            conn.close()
            return {"message": "Thêm sản phẩm thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}

# Sửa sản phẩm
@app.put("/sanpham/{MaSP}")
def sua_san_pham(MaSP: int, TenSP: str = None, DonGia: int = None, MoTa: str = None, MaLoai: int = None):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        try:
            updates = []
            params = []

            if TenSP:
                updates.append("TenSP = %s")
                params.append(TenSP)
            if DonGia:
                updates.append("DonGia = %s")
                params.append(DonGia)
            if MoTa:
                updates.append("MoTa = %s")
                params.append(MoTa)
            if MaLoai:
                updates.append("MaLoai = %s")
                params.append(MaLoai)

            if not updates:
                return {"message": "Không có trường nào được cung cấp để cập nhật."}

            params.append(MaSP)
            sql = f"UPDATE sanpham SET {', '.join(updates)} WHERE MaSP = %s"
            cursor.execute(sql, params)
            conn.commit()

            cursor.close()
            conn.close()
            return {"message": "Sửa sản phẩm thành công."}
        except Error as e:
            conn.close()
            return {"message": "Sửa sản phẩm thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}

#Get sanpham productlistcard
@app.get("/sanphamcard")
def get_san_pham_card():
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        sql = "SELECT sanpham.MaSP, sanpham.TenSP, sanpham.DonGia,`DuongDan` FROM `hinhanh` join `sanpham` on hinhanh.MaSP = sanpham.MaSP"
        cursor.execute(sql)
        rows = cursor.fetchall()
        data = []
        for row in rows:
            data.append(
                {
                    "MaSP": row[0],
                    "TenSP": row[1],
                    "DonGia": row[2],
                    "DuongDan": row[3],
                }
            )
        # Đóng con trỏ và kết nối
        cursor.close()
        conn.close()
        return data
    else:
        print(f"Lỗi kết nối: {conn}")

#Get sanpham theo MaSP
@app.get("/sanpham/{MaSP}")
def get_san_pham_by_id(MaSP: int):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        sql = "SELECT * FROM `sanpham` WHERE MaSP = %s"
        cursor.execute(sql, (MaSP,))
        row = cursor.fetchone()
        if row:
            data = {
                "MaSP": row[0],
                "MaLoai": row[1],
                "TenSP": row[2],
                "DonGia": row[3],
                "MoTa": row[4],
            }
            # Đóng con trỏ và kết nối
            cursor.close()
            conn.close()
            return data
        else:
            cursor.close()
            conn.close()
            return {"message": "Không tìm thấy sản phẩm."}
    else:
        print(f"Lỗi kết nối: {conn}")

#Get danh sách sản phẩm
@app.get("/sanpham")
def get_all_san_pham():
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        sql = "SELECT * FROM `sanpham`"
        cursor.execute(sql)
        rows = cursor.fetchall()
        data = []
        for row in rows:
            data.append(
                {
                    "MaSP": row[0],
                    "MaLoai": row[1],
                    "TenSP": row[2],
                    "DonGia": row[3],
                    "MoTa": row[4],
                }
            )
        # Đóng con trỏ và kết nối
        cursor.close()
        conn.close()
        return data
    else:
        print(f"Lỗi kết nối: {conn}")

#Xoá sản phẩm
@app.delete("/sanpham/{MaSP}")
def xoa_san_pham(MaSP: int):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        try:
            sql = "DELETE FROM sanpham WHERE MaSP = %s"
            cursor.execute(sql, (MaSP,))
            conn.commit()

            cursor.close()
            conn.close()
            return {"message": "Xóa sản phẩm thành công."}
        except Error as e:
            conn.close()
            return {"message": "Xóa sản phẩm thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}
    
# Thêm chi tiết sản phẩm
@app.post("/ctsanpham")
def them_chi_tiet_san_pham(MaSP: int, MaMau: int, MaSize: int, SoLuong: int):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        try:
            # Thêm chi tiết sản phẩm
            sql = """
                INSERT INTO ctsanpham (MaSP, MaMau, MaSize, SoLuong)
                VALUES (%s, %s, %s, %s)
            """
            cursor.execute(sql, (MaSP, MaMau, MaSize, SoLuong))
            conn.commit()

            cursor.close()
            conn.close()
            return {"message": "Thêm chi tiết sản phẩm thành công."}
        except Error as e:
            conn.close()
            return {"message": "Thêm chi tiết sản phẩm thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}

# Sửa chi tiết sản phẩm
@app.put("/ctsanpham/{MaCTSP}")
def sua_chi_tiet_san_pham(MaCTSP: int, MaMau: int = None, MaSize: int = None, SoLuong: int = None):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        try:
            updates = []
            params = []

            if MaMau:
                updates.append("MaMau = %s")
                params.append(MaMau)
            if MaSize:
                updates.append("MaSize = %s")
                params.append(MaSize)
            if SoLuong:
                updates.append("SoLuong = %s")
                params.append(SoLuong)

            if not updates:
                return {"message": "Không có trường nào được cung cấp để cập nhật."}

            params.append(MaCTSP)
            sql = f"UPDATE ctsanpham SET {', '.join(updates)} WHERE MaCTSP = %s"
            cursor.execute(sql, params)
            conn.commit()

            cursor.close()
            conn.close()
            return {"message": "Cập nhật chi tiết sản phẩm thành công."}
        except Error as e:
            conn.close()
            return {"message": "Cập nhật chi tiết sản phẩm thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}

# Xoá chi tiết sản phẩm
@app.delete("/ctsanpham/{MaCTSP}")
def xoa_chi_tiet_san_pham(MaCTSP: int):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        try:
            # Xóa chi tiết sản phẩm
            sql = "DELETE FROM ctsanpham WHERE MaCTSP = %s"
            cursor.execute(sql, (MaCTSP,))
            conn.commit()

            # Kiểm tra xem có dòng nào bị xóa không
            if cursor.rowcount == 0:
                conn.close()
                return {"message": "Không tìm thấy chi tiết sản phẩm để xóa."}

            cursor.close()
            conn.close()
            return {"message": "Xóa chi tiết sản phẩm thành công."}
        except Error as e:
            conn.close()
            return {"message": "Xóa chi tiết sản phẩm thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}

# Duyệt chi tiết sản phẩm theo MaSP
@app.get("/ctsanpham/{MaSP}")
def lay_chi_tiet_san_pham_theo_MaSP(MaSP: int):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        try:
            # Lấy chi tiết sản phẩm theo MaSP
            sql = "SELECT * FROM ctsanpham WHERE MaSP = %s"
            cursor.execute(sql, (MaSP,))
            rows = cursor.fetchall()

            cursor.close()
            conn.close()

            if rows:
                return rows
            else:
                return {"message": "Không có chi tiết sản phẩm nào cho MaSP này."}
        except Error as e:
            conn.close()
            return {"message": "Lấy chi tiết sản phẩm thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}
    
# Thêm hình ảnh
@app.post("/hinhanh")
def them_hinh_anh(MaSP: int, MaMau: int, DuongDan: str, Avatar:int):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        try:
            # Thêm hình ảnh
            sql = """
                INSERT INTO hinhanh (MaSP, MaMau, DuongDan, Avatar)
                VALUES (%s, %s, %s, %s)
            """
            cursor.execute(sql, (MaSP, MaMau, DuongDan, Avatar))
            conn.commit()

            cursor.close()
            conn.close()
            return {"message": "Thêm hình ảnh thành công."}
        except Error as e:
            conn.close()
            return {"message": "Thêm hình ảnh thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}

# Sửa hình ảnh
@app.put("/hinhanh/{MaHA}")
def sua_hinh_anh(MaHA: int, MaSP: int = None, MaMau: int = None, DuongDan: str = None):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        try:
            updates = []
            params = []

            if MaSP:
                updates.append("MaSP = %s")
                params.append(MaSP)
            if MaMau:
                updates.append("MaMau = %s")
                params.append(MaMau)
            if DuongDan:
                updates.append("DuongDan = %s")
                params.append(DuongDan)

            if not updates:
                return {"message": "Không có trường nào được cung cấp để cập nhật."}

            params.append(MaHA)
            sql = f"UPDATE hinhanh SET {', '.join(updates)} WHERE MaHA = %s"
            cursor.execute(sql, params)
            conn.commit()

            cursor.close()
            conn.close()
            return {"message": "Cập nhật hình ảnh thành công."}
        except Error as e:
            conn.close()
            return {"message": "Cập nhật hình ảnh thất bại : " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}

# Xoá hình ảnh
@app.delete("/hinhanh/{MaHA}")
def xoa_hinh_anh(MaHA: int):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        try:
            # Xóa hình ảnh
            sql = "DELETE FROM hinhanh WHERE MaHA = %s"
            cursor.execute(sql, (MaHA,))
            conn.commit()

            # Kiểm tra xem có dòng nào bị xóa không
            if cursor.rowcount == 0:
                conn.close()
                return {"message": "Không tìm thấy hình ảnh để xóa."}

            cursor.close()
            conn.close()
            return {"message": "Xóa hình ảnh thành công."}
        except Error as e:
            conn.close()
            return {"message": "Xóa hình ảnh thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}

# Duyệt hình ảnh theo MaSP và MaMau
@app.get("/hinhanh/{MaSP}/{MaMau}")
def lay_hinh_anh_theo_MaSP_MaMau(MaSP: int, MaMau: int):
    conn = db.connect_to_database()
    if not isinstance(conn, Error):
        cursor = conn.cursor()
        try:
            # Lấy hình ảnh theo MaSP và MaMau
            sql = "SELECT * FROM hinhanh WHERE MaSP = %s AND MaMau = %s"
            cursor.execute(sql, (MaSP, MaMau))
            rows = cursor.fetchall()

            cursor.close()
            conn.close()

            if rows:
                return rows
            else:
                return {"message": "Không có hình ảnh nào cho MaSP và MaMau này."}
        except Error as e:
            conn.close()
            return {"message": "Lấy hình ảnh thất bại: " + str(e)}
    else:
        return {"message": f"Lỗi kết nối: {conn}"}