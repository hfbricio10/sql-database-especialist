use company_constraints;

-- Número de empregados por departamento e localidade 

create or replace view num_employe_view as
	select count(distinct(Ssn)) AS "qtd", Dname AS "Departament", Dlocation AS "Dept Location"
	from employee e 
	left join departament d on e.Dno = d.Dnumber 
	inner join dept_locations dl on d.Dnumber = dl.Dnumber
	group by d.Dname;
    
select * from num_employee_view;

-- Lista de departamentos e seus gerentes 

create or replace view dept_managerview as 
	select Mgr_ssn, concat(Fname, Minit, Lname) as "manager", Dnumber as "dept_number", Dname as "dept_name"
	from employee e, departament d
	where d.Mgr_ssn = e.Ssn 
	order by Dnumber desc;

select * from dept_manager_view;

-- Projetos com maior número de empregados (ex: por ordenação desc) 

create or replace view proj_numb_view as
	select count(Ssn) as "qtd", Pno, Pname, Dnum
    from employee e
	left join works_on wk on e.Ssn = wk.Essn 
	inner join project p on wk.Pno = p.Pnumber
    group by p.Pnumber 
    order by Pno desc;
    
select * from proj_numb_view;

-- Lista de projetos, departamentos e gerentes 

create or replace view dept_proj_list_view as
	select Pname as "project", Plocation as "project_location", Dname AS "dept", Mgr_ssn
    from departament d
    left join project p on d.Dnumber = p.Dnum
	order by Dname, Pname desc;
    
 select * from dept_proj_list_view;


-- Quais empregados possuem dependentes e se são gerentes

create or replace view dependents_view as
    select concat(Fname,' ', Minit,' ',Lname) as "name_employee", Super_ssn as "manager", Dependent_Name as "dependent_name", Relationship 
	from employee e
	inner join dependent d on e.Ssn = d.Essn
	order by Super_Ssn asc;
          
select * from dependents_view;

-- permissões de acesso as views de acordo com o tipo de conta de usuários.

use mysql;

-- usuario com acesso a uma view em especifico
create user 'userespecific'@localhost identified by '123*456*';
grant all privileges on company_constraints.nome_da_view to 'userespecific'@localhost;

-- usuario com acesso a todas as views
create user 'usergeral'@localhost identified by '123456**';
grant all privileges on company_constraints.* to 'usergeral'@localhost;