drop table if exists Employee, Department, WorksIn;

create table Employee (
    EID varchar(15) primary key,
    FullName varchar(255) not null,
    Age SMALLINT,
    Salary Decimal(15, 2)
);

create table Department (
    DID varchar(15) primary key,
    Name varchar(255) not null,
    Location varchar(255),
    Budget Decimal(15, 2),
    ManagerID varchar(15) references Employee(EID)
);

create table WorksIn (
    EID varchar(15) references Employee(EID),
    DID varchar(15) references Department(DID),
    TimeWorked Decimal(15, 2),
    primary key (EID, DID)
);

insert into Employee values
('E001', 'Alice Nguyen',  45, 1400000),
('E002', 'Brian Tran',    50, 1450000),
('E003', 'Carol Le',      47, 1350000),
('E004', 'David Pham',    38, 2400000),
('E005', 'Emma Hoang',    35, 2200000),
('E006', 'Frank Vu',      29, 1600000),
('E007', 'Grace Dang',    26,  750000),
('E008', 'Henry Bui',     41, 1900000),
('E009', 'Ivy Do',        33, 1700000),
('E010', 'Jack Ngo',      30, 1200000),
('E011', 'Karen Phan',    28, 1100000),
('E012', 'Leo Ly',        32, 1300000),
('E013', 'Mia Trinh',     27, 1050000),
('E014', 'Nora Mai',      36, 1600000),
('E015', 'Oscar Cao',     31, 1400000),
('E016', 'Paula Ho',      25, 1250000),
('E017', 'Quinn Duong',   44, 2000000),
('E018', 'Rita Vo',       39, 1850000),
('E019', 'Sam Bui',       34, 3000000),
('E020', 'Tina Lam',      28, 1150000),
('E021', 'Victor Nguyen', 29, 1000000),
('E022', 'Wendy Pham',    26,  950000),
('E023', 'Xuan Le',       42, 2100000),
('E024', 'Yen Ho',        37, 1800000),
('E025', 'Zack Tran',     24,  850000),
('E026', 'An Vo',         23,  800000),
('E027', 'Bao Do',        45, 2200000),
('E028', 'Chi Mai',       31, 5000000),
('E029', 'Dung Ngo',      40, 3300000),
('E030', 'Eli Phan',      22,  700000);

insert into Department values
('D1', 'Human Resource',      'Hanoi',             1500000, 'E001'),
('D2', 'Planning',            'Hanoi',             1200000, 'E002'),
('D3', 'Finance',             'Da Nang',           2500000, 'E002'),
('D4', 'Sales',               'Ho Chi Minh City',   800000, 'E003'),
('D5', 'IT',                  'Hanoi',             4500000, 'E003'),
('D6', 'Marketing',           'Ho Chi Minh City',  2000000, 'E004');

insert into WorksIn values
('E001', 'D1', 20), ('E002', 'D1', 20), ('E003', 'D1', 20), ('E004', 'D1', 20),
('E005', 'D1', 20), ('E006', 'D1', 20), ('E007', 'D1', 20), ('E008', 'D1', 20),
('E009', 'D1', 20), ('E010', 'D1', 20), ('E011', 'D1', 20), ('E012', 'D1', 20),
('E013', 'D1', 20), ('E014', 'D1', 20), ('E015', 'D1', 20), ('E016', 'D1', 20),
('E017', 'D1', 20), ('E018', 'D1', 20), ('E019', 'D1', 20), ('E020', 'D1', 20),
('E001', 'D2', 20), ('E002', 'D2', 20), ('E003', 'D2', 20), ('E011', 'D2', 20),
('E012', 'D2', 20), ('E013', 'D2', 20), ('E021', 'D2', 20), ('E022', 'D2', 20),
('E004', 'D3', 20), ('E005', 'D3', 20), ('E014', 'D3', 20), ('E023', 'D3', 20),
('E024', 'D3', 20),
('E006', 'D4', 20), ('E007', 'D4', 20), ('E015', 'D4', 20), ('E016', 'D4', 20),
('E025', 'D4', 20), ('E026', 'D4', 20),
('E010', 'D5', 20), ('E011', 'D5', 20), ('E012', 'D5', 20), ('E013', 'D5', 20),
('E014', 'D5', 20), ('E015', 'D5', 20), ('E016', 'D5', 20), ('E017', 'D5', 20),
('E018', 'D5', 20), ('E019', 'D5', 20), ('E020', 'D5', 20), ('E021', 'D5', 20),
('E022', 'D5', 20), ('E023', 'D5', 20), ('E024', 'D5', 20), ('E025', 'D5', 20),
('E026', 'D5', 20), ('E027', 'D5', 20), ('E028', 'D5', 40), ('E029', 'D5', 40),
('E030', 'D5', 40),
('E008', 'D6', 20), ('E009', 'D6', 20), ('E017', 'D6', 20), ('E018', 'D6', 20),
('E027', 'D6', 20);

-- Expected results (for checking your queries):
-- a) Alice Nguyen 45, Brian Tran 50, Carol Le 47, Karen Phan 28, Leo Ly 32, Mia Trinh 27
-- b) D5, 21                 (D1 has exactly 20 employees, so it is excluded)
-- c) Frank Vu, Chi Mai      (Frank: 1600000 > 1500000; Chi: 5000000 > 4500000)
-- d) E001, E002, E004       (E003 manages Sales, budget 800000 <= 1000000)
-- e) Carol Le               (IT has the highest budget, 4500000)
-- f) E003                   (Sales 800000 + IT 4500000 = 5300000)