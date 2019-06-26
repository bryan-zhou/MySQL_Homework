-- 銷售額前五的員工
select e.employeeid, e.firstname, e.lastname, sum(od.unitprice*od.quantity*(1-od.discount) - o.freight) as sales from orders o
join employees e on o.employeeid = e.employeeid
join `order details` od on o.orderid = od.orderid
group by e.employeeid order by sales desc limit 5;

-- +------------+-----------+-----------+--------------------+
-- | employeeid | firstname | lastname  | sales              |
-- +------------+-----------+-----------+--------------------+
-- |          4 | Margaret  | Peacock   | 195629.29573612887 |
-- |          3 | Janet     | Leverling |  167029.2228513775 |
-- |          1 | Nancy     | Davolio   | 163989.35437067712 |
-- |          2 | Andrew    | Fuller    | 140613.22483498263 |
-- |          8 | Laura     | Callahan  | 103557.85740648406 |
-- +------------+-----------+-----------+--------------------+


-- 銷售額前五的城市
select o.shipcity, sum(od.unitprice*od.quantity*(1-od.discount) - o.freight) as sales from orders o
join `order details` od on o.orderid = od.orderid
group by shipcity order by sales desc limit 5;

-- +------------+-----------+-----------+--------------------+
-- | employeeid | firstname | lastname  | sales              |
-- +------------+-----------+-----------+--------------------+
-- |          4 | Margaret  | Peacock   | 195629.29573612887 |
-- |          3 | Janet     | Leverling |  167029.2228513775 |
-- |          1 | Nancy     | Davolio   | 163989.35437067712 |
-- |          2 | Andrew    | Fuller    | 140613.22483498263 |
-- |          8 | Laura     | Callahan  | 103557.85740648406 |
-- +------------+-----------+-----------+--------------------+
