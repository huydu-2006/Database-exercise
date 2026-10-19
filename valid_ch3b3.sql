-- a

-- select ProjectName  
-- from Project 
-- where Budget between 50000 and 100000

-- b 
-- select e.fullname
-- from Employee e
-- join WorksOn w on e.EmployeeID = w.EmployeeID 
-- join Project p on p.ProjectID = w.ProjectID 
-- where p.projectname = 'Training Management'; 

--c 

-- First solution
-- select e.fullname
-- from Employee e
-- join WorksOn w on e.EmployeeID = w.EmployeeID 
-- join Project p on p.ProjectID = w.ProjectID 
-- where p.ProjectName = 'Training Management'
-- intersect 
-- select e.fullname
-- from Employee e
-- join WorksOn w on e.EmployeeID = w.EmployeeID 
-- join Project p on p.ProjectID = w.ProjectID 
-- where p.ProjectName = 'Remote Training'

-- Second solution
-- select e.fullname
-- from Employee e  
-- join WorksOn w on e.EmployeeID = w.EmployeeID 
-- join Project p on p.ProjectID = w.ProjectID 
-- where p.projectname in ('Training Management', 'Remote Training')
-- group by e.fullname 
-- having count(distinct p.projectname) = 2

-- Third solution
-- select e.employeeid
-- from Employee e  
-- where exists (select 1 from WorksOn w join Project p on w.ProjectID = p.ProjectID
--               where w.EmployeeID = e.EmployeeID and p.ProjectName = 'Training Management')
-- and exists   (select 1 from WorksOn w join Project p on w.ProjectID = p.ProjectID
--               where w.EmployeeID = e.EmployeeID and p.ProjectName = 'Remote Training') 

-- d

-- select e.employeeid 
-- from Employee e  
-- where exists (select 1 from WorksOn w
--             join Project p on w.ProjectID = p.ProjectID
--             where w.EmployeeID = e.employeeid and p.ProjectName = 'Training Management')
-- and not exists (select 1 from WorksOn w
--             join Project p on w.ProjectID = p.ProjectID
--             where w.EmployeeID = e.employeeid and p.ProjectName = 'Remote Training')

-- e

-- First solution
-- select d.departmentid
-- from Department d  
-- left join Employee e on d.departmentid = e.departmentid 
-- left join WorksOn w on w.employeeid = e.employeeid 
-- group by d.departmentid 
-- having count(distinct w.projectid) = 0

-- Second solution
-- select d.departmentid
-- from Department d 
-- where not exists ( 
--     select 1
--     from Employee e join WorksOn w on e.EmployeeID = w.EmployeeID 
--     where e.departmentid = d.departmentid
-- )

-- f

-- First solution
-- select p.projectid, p.projectname, p.budget
-- from Project p
-- where not exists ( 
--     select 1
--     from Employee e
--     join Department d on e.departmentid = d.departmentid
--     where d.departmentname = 'NCKH' and not exists ( 
--         select 1 from WorksOn w 
--         where e.employeeid = w.employeeid and w.projectid = p.projectid
--     )
-- )
-- guard for edge case where there is no employee working in 'NCKH' department
-- and exists ( 
--     select 1 from Employee e join Department d on e.departmentid = d.departmentid 
--     where d.departmentname = 'NCKH'
-- ) 

-- Second solution
-- select p.projectid, p.projectname
-- from Project p
-- where (
--     select count(distinct e.employeeid)
--     from Employee e join Department d on e.departmentid = d.departmentid
--     where d.departmentname = 'NCKH'
-- )
-- = (
--     select count(distinct e.employeeid)
--     from Employee e
--     join WorksOn w on e.employeeid = w.employeeid
--     join Department d on e.departmentid = d.departmentid
--     where w.projectid = p.projectid and d.departmentname = 'NCKH'
-- )

-- g

-- select avg(p.budget)
-- from WorksOn w
-- join Project p on w.projectid = p.projectid
-- where w.employeeid = 'NV001'

-- h 

select count(w.employeeid)
from WorksOn w 
join Project p on w.projectid = p.projectid
where p.projectname = 'Training Management'