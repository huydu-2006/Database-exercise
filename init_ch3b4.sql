drop table IF EXISTS Enrollment, Course, Student;

create table Student (
    StudentID varchar(15) primary key,
    FullName varchar(255) not null,
    DateOfBirth date not null,
    Hometown varchar(255)
);

create table Course (
    CourseID varchar(15) primary key,
    CourseName varchar(255) not null,
    Instructor varchar(255)
);

create table Enrollment (
    CourseID varchar(15) references Course(CourseID),
    StudentID varchar(15) references Student(StudentID),
    Grade decimal(15, 2),
    primary key (CourseID, StudentID),
    constraint CHECK_Grade check ((0 <= Grade and Grade <= 10) and (Grade * 2 = FLOOR(Grade * 2)))
);

INSERT INTO Student VALUES
('20042325', 'Nguyen Van A', '2004-01-15', 'Hanoi'),
('20042326', 'Brian Tran',   '2004-03-22', 'Hanoi'),
('20042327', 'Carol Le',     '2004-05-10', 'Hai Phong'),
('20042328', 'David Pham',   '2004-07-02', 'Da Nang'),
('20042329', 'Emma Hoang',   '2004-09-18', 'Hanoi'),
('20042330', 'Frank Vu',     '2004-11-25', 'Hue'),
('20042331', 'Grace Dang',   '2005-01-08', 'Ho Chi Minh City'),
('20042332', 'Henry Bui',    '2005-02-14', 'Hanoi'),
('20042333', 'Ivy Do',       '2005-04-30', 'Hanoi');

INSERT INTO Course VALUES
('M1', 'Database',                   'Le Quan'),
('M2', 'Operating Systems',          'Nguyen Van B'),
('M3', 'Computer Networks',          'Le Quan'),
('M4', 'Artificial Intelligence',    'Tran Van C'),
('M5', 'Object-Oriented Programming', 'Le Quan'),
('M6', 'Data Structures',            'Pham Van D');

INSERT INTO Enrollment VALUES
('M1', '20042325', 8.5), ('M2', '20042325', 7.5), ('M5', '20042325', 8.0),
('M1', '20042326', 9.5), ('M3', '20042326', 8.0),
('M1', '20042327', 7.0), ('M2', '20042327', 8.5), ('M3', '20042327', 6.5),
('M2', '20042328', 6.0),
('M6', '20042329', 9.0),
('M5', '20042330', NULL),
('M1', '20042331', 9.0), ('M2', '20042331', 7.0), ('M3', '20042331', 8.5),
('M5', '20042331', 7.5), ('M6', '20042331', 8.0),
('M2', '20042332', 5.5), ('M6', '20042332', 6.0),
('M1', '20042333', 8.0), ('M3', '20042333', 9.0), ('M5', '20042333', 8.5);

-- Expected results (for checking your queries):
-- a) M1 Database, M2 Operating Systems, M3 Computer Networks, M4 Artificial Intelligence, M5 Object-Oriented Programming, M6 Data Structures
-- b) 20042325, 20042326, 20042329, 20042332, 20042333
-- c) 20042325, 20042326, 20042327, 20042328, 20042331, 20042332, 20042333
-- d) Database, Operating Systems, Object-Oriented Programming
-- e) Nguyen Van A, Brian Tran, Carol Le, Frank Vu, Grace Dang, Ivy Do
-- f) Database 8.5, Operating Systems 7.5, Object-Oriented Programming 8.0
-- g) 20042331, 20042333   (all 3 courses taught by Le Quan: M1, M3, M5)
-- h) M4 Artificial Intelligence   (no enrollments)
-- i) 20042331             (5 courses)
-- j) 8.00                 ((8.5 + 7.5 + 8.0) / 3)
-- k) Brian Tran           (Database, grade 9.5)

