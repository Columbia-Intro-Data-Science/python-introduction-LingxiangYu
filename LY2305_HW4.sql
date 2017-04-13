--HW4 LY2305

-- 1. Give a count of all videos currently out
select count(1) from rental r
   where r.return_date is NULL;



-- 2. Make a list of all customer names who have videos out and how much they owe
select c.customer_id, c.first_name, c.last_name, count(c.customer_id) as c
   from rental r
   join customer c on c.customer_id = r.customer_id
   where r.return_date is NULL
   group by c.customer_id
   order by c asc;



-- 3. Give the most popular actors by store location
----(1)Two stores mix together
select ad.address, a.first_name, a.last_name, count(a.actor_id) as p
      from inventory i
      join rental r on r.inventory_id = i.inventory_id
      join film_actor f on f.film_id = i.film_id
      join actor a on a.actor_id = f.actor_id
      join staff s on s.staff_id = r.staff_id
      join store st on st.store_id = s.store_id
      join address ad on ad.address_id = s.address_id
      group by a.actor_id, ad.address
      order by p desc;

----(2)Only store_id = 1
select ad.address, a.first_name, a.last_name, count(a.actor_id) as p
    from inventory i
    join rental r on r.inventory_id = i.inventory_id
    join film_actor f on f.film_id = i.film_id
    join actor a on a.actor_id = f.actor_id
    join staff s on s.staff_id = r.staff_id
    join store st on st.store_id = s.store_id
    join address ad on ad.address_id = s.address_id
    where r.staff_id = 1
    group by a.actor_id, ad.address
    order by p desc;

---(3)Only store_id = 2
select ad.address, a.first_name, a.last_name, count(a.actor_id) as p
    from inventory i
    join rental r on r.inventory_id = i.inventory_id
    join film_actor f on f.film_id = i.film_id
    join actor a on a.actor_id = f.actor_id
    join staff s on s.staff_id = r.staff_id
    join store st on st.store_id = s.store_id
    join address ad on ad.address_id = s.address_id
    where r.staff_id = 2
    group by a.actor_id, ad.address
    order by p desc;



-- 4. Which store is more profitable, assuming all movies cost $15 per inventory item to purchase. 
---(the 6th question on the slide)
select s.store, (s.total_sales - 15*count(i.inventory_id)) as profit
  from sales_by_store s
  join staff_list sl on sl.name = s.manager
  join inventory i on i.store_id = sl.sid
  group by s.store, s.total_sales;
  

