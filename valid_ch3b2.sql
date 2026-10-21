-- a
-- First solution
-- select e.fullname, e.age
-- from Employee e 
-- where exists (
--     select 1 from WorksIn w join Department d on w.did = d.did
--     where w.eid = e.eid and d.name = 'Human Resource'
-- )
-- and exists (
--     select 1 from WorksIn w join Department d on w.did = d.did
--     where w.eid = e.eid and d.name = 'Planning'
-- )

-- Second solution
-- select e.fullname, e.age
-- from WorksIn w 
-- join Department d on w.did = d.did
-- join employee e ON w.eid = e.eid 
-- where d.Name in ('Human Resource', 'Planning')
-- group by e.eid, e.fullname, e.age
-- having count(*) = 2;

-- b

-- select DID, count(distinct EID)
-- from WorksIn 
-- group by DID 
-- having count(distinct EID) > 20

-- c
-- First solution
-- select e.fullname
-- from Employee e  
-- where e.salary > (select max(budget) from (
--     select d.budget
--     from WorksIn w join Department d on w.did = d.did
--     where e.eid = w.eid
-- ));

-- Alternative: no empty-set trap (employees with no department are dropped)
-- select e.fullname
-- from Employee e
-- join WorksIn w on w.eid = e.eid
-- join Department d on d.did = w.did
-- group by e.eid, e.fullname, e.salary
-- having e.salary > max(d.budget);

-- d

-- First solution: "all P" = "no row where not P"
-- select distinct d.managerid
-- from Department d
-- where not exists (
--     select 1 from Department d2 where d.managerid = d2.managerid and d2.budget <= 1_000_000
-- );

-- Second solution: "all budgets > 1M" = "min budget > 1M"
-- select managerid
-- from Department
-- group by managerid
-- having min(budget) > 1_000_000;

-- e 

-- First solution
-- select distinct e.fullname
-- from Department d join Employee e on d.managerid = e.eid
-- where d.budget = (
--     select max(budget) from Department
-- );

-- Second solution
-- Alternative: same tie behavior, window function (generalizes to top-N)
-- select fullname
-- from (
--     select e.fullname, rank() over (order by d.budget desc) as r
--     from Department d join Employee e on d.managerid = e.eid
-- ) t
-- where r = 1;

-- f 

-- select managerid
-- from Department 
-- group by managerid 
-- having sum(budget) > 5_000_000