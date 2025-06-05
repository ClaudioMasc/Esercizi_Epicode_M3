#Esercizio 1
#per essere una chiave primaria il campo ProductKey dovrebbe essere senza valori nulli e con valori univoci

#verifico che in ProductKey non ci siano valori nulli
select
	count(*) as totaleNull
from dimproduct
where ProductKey is null;

#adesso verifico che non ci siano valori duplicati
select
     count(*) as totaleRighe,
     count(distinct ProductKey) as ProductKeyDistinti
from dimproduct
;
#ProductKey può essere una chiave primaria

#Esercizio 2

#anche in questo caso bisogna verificare che la combinazione dei due campi risulti essere unica
select
SalesOrderNumber,
SalesOrderLineNumber,
count(*) as conteggio
from
factresellersales
group by
SalesOrderNumber, SalesOrderLineNumber
having
count(*) > 1
;

#verifico anche che non ci siano valori nulli
select *
from factresellersales
where SalesOrderNumber is null or SalesOrderLineNumber is null
;
#la combinazione dei campi è una PK

#Esercizio 3

select
OrderDate,
count(*) as NumeroTransazioni
from
factresellersales
where
OrderDate >= '2020-01-01'
group by
OrderDate
order by
OrderDate
;

#Esercizio 4

select
p.EnglishProductName as NomeProdotto,
frs.SalesAmount as FatturatoTotale,
frs.OrderQuantity as QuantitàTotVenduta,
avg(frs.UnitPrice) as PrezzoMedioVendita
from factresellersales frs
join
dimproduct p
on
frs.ProductKey = p.ProductKey
where OrderDate >= '2020-01-01'
group by
p.EnglishProductName
order by
FatturatoTotale desc
;

#Esercizio 5

select
c.EnglishProductCategoryName as CategoriaProdotto,
sum(frs.SalesAmount) as FatturatoTot,
sum(frs.OrderQuantity) as QuantitàTot
from factresellersales frs
join dimproduct p
on frs.ProductKey = p.ProductKey
join dimproductsubcategory s
on p.ProductSubcategoryKey = s.ProductSubcategoryKey
join dimproductcategory c
on s.ProductCategoryKey = c.ProductCategoryKey
group by c.EnglishProductCategoryName
order by FatturatoTot desc
;

#Esercizio 6

select
g.City as Città,
sum(frs.SalesAmount) as FatturatoTot
from factresellersales frs
join dimreseller r
on frs.ResellerKey = r.ResellerKey
join dimgeography g
on r.GeographyKey = g.GeographyKey
where frs.OrderDate >= '2020-01-01'
group by g.City
having sum(SalesAmount) > 60000
order by FatturatoTot desc
;