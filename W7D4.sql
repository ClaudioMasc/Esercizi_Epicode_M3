
#Esercizio 1

create view Product as
select
    p.ProductKey,
    p.EnglishProductName as NomeProdotto,
    s.EnglishProductSubcategoryName as Sottocategoria,
    c.EnglishProductCategoryName as Categoria
from dimproduct p
join dimproductsubcategory s
on p.ProductSubcategoryKey = s.ProductSubcategoryKey
join dimproductcategory c
on s.ProductCategoryKey = c.ProductCategoryKey
;

#Esercizio 2
create view Reseller as
select
    r.ResellerKey,
    r.ResellerName as NomeReseller,
    g.City as Città,
    g.EnglishCountryRegionName as Regione
from factresellersales frs
join dimreseller r
on frs.ResellerKey = r.ResellerKey
join dimgeography g
on r.GeographyKey = g.GeographyKey
;

#Controllo le mie due view
select * from Reseller;
select * from Product;

#Esercizio 3
create or replace view Sales as 
select
	p.ProductKey,
    r.ResellerKey,
    frs.OrderDate as DataOrdine,
    frs.SalesOrderNumber,
    frs.SalesOrderLineNumber,
    frs.OrderQuantity as QuantitaVenduta,
    frs.SalesAmount as ImportoTot,
    (frs.SalesAmount - frs.TotalProductCost) as Profitto
from dimproduct p
join factresellersales frs
on p.ProductKey = frs.ProductKey
join dimreseller r
on frs.ResellerKey = r.ResellerKey
;

select * from Sales;
