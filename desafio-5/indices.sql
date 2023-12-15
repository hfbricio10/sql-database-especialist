alter table employee add index employee_salary(Salary);
-- indice criado para otimizar a consulta por salario conforme query abaixo
alter table employee add index employee_department(Dno);
-- indice criado para dar mais performance a busca por departamento
alter table employee add index employee_name(Fname);
-- indice criado pois muitas consultas utilizam o nome do empregado 
alter table dependent add index relation_dependent(Relationship);
-- indice criado para otimizar a busca pela relacao do empregado com o dependente
alter table project add index project_location(Plocation);
-- indice criado para performar a query de local do projeto 
 

-- Qual departamento tem mais empregados?
select count(*) as qt_employers, Dnumber, Dname, Dept_create_date 
from departament d 
left join employee e on e.Dno = d.Dnumber
group by Dnumber
order by qt_employers desc;
    
-- Quais são os departamentos por cidade 
select Dnumber,Dname,Dlocation 
from dept_locations 
natural join departament 
order by Dnumber desc;

-- Relacao de emrpegado por departamento 
select Dnumber,Dname,CONCAT(Fname,' ',Minit,' ',Lname) as Employee_Name 
from Employee e 
left join Departament d on e.Dno = d.Dnumber
order by d.Dnumber desc;
    
-- Os 5 empregados mais bem pagos
select Ssn,CONCAT(Fname,' ',Minit,' ',Lname) as Employee_Name,Salary,Dnumber,Dname 
from employee e 
left join Departament d on e.Dno = d.Dnumber
order by Salary desc 
limit 5;

 -- Nome dos projetos com os seus departamentos associados e ordenado por cidades
select Pnumber,Pname,Plocation,Dname
from project p 
Inner Join departament d on p.Dnum = d.Dnumber 
order by Pnumber,Plocation;

 
-- Relação de empregados e seus dependentes 
select Essn as ID_Employee, CONCAT(Fname,' ',Minit,' ',Lname) as Employee_Name,Dependent_name, Relationship
from dependent d 
inner join Employee e on d.Essn = e.Ssn 
order by Essn;
    
 

-- Empregados e projetos que estão associados 
select Ssn as ID_Employee, concat(Fname,' ',Minit,' ',Lname) as  Employee_Name,Pname,Plocation,Dname 
from employee e 
inner join departament d on e.Dno = d.Dnumber
inner join project p on p.Dnum = d.Dnumber
order by ID_Employee;

   
-- Empregados e projetos associdos que estão localizados em Houston 
select Ssn as ID_Employee, concat(Fname,' ',Minit,' ',Lname) as Employee_Name,Pname,Plocation,Dname 
from employee e 
inner join departament d on e.Dno = d.Dnumber 
inner join project p on p.Dnum = d.Dnumber
where Plocation = 'Houston'
order by ID_Employee;
    
    
    
