Select Dname , Dphone
From donors;


Select nname,age 
From needy_people 
Order by age desc;


Select n.Dname , t.dtype
From donors  n , donations  t ,donate  c
Where t.dno=c.dno and
n.ssn=c.dssn;



Delete From donors
where Dname='Bassem';


select pro_name ,cost
from project
order by cost;



Select n.Dname 
from donors n  join donate c
on n.ssn=c.dssn
 join donations t on t.dno=c.dno
where t.dtype="clothes";


Select p.nname
From needy_people p natural join receptionists s 
Where s.rnames='mohamed';



Select  count(e.dname) as Donor_name
,t.dtype as Donation_type 
From  donors e  join  donate c on e.ssn=c.dssn
join donations t  on  t.dno=c.dno
Group by t.dtype;

 
 
select nname, age, ntype
from needy_people natural join orphans 
union 
Select nname , age , ntype
from needy_people natural join patients;

 
 
select d.dname,d.ssn,t.dtype 
from (donors d left outer join donate c on d.ssn=c.dssn) 
natural join donations t
Where t.dtype='food';



Select d.dname ,t.dtype
From donors  d join donate c on d.ssn=c.dssn
join donations t  on  t.dno=c.dno
where (dtype) in(
select dtype 
from donors  d join donate c on d.ssn=c.dssn
join donations t  on  t.dno=c.dno
where  d.ssn=998754654);



select nname
from needy_people  natural join poor_people 
where ntype in(
select t.dtype 
from donors n  join donate c
on n.ssn=c.dssn
 join donations t on t.dno=c.dno
);

 
 select i.itype,i.quantity, d.dname
from items i ,donors d,donations t ,donate c
where d.ssn=c.dssn and t.dno=c.dno 
and i.itype=t.dtype;


Select ino,itype ,quantity,iname
from items natural join i_names;



select nname ,des_oname ,rnames
from (needy_people natural join orphans)natural join receptionists
where ntype='money' 
union
select nname ,des_name ,rnames
from (needy_people natural join poor_people)natural join receptionists
where ntype='money';




