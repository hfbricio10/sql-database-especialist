-- Triggers para o cenário company
-- Triggers de remoção: before delete statement
-- Triggers de atualização: before update statement

/* Usuários podem excluir suas contas por algum motivo. 
Dessa forma, para não perder as informações sobre estes usuários, 
crie um gatilho before remove */

use company_constraints;

-- cria a tabela em caso de empregados demitidos
create table if not exists fired_employees(	
    Fname varchar(40),
    Minit varchar(30),
    Lname varchar(40),
    Ssn char(9),
    Bdate date,
    Address Varchar(70),
    Sex char(1),
    Salary decimal(10,2),
    Super_Ssn char(9),
    Dno int
);

--  Trigger para salvar os empregados demitidos na tabela fired_employee
--  executada após delete em algum dado na tabela employee

delimiter %%
create trigger trg_fired_employee before delete on employee
	for each row
    begin 
		insert into fired_employees(Fname,Minit,Lname,Ssn,Bdate,Address,Sex,Salary,Super_Ssn,Dno) 
        values (old.Fname,	old.Minit, old.Lname, old.Ssn,old.Bdate, old.Address, old.Sex,old.Salary, old.Super_ssn, old.Dno);
	end %%
delimiter ; 
 
 -- drop trigger trg_fired_employee;
delete from company_constraints.employee where Ssn = '777654321';
-- select * from fired_employees;

-- trigger para ser executada após a atualização 

delimiter ||
create trigger trg_salary_updt before update on employee
	for each row
    begin
		if new.Salary is null then
			set new.Salary = 25000.00;
        end if;
    end ||
delimiter ;

-- select * from employee;

update company_constraints.employee set Salary = null
where Ssn = '123456789';

-- trigger para o cenário de ecommerce usando:
-- before insert statement
-- after insert statement 

use ecommerce;


delimiter //
create trigger ecommerce.trg_insert_new_client
before insert on ecommerce.clients
for each row
begin
    if exists (select 1 from ecommerce.clients where CPF = new.CPF) then
        signal sqlstate '45000'
       set message_text = 'Erro: CPF já cadastrado.';
    end if;
end;
//
delimiter ;

--  signal sqlstate '45000' foi usado para setar uma mensagem de erro 

  drop trigger trg_insert_new_client;

insert into clients (Fname, Minit, Lname, CPF, Address) 
values ('Pedro', 'C.', 'Cecatto', '123456789', null);

delimiter //
create trigger ecommerce.trg_after_new_client
after insert on ecommerce.clients
for each row
begin
	if new.idClient > 0 then
       signal sqlstate '45000' set message_text = 'Cliente inserido com sucesso!';    
    else
        signal sqlstate '45000' set message_text = 'Erro ao inserir o cliente';    
    end if;
end;
//
delimiter ;

insert into clients (Fname, Minit, Lname, CPF, Address) 
values ('Pedro', 'C.', 'Cecatto', '0000012', null);

