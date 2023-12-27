-- primeira parte
 
set @@autocommit = 0;

show session variables like '%isolation';
set session transaction isolation level read committed;

START TRANSACTION;

select concat(Fname,' ', Minit,' ',Lname) as name, Sex, Salary, Dependent_Name 
        from employee e
        inner join Dependent d on e.Ssn = d.Essn 
        and Salary > 20000;
        
commit;

START TRANSACTION;

update employee set salary = 20000 where Dno = 1;

commit;

-- Segunda parte

delimiter $$
create procedure new_project(
	in Pname_p varchar(15),
	in Pnumber_p int,
	in Plocation_p varchar(15),
	in Dnum_p int
)
begin
    declare exit handler for sqlexception
    begin
		show errors limit 1;
        rollback to savepoint insert_rlbk;
    end;
    
    START TRANSACTION;
    
	savepoint insert_rlbk;
    
	insert into project (Pname,Pnumber,Plocation,Dnum) values (Pname_p,Pnumber_p,Plocation_p,Dnum_p);
    
    commit;
    
end $$
delimiter ;

call new_project('Projeto desafio dio.me','99','Vila Velha','1');

