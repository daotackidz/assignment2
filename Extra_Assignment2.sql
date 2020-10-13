CREATE DATABASE ThucTap;
USE ThucTap;
CREATE TABLE Khoa
(Makhoa char(10)primary key,
Tenkhoa char(30),
Dienthoai char(10));
CREATE TABLE GiangVien(
Magv int primary key,
Hotengv char(30),
Luong decimal(5,2),
Makhoa char(10) references Khoa);
CREATE TABLE SinhVien(
Masv int primary key,
Hotensv char(40),
Makhoa char(10),
foreign key(Makhoa) references Khoa(Makhoa),
Namsinh int,
Quequan char(30));
CREATE TABLE DeTai(
Madt char(10)primary key,
Tendt char(30),
Kinhphi int,
Noithuctap char(30));
CREATE TABLE HuongDan(
Masv int primary key,
Madt char(10), 
foreign key (Madt) references DeTai(Madt),
Magv int, 
foreign key (Magv) references GiangVien(Magv),
KetQua decimal(5,2));
INSERT INTO Khoa VALUES
('Geo','Dia ly va QLTN',3855413),
('Math','Toan',3855411),
('Bio','Cong nghe Sinh hoc',3855412);
INSERT INTO GiangVien VALUES
(11,'Thanh Binh',700,'Geo'),    
(12,'Thu Huong',500,'Math'),
(13,'Chu Vinh',650,'Geo'),
(14,'Le Thi Ly',500,'Bio'),
(15,'Tran Son',900,'Math');
INSERT INTO SinhVien VALUES
(1,'Le Van Son','Bio',1990,'Nghe An'),
(2,'Nguyen Thi Mai','Geo',1990,'Thanh Hoa'),
(3,'Bui Xuan Duc','Math',1992,'Ha Noi'),
(4,'Nguyen Van Tung','Bio',null,'Ha Tinh'),
(5,'Le Khanh Linh','Bio',1989,'Ha Nam'),
(6,'Tran Khac Trong','Geo',1991,'Thanh Hoa'),
(7,'Le Thi Van','Math',null,'null'),
(8,'Hoang Van Duc','Bio',1992,'Nghe An');
INSERT INTO DeTai VALUES
('Dt01','GIS',100,'Nghe An'),
('Dt02','ARC GIS',500,'Nam Dinh'),
('Dt03','Spatial DB',100, 'Ha Tinh'),
('Dt04','MAP',300,'Quang Binh' );
INSERT INTO HuongDan VALUES
(1,'Dt01',13,8),
(2,'Dt03',14,0),
(3,'Dt03',12,10),
(5,'Dt04',14,7),
(6,'Dt01',13,Null),
(7,'Dt04',11,10),
(8,'Dt03',15,6);

/*--Câu 2:*/
SELECT GV.Magv, GV.Hotengv, K.Tenkhoa
FROM GiangVien GV join Khoa K
ON GV.Makhoa = K.Makhoa
;
/*--Câu 3:*/
SELECT GV.Magv, GV.Hotengv, K.Tenkhoa
FROM GiangVien GV JOIN Khoa K
ON GV.Makhoa = K.Makhoa 
WHERE K.Tenkhoa = 'Dia ly va QLTN'
;
/*--Câu 4:*/
SELECT COUNT(SV.MASV) AS SỐ_SV
FROM SinhVien SV
WHERE Makhoa=’Bio’
;
/*--Câu 5:*/
SELECT SV.Masv, SV.Hotensv
FROM SinhVien SV JOIN Khoa K
ON SV.Makhoa = K.Makhoa
WHERE K.Tenkhoa='TOAN'
;
/*--Câu 6:*/
SELECT COUNT(GV.Magv) AS SỐ_GV
FROM GiangVien GV join Khoa K
ON GV.Makhoa = K.Makhoa
WHERE K.Tenkhoa='CONG NGHE SINH HOC'
;
/*--Câu 7:*/
SELECT SV.Masv,SV.Hotensv
FROM SinhVien SV 
WHERE NOT EXISTS(
SELECT HD.Masv
FROM HuongDan HD 
WHERE SV.Masv = HD.Masv)
;
/*--Câu 8:*/
SELECT K.Makhoa,K.Tenkhoa, COUNT(K.Makhoa) AS SO_GV
FROM GiangVien GV JOIN Khoa K
ON GV.Makhoa = K.Makhoa
GROUP BY K.Makhoa,K.Tenkhoa
;
/*--Câu 9:*/
SELECT k.Dienthoai
FROM Khoa K join SinhVien SV
ON K.Makhoa = SV.Makhoa
WHERE SV.Hotensv = 'Le Van Son'
;
/*--Câu 10:*/
SELECT DT.Madt,DT.Tendt
FROM GiangVien GV join HuongDan HD
ON GV.Magv = HD.Magv
join DeTai DT
ON DT.Madt = HD.Madt
WHERE GV.Hotengv = 'Tran Son'
;
/*--Câu 11:*/
SELECT DT.Madt,DT.Tendt
FROM DeTai DT
WHERE NOT EXISTS(
SELECT HD.Madt
FROM HuongDan HD
WHERE HD.Madt = DT.Madt)
;
/*--Câu 12:*/
SELECT GV.Magv,GV.Hotengv,K.Tenkhoa
FROM GiangVien GV JOIN Khoa K
ON GV.Makhoa = K.Makhoa
WHERE GV.Magv IN (
SELECT HD.Magv
FROM HuongDan HD
GROUP BY HD.Magv
HAVING COUNT(HD.MaSV)>3)
;
/*--Câu 13:*/
SELECT DT.Madt,DT.Tendt
FROM DeTai DT 
WHERE DT.Kinhphi = (
SELECT MAX(DT.Kinhphi)
FROM DeTai DT)
;
/*--Câu 14:*/
SELECT DT.Madt,DT.Tendt
FROM DeTai DT
WHERE DT.Madt in (
SELECT HD.Madt
FROM HuongDan HD
GROUP BY HD.Madt
HAVING COUNT(HD.Madt) > 2)
;
/*--Câu 15:*/
SELECT SV.Masv,SV.Hotensv,HD.KetQua
FROM SinhVien SV JOIN HuongDan HD
ON SV.Masv = HD.Masv
JOIN Khoa K
ON K.Makhoa = SV.Makhoa
WHERE K.Tenkhoa = 'Dia ly va QLTN'
;
/*--Câu 16:*/
SELECT K.Tenkhoa, COUNT(SV.Masv) AS Số_SV
FROM SinhVien SV JOIN Khoa K
ON SV.Makhoa = K.Makhoa
GROUP BY K.Tenkhoa
;
/*--Câu 17:*/
SELECT *
FROM SinhVien SV JOIN HuongDan HD
ON HD.Masv = SV.Masv
JOIN DeTai DT
ON DT.Madt = HD.Madt
WHERE SV.Quequan = DT.Noithuctap
;
/*--Câu 18:*/
SELECT *
FROM SinhVien SV JOIN HuongDan HD
ON HD.Masv = SV.Masv
WHERE HD.KetQua is Null
;
/*--Câu 18:*/
SELECT SV.Masv,SV.Hotensv
FROM SinhVien SV JOIN HuongDan HD
ON HD.Masv = SV.Masv
WHERE HD.KetQua = 0
;