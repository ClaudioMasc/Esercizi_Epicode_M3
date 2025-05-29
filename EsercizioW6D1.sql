SELECT * FROM dimproduct;

SELECT 
  ProductKey AS ID_Prodotto,
  ProductAlternateKey AS Codice_Modello,
  EnglishProductName AS Nome_Prodotto,
  Color AS Colore,
  StandardCost AS Costo_Standard,
  FinishedGoodsFlag AS Prodotto_Finito
FROM dimproduct
WHERE FinishedGoodsFlag = 1;

SELECT 
  ProductKey AS ID_Prodotto,
  ProductAlternateKey AS Codice_Modello,
  EnglishProductName AS Nome_Prodotto,
  StandardCost AS Costo_Standard,
  ListPrice AS Prezzo_Listino
FROM dimproduct
WHERE FinishedGoodsFlag = 1
AND ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';

SELECT 
  ProductKey AS ID_Prodotto,
  ProductAlternateKey AS Codice_Modello,
  EnglishProductName AS Nome_Prodotto,
  StandardCost AS Costo_Standard,
  ListPrice AS Prezzo_Listino,
  (ListPrice - StandardCost) AS Markup
FROM dimproduct
WHERE FinishedGoodsFlag = 1
AND ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';

SELECT 
  ProductKey AS ID_Prodotto,
  ProductAlternateKey AS Codice_Modello,
  EnglishProductName AS Nome_Prodotto,
  StandardCost AS Costo_Standard,
  ListPrice AS Prezzo_Listino,
  (ListPrice - StandardCost) AS Markup
FROM dimproduct
WHERE FinishedGoodsFlag = 1
AND ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%'
AND ListPrice BETWEEN 1000 AND 2000;

SELECT *
FROM dimemployee;

SELECT *
FROM dimemployee
WHERE SalesPersonFlag = 1;

SELECT * 
FROM factresellersales;

SELECT * 
FROM factresellersales
WHERE (OrderDate >= '2020-01-01')
AND (ProductKey IN (597,598, 477, 214));

SELECT SalesOrderNumber, OrderDate, ProductKey, OrderQuantity, UnitPrice, TotalProductCost, 
(SalesAmount - TotalProductCost) AS Profitto
FROM factresellersales
WHERE (OrderDate >= '2020-01-01')
AND (ProductKey IN (597,598, 477, 214));