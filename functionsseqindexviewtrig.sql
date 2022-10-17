---Functions

CREATE OR REPLACE FUNCTION getpartner
RETURN deliveredby.partner_id%TYPE
IS
varpartner number:=0;
BEGIN
SELECT partner_id into varpartner from (SELECT partner_id from (SELECT count(partner_id), partner_id from deliveredby group by partner_id order by count(partner_id))fetch first 1 rows only);
RETURN varpartner;
END;
/

create or replace function getprice(
varproductid number
)
return product.price%type
is
s_varproductprice number:=0;
BEGIN

SELECT price INTO s_varproductprice
from product
where productid = varproductid;

RETURN s_varproductprice;

END;
/

create or replace function getamount(
varorderid number
)
return orders.amount%type
is
s_varorderid number:=0;
s_varquantity number:=0;
s_varproductid number:=0;
s_varamout number:=0;
BEGIN

SELECT sum(product_price*quantity) INTO s_varamout
from order_items
where orderid = varorderid;

RETURN s_varamout;

END;
/



CREATE OR REPLACE FUNCTION is_numeric (str IN VARCHAR2)
  RETURN INT
IS
  v_num NUMBER;
BEGIN
  v_num:=TO_NUMBER(str);
  RETURN 1;
EXCEPTION
WHEN VALUE_ERROR THEN
  RETURN 0;
END is_numeric;
/


---Sequences

create sequence seq_cust start with 1000
increment by 1;

create sequence seq_dlvptn start with 1000
increment by 1;

create sequence seq_supplier start with 1000
increment by 1;

create sequence seq_cat start with 100
increment by 1;

create sequence seq_prod start with 100
increment by 1;
create sequence seq_upc start with 100
increment by 1;
create sequence seq_sku start with 100
increment by 1;

create sequence seq_loc start with 100
increment by 1;

create sequence seq_dep start with 1
increment by 1;

create sequence seq_emp start with 1000
increment by 1;

create sequence seq_inventory start with 100
increment by 1;

create sequence seq_orders start with 1000
increment by 1;

create sequence seq_transaction start with 1000
increment by 1;


---Indexes

create index employees_i on employees ( empid,email,salary, deptno, mgrid );
create index CATEGORY_i on CATEGORY (category_main, sub_category );
create index customers_i on customers ( customer_email, customerid );
create index deliveredby_i on deliveredby (orderid);
create index deliverypartner_i on deliverypartner ( partner_id );
create index department_i on department ( deptno );
create index inventory_i on inventory ( inventory_id);
create index inventory_product_i on inventory_product ( productid );
create index order_items_i on order_items ( orderid, productid, product_price);
create index orders_i on orders ( orderid,transaction_id);
create index product_i on product (productid, price);
create index returns_i on returns ( orderid, customerid, product_id);
create index transactions_i on transactions ( orderid, payment_status);

---Views


CREATE OR REPLACE VIEW EmployeeDetailsWithGreaterSalaryThanManagers AS
SELECT a.empid as empid, a.salary as employeesalary, b.empid as managerid, b.salary as managersalary  FROM employees a
join employees b on a.mgrid = b.empid 
where a.salary > b.salary;


CREATE OR REPLACE VIEW expiredTransactionDetails AS 
SELECT * FROM transactions WHERE (card_expirydate - sysdate) < 0;



CREATE OR REPLACE VIEW mostDissatisfiedCustomersView AS
SELECT  customerid, count(customerid) 
as return_frequency 
from returns 
group by customerid 
order by count(customerid) desc fetch first 1 rows only;


CREATE OR REPLACE VIEW RecentProductExpiryDate AS
SELECT productid, product_name,brand, description,expiry_date from product where expiry_date < sysdate order by expiry_date desc fetch first 1 rows only;


CREATE OR REPLACE VIEW MostPurchaseByCustomer AS
SELECT customerid, sum(amount) as total from orders group by customerid order by total desc fetch first 1 rows only;



CREATE OR REPLACE VIEW MostReturnedProducts AS
SELECT product_id, count(*) as frequency from returns group by product_id;


CREATE OR REPLACE VIEW TotalAmountByCity AS
SELECT customers.city,sum(orders.amount) as total from 
customers join orders on customers.customerid = orders.customerid
group by customers.city;



CREATE OR REPLACE VIEW TotalAmountByCountry AS
SELECT customers.country,sum(orders.amount) as total 
from customers join orders on customers.customerid = orders.customerid
group by customers.country;


CREATE OR REPLACE VIEW CityOrdersByDate AS
SELECT customers.city,orders.order_date, orders.amount 
from customers join orders on customers.customerid = orders.customerid;


CREATE OR REPLACE VIEW CustomerView AS
SELECT p.productid,p.product_name,p.brand,p.description,p.expiry_date,c.category_id,c.sub_category,c.category_main
from product p join category c on c.category_id = p.category_id;

CREATE OR REPLACE VIEW InventoryDetails AS
SELECT i.inventory_id,i.inventory_name,i.storage_space,s.supplierno,Product_id from 
inventory i join supplier_inventory s on i.inventory_id = s.inventory_id;

CREATE OR REPLACE VIEW RecentOrders AS
SELECT orderid,customerid,amount,order_date from orders order by abs(order_date-sysdate) desc;

CREATE OR REPLACE VIEW YearlyAndMonthlyOrderCount AS
SELECT  EXTRACT(year from order_date) year, EXTRACT (month from order_date) month, COUNT(orderid) order_count FROM orders
GROUP BY EXTRACT(YEAR FROM order_date),EXTRACT(MONTH FROM order_date) Order by year desc,month;

CREATE OR REPLACE VIEW YearlySales AS
SELECT  EXTRACT(year from order_date) year, sum(amount) as total FROM orders
GROUP BY EXTRACT(YEAR FROM order_date) Order by year desc;

---Triggers
/*
CREATE OR REPLACE TRIGGER transactions_trigger1
AFTER INSERT
   ON transactions
   FOR EACH ROW
BEGIN
    UPDATE transactions set payment_status = 'Completed' WHERE payment_status = :new.payment_status;
    DBMS_OUTPUT.PUT_LINE('Payment - ' || :new.payment_status || ' completed successfully - by transactions_trigger1 Trigger');
END;
/
CREATE OR REPLACE TRIGGER deliveredby_trigger1
AFTER INSERT
   ON deliveredby
   FOR EACH ROW
BEGIN
    UPDATE Deliveredby set delivery_status = 'Completed' WHERE delivery_status = :new.delivery_status;
    DBMS_OUTPUT.PUT_LINE('Delivery - ' || :new.delivery_status || ' completed successfully - by deliveredby_trigger1 Trigger');
END;
*/


--- Access


create user customer identified by Custpass123$;
create user employee identified by Emplpass123$;
create user deliverypartner identified by Delivptn123$;
create user inventory_mngr identified by Supppass123$;
create user superuser identified by Superpass123$;
create user HR_mgr identified by HRmgrpass123$;
create user tech_department identified by Techdept123$;


/* CUSTOMERS */
grant insert on customers to customer;
grant select on product to customer;
grant insert, delete on order_items to customer;
grant update, insert on transactions to customer;
grant insert, update on orders to customer;

/* EMPLOYEES*/
grant insert, select, update, delete on product to employee;
grant insert, select, update, delete on category to employee;

/* DELIVERY PARTNER*/
grant update, select on deliveredby to deliverypartner;
grant select on orders to deliverypartner;
grant select on returns to deliverypartner;
grant select on inventory_product to deliverypartner;

/* INVENTORY MANAGER*/
grant update, select, insert on inventory to inventory_mngr;
grant select on supplier_inventory to inventory_mngr;
grant select on deliveredby to inventory_mngr;
grant select on orders to inventory_mngr;
grant select on returns to inventory_mngr;

/* TECH DEPARTMENT */
grant update, insert, select, delete on orders to tech_department;
grant update, insert, select, delete on order_items to tech_department;
 
 /* HR MANAGER */
grant update, insert, select, delete on employees to HR_mgr;
grant select on location to HR_mgr;
grant select on department to HR_mgr;
