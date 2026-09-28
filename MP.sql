#cust tanpa distinct
select customer_name
from showroom.datashowroom;

#Filter nama pelanggan unik (1)
select distinct customer_name
from showroom.datashowroom;

#Sebelum sadar penggunaan distinct (Mencari cust unik/hanya muncul sekali)
select customer_name
from showroom.datashowroom
group by customer_name
having count (*) = 1;

#Rekap transaksi kredit (2)
select order_id, branch, total_sales
from showroom.datashowroom
where payment_type = 'Kredit';

#Pembelian kuantitas terbanyak (3) (order by sales & completed)
select *
from showroom.datashowroom
#where status = 'completed'
order by quantity desc/*, total_sales desc*/;

#Model mobil 'hitam metalik' (4)
select distinct product_name, color
from showroom.datashowroom
where color = 'Hitam Metalik'
order by product_name;

#Komposisi metode (5)
select payment_type, count (*) as jumlah_transaksi
from showroom.datashowroom
group by payment_type;

#Evaluasi margin (6)
select category, avg(discount) as average_discount
from showroom.datashowroom
group by category
order by average_discount desc;

#Filter pendapatan (7)
select branch, sum(total_sales) as income
from showroom.datashowroom
group by branch
having income > 50000000000
order by income desc;

#Investigasi diskon (8)
select order_id, product_name, discount
from showroom.datashowroom
where discount >(
  select avg(discount)
  from showroom.datashowroom
);

#Pendapatan kategori (9)
select category, average_sales
from (
  select category, status, avg(total_sales) as average_sales
  from showroom.datashowroom
  group by category, status
) where status = 'completed';

#Cara where
select category, avg(total_sales) as average_sales
from showroom.datashowroom
where status = 'completed'
group by category;

#Model mobil terlaris|transaksi (10)
with product_count as(
  select product_name, count (*) as total_count
  from showroom.datashowroom
  group by product_name
)

select product_name, total_count
from product_count
order by total_count desc
limit 3;

#Cara from subquery|transaksi
select product_name, product_count
from (
  select product_name, count (*) as product_count
  from showroom.datashowroom
  group by product_name)
order by product_count desc
limit 3;

#Model mobil terlaris|quantity
with product_quantity as(
  select product_name, sum (quantity) as total_quantity
  from showroom.datashowroom
  group by product_name
)

select product_name, total_quantity
from product_quantity
order by total_quantity desc
limit 3;

#Cara from subquery|quantity
select product_name, product_quantity
from (
  select product_name, sum (quantity) as product_quantity
  from showroom.datashowroom
  group by product_name)
order by product_quantity desc
limit 3;


