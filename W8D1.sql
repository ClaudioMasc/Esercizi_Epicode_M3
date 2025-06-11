
#1
create table Region (
   RegionID INT PRIMARY KEY,
   City VARCHAR(100),
   Region VARCHAR(100),
   AreaGeografica VARCHAR(100)
);

#2
create table Store (
   StoreID INT PRIMARY KEY,
   Nome VARCHAR(100),
   DataApertura DATE,
   RegionID INT,
   FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
   );
   
#3
INSERT INTO Region (RegionID, City, Region, AreaGeografica) VALUES
(1, 'Milano', 'Lombardia', 'Nord'),
(2, 'Torino', 'Piemonte', 'Nord'),
(3, 'Roma', 'Lazio', 'Centro'),
(4, 'Firenze', 'Toscana', 'Centro'),
(5, 'Napoli', 'Campania', 'Sud'),
(6, 'Bari', 'Puglia', 'Sud'),
(7, 'Palermo', 'Sicilia', 'Sud')
;

INSERT INTO Store (StoreID, Nome, DataApertura, RegionID) VALUES
(1, 'Store Milano Centro', '2022-03-15', 1),
(2, 'Store Torino Lingotto', '2021-11-05', 2),
(3, 'Store Roma Nord', '2023-01-10', 3),
(4, 'Store Firenze Centro', '2022-07-01', 4),
(5, 'Store Napoli Est', '2021-06-22', 5),
(6, 'Store Bari Mare', '2020-09-17', 6),
(7, 'Store Palermo Sud', '2024-02-28', 7)
;

select * from Region;
select * from Store;

#4
start transaction;
update Store
set nome = 'Store Milano Duomo'
where StoreID = 1
;

update Region
set AreaGeografica = 'Centro-Sud'
where RegionID = 3
;

delete from Store
where StoreID = 2;

delete from Region 
where RegionID = 2;

select * from Region;
select * from Store;

rollback;