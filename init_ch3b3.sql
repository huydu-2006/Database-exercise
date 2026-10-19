-- Exercise 3 (SQL_Ch3b3): schema + mock data (PostgreSQL, English)
-- DDL included because the file was empty; if the tables already exist, run from the INSERTs.
-- Project/department names used by the queries: 'Training Management', 'Remote Training', 'NCKH'.

DROP TABLE IF EXISTS WorksOn;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
    DepartmentID   VARCHAR(5)   PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL,
    Location       VARCHAR(50),
    PhoneNumber    VARCHAR(15)
);

CREATE TABLE Employee (
    EmployeeID   VARCHAR(5)   PRIMARY KEY,
    FullName     VARCHAR(50) NOT NULL,
    DateOfBirth  DATE,
    DepartmentID VARCHAR(5)   REFERENCES Department(DepartmentID)
);

CREATE TABLE Project (
    ProjectID   VARCHAR(5)    PRIMARY KEY,
    ProjectName VARCHAR(50)  NOT NULL,
    Budget      DECIMAL(12,2) NOT NULL
);

CREATE TABLE WorksOn (
    EmployeeID  VARCHAR(5)    NOT NULL REFERENCES Employee(EmployeeID),
    ProjectID   VARCHAR(5)    NOT NULL REFERENCES Project(ProjectID),
    HoursWorked DECIMAL(5,2)  NOT NULL,
    PRIMARY KEY (EmployeeID, ProjectID)
);

INSERT INTO Department VALUES
('P01', 'NCKH',          'Building A', '024-3869-1234'),
('P02', 'Training',      'Building B', '024-3869-2345'),
('P03', 'Administration','Building A', '024-3869-3456'),
('P04', 'Accounting',    'Building C', '024-3869-4567');

INSERT INTO Employee VALUES
('NV001', 'Alice Nguyen',  '1990-01-15', 'P01'),
('NV002', 'Brian Tran',    '1992-03-22', 'P01'),
('NV003', 'Carol Le',      '1988-07-10', 'P01'),
('NV004', 'David Pham',    '1995-11-02', 'P02'),
('NV005', 'Emma Hoang',    '1993-05-19', 'P02'),
('NV006', 'Frank Vu',      '1991-09-30', 'P03'),
('NV007', 'Grace Dang',    '1987-12-05', 'P04'),
('NV008', 'Henry Bui',     '1994-02-14', 'P04'),
('NV009', 'Ivy Do',        '1996-06-21', 'P02'),
('NV010', 'Jack Ngo',      '1990-08-03', 'P02'),
('NV011', 'Karen Phan',    '1989-10-17', 'P02'),
('NV012', 'Leo Ly',        '1997-04-08', 'P02'),
('NV013', 'Mia Trinh',     '1992-12-25', 'P02'),
('NV014', 'Nora Mai',      '1991-01-11', 'P03'),
('NV015', 'Oscar Cao',     '1986-03-09', 'P03'),
('NV016', 'Paula Ho',      '1998-07-27', 'P03'),
('NV017', 'Quinn Duong',   '1993-09-14', 'P03');

INSERT INTO Project VALUES
('DA01', 'Training Management', 80000.00),
('DA02', 'Remote Training',     60000.00),
('DA03', 'Information System',  120000.00),
('DA04', 'AI Research',         50000.00),
('DA05', 'Software Development', 5000.00),
('DA06', 'Mobile Application',  30000.00);

INSERT INTO WorksOn VALUES
('NV001', 'DA01', 40), ('NV001', 'DA02', 24), ('NV001', 'DA04', 60),
('NV002', 'DA01', 30), ('NV002', 'DA04', 45),
('NV003', 'DA01', 20), ('NV003', 'DA04', 30),
('NV004', 'DA01', 35), ('NV004', 'DA02', 20), ('NV004', 'DA03', 50),
('NV005', 'DA02', 15), ('NV005', 'DA03', 40),
('NV006', 'DA01', 25),
('NV009', 'DA03', 12), ('NV010', 'DA03', 18), ('NV011', 'DA03', 22),
('NV012', 'DA03', 16), ('NV013', 'DA03', 28), ('NV014', 'DA03', 14),
('NV015', 'DA03', 20), ('NV016', 'DA03', 10), ('NV017', 'DA03', 24);

-- Expected results (for checking your queries):
-- a) DA01, DA02, DA04            (budget 50,000 included, 120,000 excluded)
-- b) NV001 Alice Nguyen, NV002 Brian Tran, NV003 Carol Le, NV004 David Pham, NV006 Frank Vu
-- c) NV001, NV004                (both Training Management and Remote Training)
-- d) NV002, NV003, NV006         (only Training Management)
-- e) P04                         (Accounting: nobody participates)
-- f) DA01, DA04                  (all 3 NCKH employees participate)
-- g) 63333.33                    ((80000 + 60000 + 50000) / 3)
-- h) 5
-- i) DA01, DA02, DA04, DA05, DA06  (inner-join solutions lose DA05/DA06: 0 participants)
-- j) DA03                        (11 participants)
