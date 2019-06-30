-- Homework 選三題

-- 0. 每個辦公室的業績狀況表
select of.officeCode, sum(od.quantityOrdered*od.priceEach) as totalSales
from offices of join employees e using(officeCode)
join customers c on (c.salesRepEmployeeNumber=e.employeeNumber)
join orders o using(customerNumber) 
join orderdetails od using(orderNumber) 
where o.status='shipped' 
group by of.officeCode
order by totalSales desc;
-- officeCode	totalSales
-- 4	        2812295.95
-- 1	        1329614.32
-- 7	        1324325.90
-- 3	        1072619.47
-- 6	        1033246.60
-- 2	        835882.33
-- 5	        457110.07

-- 1. 業務業績排行榜, procedure
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `salesRank`()
NO SQL
BEGIN
select e.employeenumber, sum(od.quantityOrdered*od.priceEach) as totalSales
from orders o
join orderdetails od  using(orderNumber) 
join customers c using(customerNumber)
join employees e on (c.salesRepEmployeeNumber=e.employeenumber)
where o.status='shipped' 
group by e.employeenumber
order by totalSales desc;
END$$
DELIMITER ;
-- employeenumber	totalSales
-- 1370	            1065035.29
-- 1165	            1021661.89
-- 1401	            790297.44
-- 1501	            686653.25
-- 1504	            637672.65
-- 1323	            584406.80
-- 1337	            569485.75
-- 1612	            523860.78
-- 1611	            509385.82
-- 1286	            488212.67
-- 1621	            457110.07
-- 1216	            449219.13
-- 1702	            387477.47
-- 1188	            386663.20
-- 1166	            307952.43

-- 2. 熱銷商品排行榜, procedure
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `hotProduct`()
NO SQL
BEGIN
select od.productCode, p.productname, sum(od.quantityOrdered) as count 
from products as p
join orderdetails as od on p.productCode = od.productCode
join orders o on o.orderNumber=od.orderNumber
where o.status = 'Shipped'
group by productCode
order by count desc;
END$$
DELIMITER ;
-- productCode	 productname	                count
-- S18_3232	     1992 Ferrari 360 Spider red	1720
-- S18_1342	     1937 Lincoln Berline	        1060
-- S18_2949	     1913 Ford Model T Speedster	1028
-- S12_4473	     1957 Chevy Pickup	            1023
-- S24_2000	     1960 BSA Gold Star DBD34	    1015
-- S18_4721	     1957 Corvette Convertible	    1013
-- S24_3856	     1956 Porsche 356A Coupe	    1013
-- S12_2823	     2002 Suzuki XREO	            1007
-- S24_1578	     1997 BMW R 1100 S	            998
-- S50_4713	     2002 Yamaha YZR M1	            992

-- 3. 業務訂單取消的比例 orders.sttaus = canceled
-- 4. 低於商品建議售價MSRP x 95% 的訂單及其實際售價
-- 5. 當訂單資料被修改及刪除的時候記錄在 log 資料表中, 時間及所有資料欄位