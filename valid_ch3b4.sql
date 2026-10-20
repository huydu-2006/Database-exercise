-- a

-- select CourseName
-- from Course 

-- b

-- select StudentID, FullName, DateOfBirth from Student
-- where HomeTown = 'Hanoi'

-- c

-- select distinct Studentid
-- from enrollment
-- where courseid = 'M1' or courseid = 'M2'

-- d

-- select c.coursename
-- from Enrollment e join Course c on e.courseid = c.courseid
-- where e.studentid = '20042325'

-- e

-- First solution
-- select s.fullname
-- from Student s  
-- where exists ( 
--     select 1
--     from Enrollment e join Course c on e.courseid = c.courseid 
--     where e.studentid = s.studentid and c.instructor = 'Le Quan'
-- )

-- Second solution 
-- select s.fullname
-- from Student s  
-- where exists ( 
--     select 1
--     from Enrollment e  
--     where s.studentid = e.studentid and exists (
--         select 1
--         from Course c  
--         where e.courseid = c.courseid and c.instructor = 'Le Quan'
--     )
-- )

-- f

-- select c.coursename, e.grade
-- from Course c 
-- join Enrollment e on c.courseid = e.courseid
-- join Student s on e.studentid = s.studentid
-- where s.fullname = 'Nguyen Van A';

-- g

-- select s.studentid
-- from Student s  
-- where (
--     select count(e.courseid)
--     from Enrollment e join Course c on e.courseid = c.courseid 
--     where c.instructor = 'Le Quan' and e.studentid = s.studentid
-- )
-- = (
--     select count(courseid)
--     from Course 
--     where Instructor = 'Le Quan'
-- )
-- and exists (
--     select 1 from Course where Instructor = 'Le Quan'
-- );

-- Second solution
-- select s.studentid
-- from Student s  
-- where not exists (
--     select 1
--     from Course c  
--     where c.instructor = 'Le Quan' and not exists (
--         select 1 
--         from Enrollment e  
--         where s.studentid = e.studentid and e.courseid = c.courseid 
--     )
-- )

-- h

-- select c.courseid, c.coursename
-- from Course c  
-- where not exists (
--     select 1 
--     from enrollment e
--     where e.courseid = c.courseid
-- )


-- i

-- select studentid
-- from Enrollment 
-- group by studentid having count(*) >= 5

-- j

-- select round(avg(e.grade), 2)
-- from Student s join enrollment e ON e.studentid = s.studentid
-- where s.fullname = 'Nguyen Van A'

-- k

select s.fullname, e.grade
from Enrollment e
join Course c on c.courseid = e.courseid
join Student s on s.studentid = e.studentid
where c.coursename = 'Database'
  and e.grade = (select max(grade) from Enrollment e2 where e2.courseid = e.courseid);

