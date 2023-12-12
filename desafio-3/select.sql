use ecommerce;

-- Quantos pedidos foram feitos por cada cliente?
select c.idClient, concat(Fname, ' ', Lname) AS clientName, count(*) AS quantidade 
from clients c 
inner join orders p 
where c.idClient = p.idOrderClient
group by c.idClient;

-- Algum vendedor é também fornecedor ?

SELECT s.idSeller, s.SocialName, s.AbstName, s.CNPJ, s.CPF, s.location, s.contact, f.idSupplier, f.SocialName, f.CNPJ, f.contact 
FROM seller s 
INNER JOIN supplier f ON s.CNPJ = f.CNPJ

 -- Relação de nomes dos fornecedores e nomes dos produtos; 
SELECT a.idSupplier, a.SocialName, b.idPsSupplier, b.idPsProduct, c.idProduct, c.Pname
FROM supplier a 
INNER JOIN productsupplier b ON a.idSupplier = b.idPsSupplier
INNER JOIN product c ON b.idPsProduct = c.idProduct


-- seleciona as compras realizadas 
select * 
from clients c, orders o 
where c.idClient = o.idOrderClient;

 