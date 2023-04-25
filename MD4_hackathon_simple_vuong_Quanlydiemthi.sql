create database QUANLYDIEMTHI;
use QUANLYDIEMTHI;

-- Tạo các bảng
create table Student (
studentID varchar(4) primary key,
studentName varchar(100) not null,
birthday date not null,
gender bit(1) not null,
address text not null,
phoneNumber varchar(45) unique
);

create table Subject (
subjectID varchar(4) primary key,
subjectName varchar(45) not null,
priority int(11) not null
);

create table Mark (
subjectID varchar(4),
studentID varchar(4),
point float not null,
primary key (subjectID,studentID),
foreign key (subjectID) references Subject(subjectID),
foreign key (studentID) references Student(studentID)
);


-- Thêm dữ liệu vào bảng
insert into Student values 
("S001","Nguyễn Thế Anh","1999-1-11",1,"Hà Nội","984678082"),
("S002","Đặng Bảo Trâm","1998-12-22",0,"Lào Cai","904982654"),
("S003","Trần Hà Phương","2000-05-05",0,"Nghệ An","947645363"),
("S004","Đỗ Tiến Mạnh","1999-03-26",1,"Hà Nội","983665353"),
("S005","Phạm Duy Nhất","1998-10-04",1,"Tuyên Quang","987242678"),
("S006","Mai Văn Thái","2002-06-22",1,"Nam Định","982654268"),
("S007","Giang Gia Hân","1996-11-10",0,"Phú Thọ","982364753"),
("S008","Nguyễn Ngọc Bảo My","1999-01-22",0,"Hà Nam","927867453"),
("S009","Nguyễn Tiến Đạt","1998-08-07",1,"Tuyên Quang","989274673"),
("S010","Nguyễn Thiều Quang","2000-09-18",1,"Hà Nội","984378291");

insert into Subject values 
("MH01","Toán",2),
("MH02","Vật Lý",2),
("MH03","Hóa Học",1),
("MH04","Ngữ Văn",1),
("MH05","Tiếng Anh",2);

insert into mark values 
("MH01","S001",8.5),
("MH02","S001",7),
("MH03","S001",9),
("MH04","S001",9),
("MH05","S001",5),
("MH01","S002",9),
("MH02","S002",8),
("MH03","S002",6.5),
("MH04","S002",8),
("MH05","S002",6),
("MH01","S003",7.5),
("MH02","S003",6.5),
("MH03","S003",8),
("MH04","S003",7),
("MH05","S003",7),
("MH01","S004",6),
("MH02","S004",7),
("MH03","S004",5),
("MH04","S004",6.5),
("MH05","S004",8),
("MH01","S005",5.5),
("MH02","S005",8),
("MH03","S005",7.5),
("MH04","S005",8.5),
("MH05","S005",9),
("MH01","S006",8),
("MH02","S006",10),
("MH03","S006",9),
("MH04","S006",7.5),
("MH05","S006",6.5),
("MH01","S007",9.5),
("MH02","S007",9),
("MH03","S007",6),
("MH04","S007",9),
("MH05","S007",4),
("MH01","S008",10),
("MH02","S008",8.5),
("MH03","S008",8.5),
("MH04","S008",6),
("MH05","S008",9.5),
("MH01","S009",7.5),
("MH02","S009",7),
("MH03","S009",9),
("MH04","S009",5),
("MH05","S009",10),
("MH01","S010",6.5),
("MH02","S010",8),
("MH03","S010",5.5),
("MH04","S010",4),
("MH05","S010",7);

--  Sửa tên sinh viên có mã `S004` thành “Đỗ Đức Mạnh”
update student set studentName = "Đỗ Đức Mạnh" where studentID = "S004";
-- Sửa tên và hệ số môn học có mã `MH05` thành “Ngoại Ngữ” và hệ số là 1.
update subject
set subjectName = "Ngoại Ngữ", priority = 1
where subjectID = "MH05";
-- Cập nhật lại điểm của học sinh có mã `S009` thành (MH01 : 8.5, MH02 : 7,MH03 : 5.5, MH04 : 6, MH05 : 9).
update mark
set point = 8.5
where (studentID = "S009") and (subjectID = "MH01");
update mark
set point = 7
where (studentID = "S009") and (subjectID = "MH02");
update mark
set point = 5.5
where (studentID = "S009") and (subjectID = "MH03");
update mark
set point = 6
where (studentID = "S009") and (subjectID = "MH04");
update mark
set point = 9
where (studentID = "S009") and (subjectID = "MH05");

-- Xoá toàn bộ thông tin của học sinh có mã `S010` bao gồm điểm thi ở bảng MARK và thông tin học sinh này ở bảng STUDENT
delete from mark where studentID = "S010";
delete from student where studentID = "S010";

-- Bài 3: Truy vấn dữ liệu
-- Lấy ra tất cả thông tin của sinh viên trong bảng Student
select * from student;

-- Hiển thị tên và mã môn học của những môn có hệ số bằng 1
select subjectName, subjectID
from subject
where priority = 1;

-- Hiển thị thông tin học sinh bao gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh. 
select studentID, studentName, (year(curdate())-year(birthday)) as Age , if(gender=1,"Nam","Nữ") as Gender, address
from student; 

-- Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn Toán và sắp xếp theo điểm giảm dần.
select s.studentName, sb.subjectName, m.point as Point
from mark m
join student s on s.studentID = m.studentID
join subject sb on sb.subjectID = m.subjectID
where m.subjectID = "MH01"
order by Point DESC;

-- Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng)
select (if(gender=1,"Nam","Nữ")) as Gender, count(gender) as Total
from student
group by Gender;

-- Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm để tính toán) , bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình
select s.studentID, s.studentName, sum(m.point) as Total, avg(m.point) as Average
from mark m
join student s on s.studentId = m.studentID
group by s.studentID;

-- Bài 4: Tạo View, Index, Procedure
-- Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học sinh, giới tính , quê quán .
CREATE VIEW STUDENT_VIEW AS
SELECT studentID as "Mã học sinh", studentName as "Tên học sinh", if(gender=1,"Nam","Nữ") as "Giới tính", address as "Quê Quán"
FROM student;
select * from STUDENT_VIEW;

-- Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh, điểm trung bình các môn học . 
CREATE VIEW AVERAGE_MARK_VIEW AS
SELECT s.studentID as "Mã HS", s.studentName as "Tên HS", avg(m.point) as "Điểm trung bình"
from student s 
join mark m on m.studentID = s.studentID
group by s.studentID;
select * from AVERAGE_MARK_VIEW;

-- Đánh Index cho trường `phoneNumber` của bảng STUDENT
CREATE INDEX PHONE_NUMBER ON student(phoneNumber);

-- Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả thông tin học sinh đó.
DELIMITER //
CREATE PROCEDURE PROC_INSERTSTUDENT
(IN studentID varchar(4), studentName varchar(100), birthday date, gender bit(1), address text, phoneNumber varchar(45))
BEGIN
  insert into student values (studentID,studentName,birthday,gender,address,phoneNumber);
END //

-- Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học. 
DELIMITER //
CREATE PROCEDURE PROC_UPDATESUBJECT
(IN subID varchar(4), newSubjectName varchar(45))
BEGIN
  update subject set subjectName = newSubjectName where subjectID = subID;
END //

-- Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học sinh.
DELIMITER //
CREATE PROCEDURE PROC_DELETEMARK
(IN stuID varchar(4))
BEGIN
	delete from mark where mark.studentID = stuID;
END //