#Inizio ad esplorare le tabelle per vedere su cosa fare la join
SELECT *
FROM dimproduct
;
SELECT *
FROM dimproductsubcategory
;

#Punto 1
SELECT
p.ProductKey,
p.EnglishProductName AS NomeProdotto,
s.EnglishProductSubcategoryName AS SottoCategoria
FROM dimproduct p
JOIN dimproductsubcategory s 
ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
;

#Punto 2
SELECT
p.ProductKey,
p.EnglishProductName AS NomeProdotto,
s.EnglishProductSubCategoryName AS SottoCategoria,
c.EnglishProductCategoryName AS Categoria
FROM dimproduct p
JOIN dimproductsubcategory s 
ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
JOIN dimproductcategory c
ON s.ProductCategoryKey = c.ProductCategoryKey
;

#Punto 3
SELECT DISTINCT
p.ProductKey,
p.EnglishProductName AS NomeProdotto
FROM dimproduct p
JOIN factresellersales r
ON p.ProductKey = r.ProductKey
;
#Variante punto 3 con aggiunta colonna che mostra le vendite totali
SELECT
p.ProductKey,
p.EnglishProductName AS NomeProdotto,
SUM(r.SalesAmount) AS TotaleVendite
FROM dimproduct p
JOIN factresellersales r
ON p.ProductKey = r.ProductKey
GROUP BY
p.ProductKey,
p.EnglishProductName
;

#Punto 4
SELECT 
p.ProductKey,
p.EnglishProductName AS NomeProdotto
FROM dimproduct p
LEFT JOIN factresellersales r
ON p.ProductKey = r.ProductKey
WHERE r.ProductKey IS NULL
AND FinishedGoodsFlag  = 1
;
#Punto 4 con Subquery
SELECT DISTINCT 
p.ProductKey,
p.EnglishProductName AS NomeProdotto,
p.FinishedGoodsFlag AS ProdottiFiniti
FROM dimproduct p
WHERE FinishedGoodsFlag  = 1
AND p.ProductKey NOT IN (SELECT DISTINCT ProductKey
FROM factresellersales)
;

#Punto 5
SELECT
r.SalesOrderNumber AS NumeroOrdine,
r.OrderDate AS DataOrdine,
r.ProductKey,
p.EnglishProductName AS NomeProdotto,
r.OrderQuantity AS Quantita,
r.UnitPrice AS PrezzoUnitario,
r.SalesAmount AS TotaleVendite
FROM dimproduct p
JOIN factresellersales r
ON p.ProductKey = r.ProductKey
;

#Punto 6
SELECT
r.SalesOrderNumber AS NumeroOrdine,
r.OrderDate AS DataOrdine,
r.ProductKey,
p.EnglishProductName AS NomeProdotto,
c.EnglishProductCategoryName AS Categoria,
r.OrderQuantity AS Quantita,
r.UnitPrice AS PrezzoUnitario,
r.SalesAmount AS TotaleVendite
FROM dimproduct p
JOIN dimproductsubcategory s 
ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
JOIN dimproductcategory c
ON s.ProductCategoryKey = c.ProductCategoryKey
JOIN factresellersales r
ON p.ProductKey = r.ProductKey
;

#Punto 7
SELECT *
FROM dimreseller;

#Punto 8
SELECT 
r.ResellerKey,
r.ResellerName,
r.BusinessType,
g.City,
g.StateProvinceName,
g.EnglishCountryRegionName
FROM dimreseller r
JOIN dimgeography g
ON r.GeographyKey = g.GeographyKey
;

#Punto 9
SELECT 
  frs.SalesOrderNumber,
  frs.SalesOrderLineNumber,
  frs.OrderDate,
  frs.UnitPrice,
  frs.OrderQuantity AS Quantity,
  frs.TotalProductCost,
  p.EnglishProductName AS ProductName,
  c.EnglishProductCategoryName AS Category,
  r.ResellerName,
  g.City,
  g.StateProvinceName,
  g.EnglishCountryRegionName
FROM dimproduct p
JOIN factresellersales frs
  ON p.ProductKey = frs.ProductKey
JOIN dimproductsubcategory s
  ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
JOIN dimproductcategory c
  ON s.ProductCategoryKey = c.ProductCategoryKey
JOIN dimreseller r
  ON frs.ResellerKey = r.ResellerKey
JOIN dimgeography g
  ON r.GeographyKey = g.GeographyKey;
