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






CREATE OR REPLACE PROCEDURE cust_proc
(
    x_fname customers.customer_fname%TYPE,
    x_lname customers.customer_lname%TYPE,
    x_gender customers.customer_gender%TYPE,
    x_phno customers.customer_phno%TYPE,
    x_email customers.customer_email%TYPE,
    x_dob customers.customer_dob%TYPE,
    x_address customers.street_address%TYPE,
    x_aptno customers.apt_house_no%TYPE,
    x_city customers.city%TYPE,
    x_state customers.state%TYPE,
    x_country customers.country%TYPE,
    x_zip customers.zip%TYPE
)
AS
    countEmail NUMBER;
    countPhno NUMBER;

    s_fname EXCEPTION;
    s_lname EXCEPTION;
    s_gender EXCEPTION;
    s_phno EXCEPTION;
    s_email EXCEPTION;
    s_dob EXCEPTION;
    s_address EXCEPTION;
    s_aptno EXCEPTION;
    s_city EXCEPTION;
    s_state EXCEPTION;
    s_country EXCEPTION;
    s_zip EXCEPTION;
    ss_gender customers.customer_gender%TYPE;
    dup_email EXCEPTION;
    dup_phno EXCEPTION;

    
Begin

IF x_fname IS NULL
THEN RAISE s_fname;

IF x_lname Is Null
THEN RAISE s_lname;

IF x_gender IS NULL
THEN RAISE s_gender;

If x_phno IS NULL
THEN RAISE s_phno;

IF x_email Is Null
THEN RAISE s_email;

IF x_dob IS NULL
THEN RAISE s_dob;

IF x_address IS NULL
THEN RAISE s_address;

IF x_aptno Is Null
THEN RAISE s_aptno;

IF x_city IS NULL
THEN RAISE s_city;

If x_state IS NULL
THEN RAISE s_state;

IF x_country IS NULL
THEN Raise s_country;

IF x_zip IS NULL
THEN RAISE s_zip;

END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;

SELECT COUNT(*) INTO countEmail FROM customers WHERE customer_email = x_email;
IF countEmail > 0 THEN
    RAISE dup_email;
END IF;

SELECT COUNT(*) INTO countPhno From customers WHERE customer_phno = x_phno;
IF countPhno > 0 THEN
    RAISE dup_phno;
END IF;

select x_gender into ss_gender from dual where x_gender IN ('M','F','T');

INSERT INTO customers(customerid,customer_fname,customer_lname,customer_gender,customer_phno,customer_email,customer_dob,street_address,apt_house_no,city,state,country,zip)
VALUES(seq_cust.nextval,x_fname,x_lname,x_gender,x_phno,x_email,x_dob,x_address,x_aptno,x_city,x_state,x_country,x_zip);


    

EXCEPTION

    WHEN dup_email THEN
        dbms_output.put_line('Email cannot be repeated ');
        
    WHEN dup_phno THEN
        dbms_output.put_line('Phone number cannot be repeated ');
        
    When s_fname THEN
        dbms_output.put_line('First Name cannot be null');

    WHEN s_lname THEN
        dbms_output.put_line('Last Name cannot be null');

    WHEN s_gender THEN
        dbms_output.put_line('Gender value cannot be null');

    When s_phno THEN
        dbms_output.put_line('Phone number cannot be null');
        
    WHEN s_email THEN
        dbms_output.put_line('Email ID cannot be null');
        
    WHEN s_dob THEN
        dbms_output.put_line('Date of Birth cannot be null');
        
    When s_address THEN
        dbms_output.put_line('Address cannot be null');
        
    WHEN s_aptno THEN
        dbms_output.put_line('Apartment number cannot be null');
        
    WHEN s_city THEN
        dbms_output.put_line('City cannot be null');
        
    WHEN s_state THEN
        dbms_output.put_line('State cannot be null');
        
    WHEN s_country THEN
        dbms_output.put_line('Country cannot be null');
        
    WHEN s_zip THEN
        dbms_output.put_line('Zip cannot be null');
        
    WHEN no_data_found THEN
        dbms_output.put_line('(M/F/T) genders entry only');

END;


CREATE OR REPLACE procedure delprtn_proc 
(
    x_partnerno deliverypartner.partner_no%TYPE,
    x_partnername deliverypartner.partner_name%TYPE
)
AS

dp_namenull exception;

BEGIN
if x_partnername is null then
  raise dp_namenull;

end if;


insert into deliverypartner(partner_id,partner_no,partner_name)
values(seq_dlvptn.nextval,x_partnerno,x_partnername);

EXCEPTION 
    when dp_namenull then
        DBMS_OUTPUT.PUT_LINE('Please fill all the details, partnername cannot be blank');

end;


CREATE OR REPLACE procedure proc_supplier 
(
    x_suppliername supplier.suppliername%TYPE,
    x_productid supplier.product_id%TYPE,
    x_quantsup supplier.quantity_suppliable%TYPE
)
AS
countprod number;
countsupp number;
s_namenull exception;
s_proidnull exception;
s_dupcolcomb exception;
s_countprod exception;

BEGIN
if x_suppliername is null then
  raise s_namenull;
IF x_productid is null then
    raise s_proidnull;
end if;
end if;
select count(*) into countsupp from supplier where product_id = x_productid and suppliername = x_suppliername;
if countsupp > 0 then
    raise s_dupcolcomb;
end if;

select count(*) into countprod from product where productid = x_productid;
if countprod < 1 then
    raise s_countprod;
end if;

insert into supplier(supplierno,suppliername,product_id,quantity_suppliable)
values(seq_supplier.nextval,x_suppliername,x_productid,x_quantsup);

EXCEPTION 
    when s_namenull then
        DBMS_OUTPUT.PUT_LINE('Please fill all the details, suppliername cannot be blank');
    when s_proidnull then
        DBMS_OUTPUT.PUT_LINE('Please fill all the details, productid cannot be blank');
    when s_dupcolcomb then
        DBMS_OUTPUT.PUT_LINE('combination of productid and suppliername already exists');
    when s_countprod then
        DBMS_OUTPUT.PUT_LINE('Productid invalid as it does not exist in Product table');
end;


CREATE OR REPLACE procedure cat_proc
(
   
    x_subcat category.sub_category%TYPE,
    x_categorymain category.category_main%TYPE
)
AS

cat_count number;
cat_combo exception;
s_categorymain exception;

BEGIN

select count(*) into cat_count from category where sub_category = x_subcat and category_main = x_categorymain;

if x_categorymain  is NULL then
	raise s_categorymain;
end if;
if cat_count > 0 then
    raise cat_combo;
end if;

insert into category(category_id,sub_category,category_main)
values(seq_cat.nextval,x_subcat,x_categorymain);


exception
    when s_categorymain then
        DBMS_OUTPUT.PUT_LINE('category_main cannot be null');
    when cat_combo then
        DBMS_OUTPUT.PUT_LINE('combination of sub_category and category_main already exists');

end;

CREATE OR REPLACE procedure proc_prod
(

x_price product.price%TYPE,
x_expiry product.expiry_date%TYPE,
x_productnm product.product_name%TYPE,
x_descrip product.description%TYPE,
x_brand product.brand%TYPE,
x_supid product.supplier_id%TYPE,
x_catid product.category_id%TYPE
)

AS
countcatidincat number;
countprod number;
pr_pricenull exception;
pr_expirynull exception;
pr_prodnamenull exception;
pr_descnull exception;
pr_brandnull exception;
pr_supidnull exception;
pr_catidnull exception;
pr_dupcol exception;
pr_countcatidincat exception;

BEGIN

if x_price is NULL
then raise pr_pricenull;
if x_expiry is NULL
then raise pr_expirynull;
if x_productnm is NULL
then raise pr_prodnamenull;
if x_descrip is NULL
then raise pr_descnull;
if x_brand is NULL
then raise pr_brandnull;
if x_supid is NULL
then raise pr_supidnull;
if x_catid is NULL
then raise pr_catidnull;

end if;
end if;
end if;
end if;
end if;
end if;
end if;

select count(*) into countcatidincat from category where category_id=x_catid ;
if countcatidincat < 1 then
	raise pr_countcatidincat ;
end if;
select count(*) into countprod from product where product_name = x_productnm;
if countprod > 0 then
    raise pr_dupcol;
end if;

insert into product(productid,upc_code,sku_code,price,expiry_date,product_name,description,brand,supplier_id,category_id)
values(seq_prod.nextval,seq_upc.nextval,seq_sku.nextval,x_price,x_expiry,x_productnm,x_descrip,x_brand,x_supid,x_catid);

EXCEPTION 
when pr_countcatidincat  then
     DBMS_OUTPUT.PUT_LINE('Categoryid invalid as it does not exist in category table');
when pr_pricenull then
     DBMS_OUTPUT.PUT_LINE('price value cannot be null');
when pr_expirynull then
     DBMS_OUTPUT.PUT_LINE('expiry date cannot be null');
when pr_prodnamenull then
     DBMS_OUTPUT.PUT_LINE('product name cannot be null');
when pr_descnull then
     DBMS_OUTPUT.PUT_LINE('description cannot be null');
when pr_brandnull then
     DBMS_OUTPUT.PUT_LINE('brand name cannot be null');
when pr_supidnull then
     DBMS_OUTPUT.PUT_LINE('supplier id cannot be null');
when pr_catidnull then
     DBMS_OUTPUT.PUT_LINE('category id cannot be null');
when pr_dupcol then
    DBMS_OUTPUT.PUT_LINE('that product already exists');

end;

CREATE OR REPLACE procedure proc_loc
(
  
  x_locname location.location_name%TYPE,
  x_locmgrid location.location_mgrid%TYPE
)

AS 

countloc number;
l_locname exception;
l_locmgrid exception;
l_dupcol exception;

BEGIN
if x_locname is NULL 
then raise l_locname;
if x_locmgrid is NULL
then raise l_locmgrid;
end if;
end if;

select count(*) into countloc from location where location_name = x_locname and location_mgrid = x_locmgrid;
if countloc > 0 then
    raise l_dupcol;
end if;

insert into location(locationno,location_name,location_mgrid)
values(seq_loc.nextval,x_locname,x_locmgrid);

EXCEPTION
when l_locname then 
    DBMS_OUTPUT.PUT_LINE('location name cannot be null');
when l_locmgrid then
    DBMS_OUTPUT.PUT_LINE('Manager Id cannot be null');
when l_dupcol then
    DBMS_OUTPUT.PUT_LINE('combination of location name and location manager id already exists');
end;

CREATE OR REPLACE procedure proc_dep
(
   
    x_deptname department.deptname%TYPE,
    x_deptadd department.deptaddress%TYPE,
    x_locationno department.locationno%TYPE
)

AS 
countloca number;
countdept number;
d_deptname exception;
d_deptadd exception;
d_locationno exception;
d_deptcol exception;
d_countloca exception;


BEGIN

if x_deptname is NULL
then raise d_deptname;
if x_deptadd is NULL
then raise d_deptadd;
if x_locationno is NULL
then raise d_locationno;
end if;
end if;
end if;

select count(*) into countloca from location where locationno=x_locationno ;
select count(*) into countdept from department where deptname = x_deptname and deptaddress = x_deptadd and locationno = x_locationno;
if countloca< 1 then
    raise d_countloca; 
end if;
if countdept > 0 then
    raise d_deptcol;
end if;

insert into department(deptno,deptname,deptaddress,locationno)
values(seq_dep.nextval,x_deptname,x_deptadd,x_locationno);

EXCEPTION


when d_countloca then 
    DBMS_OUTPUT.PUT_LINE('Locationno doesnt exist in location table');
when d_deptname then 
    DBMS_OUTPUT.PUT_LINE('Department name cannot be null');
when d_deptadd then
    DBMS_OUTPUT.PUT_LINE('Department address cannot be null');
when d_locationno then
    DBMS_OUTPUT.PUT_LINE('Location cannot be null');   
when d_deptcol then
    DBMS_OUTPUT.PUT_LINE('combination of Department name, Department address and location number already exists');

end;

CREATE OR REPLACE procedure proc_emp
(
    x_empfirstname employees.firstname%TYPE,
    x_emplastname employees.lastname%TYPE,
    x_empgend employees.gender%TYPE,
    x_empdateofb employees.DOB%TYPE,
    x_empphnum employees.phnumber%TYPE,
    x_empaddss employees.address%TYPE,
    x_empem employees.email%TYPE,
    x_empsal employees.salary%TYPE,
    x_empdeptnum employees.deptno%TYPE,
    x_empmid employees.mgrid%TYPE
)

AS

    countfname number;
    countlname number;
    countgend number;
    countdob number;
    countph number;
    countem number;
    countdeptnum number;
    countmid number;
    countadds number;
    
    e_empfirstname exception;
    e_emplastname exception;
    e_empgend exception;
    e_empdateofb exception;
    e_empphnum exception;
    e_empem exception;
    e_empaddss exception;
    e_empdeptnum exception;
    e_empmid exception;
    e_invsal exception;
    e_empsal exception;
    e_empdupcol exception;
    e_empdupphno exception;
    e_empphnoint exception;

BEGIN

if x_empfirstname is NULL
then raise e_empfirstname;

if x_emplastname is NULL
then raise e_emplastname;

if x_empgend is NULL
then raise e_empgend;

if x_empdateofb is NULL
then raise e_empdateofb;

if is_numeric(x_empphnum)=0 THEN
    RAISE e_empphnoint;


if x_empphnum is NULL
then raise e_empphnum;

if x_empem is NULL 
then raise e_empem;

if x_empsal is NULL
then raise e_empsal;

if is_numeric(x_empsal)=0 THEN
    RAISE e_invsal;

if x_empaddss is NULL
then raise e_empaddss;

if x_empdeptnum is NULL
then raise e_empdeptnum;

if x_empmid is NULL
then raise e_empmid;

end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;

select count(*) into countph from employees where phnumber = x_empphnum;
if countph > 0 then
    raise e_empdupphno;
end if;

select count(*) into countem from employees where email = x_empem;
if countem > 0 then
    raise e_empdupcol;
end if;


insert into employees(empid,firstname,lastname,gender,DOB,phnumber,address,email,salary, deptno,mgrid)
values(seq_emp.nextval,x_empfirstname,x_emplastname,x_empgend,x_empdateofb,x_empphnum,x_empaddss,x_empem, x_empsal,x_empdeptnum,x_empmid);


EXCEPTION


when e_empphnoint then
    DBMS_OUTPUT.PUT_LINE('employee phone number can only be integers');
    
when e_empfirstname then
    DBMS_OUTPUT.PUT_LINE('First Name cannot be null');
    
when e_emplastname then
    DBMS_OUTPUT.PUT_LINE('Last Name cannot be null');

when e_empgend then
    DBMS_OUTPUT.PUT_LINE('Gender cannot be null');

when e_empdateofb then
    DBMS_OUTPUT.PUT_LINE('Date of Birth cannot be null');
    
when e_empphnum then
    DBMS_OUTPUT.PUT_LINE('Phone number cannot be null');
    
when e_empaddss then
    DBMS_OUTPUT.PUT_LINE('Address cannot be null');

when e_empem then
    DBMS_OUTPUT.PUT_LINE('Email cannot be null');

when e_empsal then
    DBMS_OUTPUT.PUT_LINE('salary cannot be null');

when e_invsal then
    DBMS_OUTPUT.PUT_LINE('salary can only be numeric');
when e_empdeptnum then
    DBMS_OUTPUT.PUT_LINE('Department number cannot be null');
    
when e_empmid then
    DBMS_OUTPUT.PUT_LINE('Manager Id cannot be null');

when e_empdupcol then
    DBMS_OUTPUT.PUT_LINE('email already exists');
    
when e_empdupphno then
    DBMS_OUTPUT.PUT_LINE('phone number already exists');
end;

CREATE OR REPLACE procedure proc_inventory
(
    x_inInventoryName inventory.inventory_name%TYPE,
    x_inStorageSpace inventory.storage_space%TYPE,
    x_invlocation inventory.invlocation%type
)

AS
    
    s_inInventoryName exception;
    s_inStorageSpace exception;
    s_inInventoryloc exception;
    
    
BEGIN

    if x_invlocation is NULL
    then raise s_inInventoryloc;   
    
    if x_inInventoryName is NULL
    then raise s_inInventoryName;
    
    if x_inStorageSpace is NULL
    then raise s_inStorageSpace;
    
    end if;
    end if;
    end if;
    
insert into inventory(inventory_id,inventory_name,storage_space, invlocation) 
values (seq_inventory.nextval,x_inInventoryName,x_inStorageSpace,x_invlocation);

EXCEPTION

when s_inInventoryName then
    DBMS_OUTPUT.PUT_LINE('Inventory name cannot be null');

when s_inStorageSpace then
    DBMS_OUTPUT.PUT_LINE('Storage Space details cannot be null');

when s_inInventoryloc then
    DBMS_OUTPUT.PUT_LINE('Inventory location cannot be null');

    
end;


CREATE OR REPLACE procedure proc_inv_prod
(
    x_invInventoryId inventory_product.inventory_id%TYPE,
    x_invProductId inventory_product.productid%TYPE,
    x_invQuantity inventory_product.quantity%TYPE
)

AS
    countsuppid number:=0;
    countComb number:=0;
    countprodid number:=0;
    s_invInventoryId exception;
    s_invProductId exception;
    s_invDupcol exception;
    s_countsuppid exception;
    s_countpid exception;
BEGIN
    
    if x_invInventoryId is NULL
    then raise s_invInventoryId;
    
    
    if x_invProductId is NULL
    then raise s_invProductId;
    

    end if;
    end if;
       
    
    select count(*) into countComb from inventory_product where inventory_id = x_invInventoryId and productid = x_invProductId;
    if countComb > 0 then
        raise s_invDupcol;
    end if;
    select count(*) into countsuppid from inventory where inventory_id = x_invInventoryId;
    if countsuppid < 1 then
        raise s_countsuppid;
    end if;

    select count(*) into countprodid from product where productid= x_invProductId;
    if countprodid < 1 then
        raise s_countpid;
    end if;

insert into inventory_product(inventory_id,productid,quantity)
values (x_invInventoryId,x_invProductId,x_invQuantity);

EXCEPTION

when s_countpid then
    DBMS_OUTPUT.PUT_LINE('Invalid Productid as this id doesnt exist in product table');

when s_invInventoryId then
    DBMS_OUTPUT.PUT_LINE('Inventory ID cannot be null');
    
when s_invProductId then
    DBMS_OUTPUT.PUT_LINE('Product ID cannot be null');
    
when s_invDupcol then
    DBMS_OUTPUT.PUT_LINE('The information of the product in the inventory already exists!');
when s_countsuppid then
    DBMS_OUTPUT.PUT_LINE('Supplier id does not exist');

end;

CREATE OR REPLACE procedure proc_suppin
(
    x_supplierno supplier_inventory.supplierno%TYPE,
    x_inventid supplier_inventory.inventory_id%TYPE,
    x_prodid supplier_inventory.product_id%TYPE
)
AS

countproduid number:=0;
countsupnum number:=0;
countsup number:=0;
dupcolsup exception;
w_supnum exception;
w_countpid exception;

BEGIN 
select count(*) into countsup from supplier_inventory where supplierno=x_supplierno and inventory_id =x_inventid;
if countsup > 0 then
    raise dupcolsup;
end if;

select count(*) into countsupnum from supplier where supplierno = x_supplierno;
if countsupnum < 1 then
    raise w_supnum ;
end if;    
    select count(*) into countproduid from product where productid= x_prodid ;
    if countproduid < 1 then
        raise w_countpid;
    end if;

insert into supplier_inventory(supplierno,inventory_id,product_id)
values (x_supplierno,x_inventid,x_prodid); 


EXCEPTION


when w_countpid then
    DBMS_OUTPUT.PUT_LINE('Productid does not exist in product table');

when w_supnum then
    DBMS_OUTPUT.PUT_LINE('Supplier number invalid as it does not exist in supplier table');

when dupcolsup then
      DBMS_OUTPUT.PUT_LINE('combination of supplier number and inventory id already exists');
end;

CREATE OR REPLACE procedure proc_ret
(
    x_customid returns.customerid%TYPE,
    x_ordid returns.orderid%TYPE,
    x_produid returns.product_id%TYPE,
    x_quant returns.quantity%TYPE
)

AS 
countorder NUMBER:=0;
x_partid number:=0;
countprodret number:=0;
countret number;
r_cusid exception;
r_orid exception;
r_proid exception;
r_quant exception;
r_parid exception;
r_dupcol exception;
r_countprodret exception;
r_countorder exception;
BEGIN

if x_customid is NULL
then raise r_cusid;
if x_ordid is NULL
then raise r_orid;
if x_produid is NULL
then raise r_proid;
if x_quant is NULL
then raise r_quant;


end if;
end if;
end if;
end if;
select count(*) into countorder from orders where customerid = x_customid and orderid = x_ordid;
select count(*) into countret from returns where customerid = x_customid and orderid = x_ordid and product_id = x_produid;
if countret > 0 then
    raise r_dupcol;
end if;
if countorder < 1 then
    raise r_countorder;
end if;
select count(*) into countprodret from order_items where productid = x_produid and orderid = x_ordid;
if countprodret < 1 then
    raise r_countprodret;
end if;
x_partid:=getpartner;
insert into returns(returnid,customerid,orderid, product_id,quantity, partnerid)
values(seq_ret.nextval,x_customid,x_ordid,x_produid,x_quant,x_partid);

EXCEPTION
when r_countorder then
    DBMS_OUTPUT.PUT_LINE('Unable to find your order being placed');
when r_countprodret then
    DBMS_OUTPUT.PUT_LINE('Unable to find product in your order, Please check your ordered products.');
when r_cusid then
    DBMS_OUTPUT.PUT_LINE('customer id cannot be null');
when r_orid then
    DBMS_OUTPUT.PUT_LINE('order id cannot be null');
when r_proid then
    DBMS_OUTPUT.PUT_LINE('product id cannot be null');
when r_quant then
    DBMS_OUTPUT.PUT_LINE('quantity cannot be null');
when r_dupcol then 
    DBMS_OUTPUT.PUT_LINE('customer id, order id and product id already exists');

end;


CREATE OR REPLACE procedure procgenorderid(
x_customerid orders.customerid%type,
x_deliveryaddress orders.delivery_address%TYPE
)
as
transidnum number:= seq_transaction.nextval;
orderidnum number := seq_orders.nextval;
countcustid number:=0;
s_customerid exception;
s_customeridnotfound exception;
s_deliveryaddressisnull exception;

begin
if x_customerid IS NULL
then raise s_customerid;
end if;

if x_deliveryaddress IS NULL
then raise s_deliveryaddressisnull;
end if;

select count(*) into countcustid from customers where customerid = x_customerid;
if countcustid<1 then
raise s_customeridnotfound;
end if;



insert into transactions(transaction_id,orderid)
values(transidnum, orderidnum);
insert into orders (orderid,customerid,delivery_address, transaction_id, order_date)
values(orderidnum, x_customerid, x_deliveryaddress, transidnum, sysdate);

DBMS_OUTPUT.PUT_LINE('Your orderid is '||to_char(orderidnum));

EXCEPTION
WHEN s_customerid THEN
    DBMS_OUTPUT.PUT_LINE('CUSTOMERID cannot be null');
WHEN s_customeridnotfound THEN
    DBMS_OUTPUT.PUT_LINE('CUSTOMERID cannot be FOUND please create a new customer account or insert correct customerid');
WHEN s_deliveryaddressisnull THEN
    DBMS_OUTPUT.PUT_LINE('please enter delivery address');    
    
end;


CREATE OR REPLACE procedure procorder_items(
x_orderidins order_items.orderid%type,
x_productidins order_items.productid%type,
x_quantityins order_items.quantity%type
)
as
countorderid number := 0;
countproductid number := 0;
x_priceins order_items.product_price%type := getprice(x_productidins);
s_countorderid EXCEPTION;
s_countproductid EXCEPTION;
s_invquantity EXCEPTION;

begin

SELECT count(*) into countorderid from orders where orderid = x_orderidins;
if countorderid<1 then
raise s_countorderid;
end if;
SELECT count(*) into countproductid from product where productid = x_productidins;
if countproductid<1 then
raise s_countproductid;
end if;
IF x_quantityins < 1 THEN
RAISE s_invquantity;
end if;

insert into order_items(orderid, productid, quantity, product_price) 
values(x_orderidins, x_productidins, x_quantityins, x_priceins);

exception
    when s_countorderid then
        DBMS_OUTPUT.PUT_LINE('Orderid does not exist');
    when s_countproductid then
        DBMS_OUTPUT.PUT_LINE('Productid does not exist');
    when s_invquantity then
        DBMS_OUTPUT.PUT_LINE('Quantity cannot be 0');
end;

create or replace procedure populateamount(
x_finorderid orders.orderid%type
)
as
s_finorderid exception;
countfinorderid number:=0;
finamount orders.amount%type := 0;
s_invalorderid exception;
begin
if x_finorderid is NULL then
	raise s_finorderid ;
end if;
select count(*) into countfinorderid from orders where orderid = x_finorderid;
if countfinorderid < 1 then
raise s_invalorderid;
end if;

finamount:=getamount(x_finorderid);

UPDATE orders
set amount=finamount
where orderid=x_finorderid;


exception

    when s_finorderid then
        DBMS_OUTPUT.PUT_LINE('Orderid cannot be null');

    when s_invalorderid then
        DBMS_OUTPUT.PUT_LINE('Orderid does not exist');
        
end;


CREATE OR REPLACE PROCEDURE assigndelipartner
(
x_transorderid deliveredby.orderid%type
)
AS
x_partnerid number:=getpartner;
Begin
INSERT INTO deliveredby(partner_id, orderid ) VALUES(x_partnerid, x_transorderid);
END;


CREATE OR REPLACE PROCEDURE completetransaction(
x_transorderid transactions.orderid%type,
x_modeofpayment transactions.modeof_payment%type,
x_cardtype transactions.card_type%type,
x_cardnumber transactions.card_number%type,
x_cardexpirydate transactions.card_expirydate%type,
x_transaction_date transactions.transaction_date%type
)
AS
valueto_pass number;
paymentstate char :='Y';
counttransorder NUMBER:=0;
s_transorderid EXCEPTION;
s_transorderidnotexist EXCEPTION;
s_modeofpayment EXCEPTION;
s_modeofpaymentinv EXCEPTION;
s_cardtypeinv EXCEPTION;
s_cardtypenull EXCEPTION;
s_cardnumbernull EXCEPTION;
s_invcardnum EXCEPTION;
s_cardexpired EXCEPTION;
BEGIN

IF x_transorderid IS NULL THEN
    RAISE s_transorderid;
    
SELECT COUNT(*) INTO counttransorder
from transactions
where orderid=x_transorderid;

IF counttransorder<1 THEN
    RAISE s_transorderidnotexist;

IF x_modeofpayment IS NULL THEN
    RAISE s_modeofpayment;
    
IF x_modeofpayment NOT IN ('CREDIT','DEBIT') THEN
    RAISE s_modeofpaymentINV;
    
IF x_cardtype IS NULL THEN
    RAISE s_cardtypenull;  
IF x_cardtype NOT IN ('VISA','MASTERCARD') THEN
    RAISE s_cardtypeinv;
IF x_cardnumber IS NULL THEN
    RAISE s_cardnumbernull;  
IF is_numeric(x_cardnumber)=0 THEN
    RAISE s_invcardnum;
IF (TO_DATE(x_cardexpirydate,'MM-YY')-SYSDATE)<1 THEN
    RAISE s_cardexpired;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;



UPDATE transactions
SET modeof_payment=x_modeofpayment, card_type=x_cardtype, card_number=x_cardtype, transaction_date= sysdate, card_expirydate=x_cardexpirydate, payment_status = paymentstate
WHERE orderid=x_transorderid;
valueto_pass :=x_transorderid;
assigndelipartner(valueto_pass);

EXCEPTION

WHEN s_transorderid THEN
    DBMS_OUTPUT.PUT_LINE('Orderid CANNOT BE null');
WHEN s_transorderidnotexist THEN
    DBMS_OUTPUT.PUT_LINE('Orderid not generated yet');
WHEN s_modeofpayment THEN
    DBMS_OUTPUT.PUT_LINE('Mode of payment cant be null');
WHEN s_modeofpaymentinv THEN
    DBMS_OUTPUT.PUT_LINE('Mode of payment can only be either credit or debit');
WHEN s_cardtypeinv THEN
    DBMS_OUTPUT.PUT_LINE('card type can only be VISA OR MASTERCARD');
WHEN s_cardtypenull THEN
    DBMS_OUTPUT.PUT_LINE('card type cannot be null');
WHEN s_cardnumbernull THEN
    DBMS_OUTPUT.PUT_LINE('card number slot empty please enter card number');
WHEN s_invcardnum THEN
    DBMS_OUTPUT.PUT_LINE('card number is invalid and only be numeric');
WHEN s_cardexpired THEN
    DBMS_OUTPUT.PUT_LINE('Card is expired');

END;


CREATE OR REPLACE procedure proc_delorderitems
(
    x_orderid returns.orderid%TYPE,
    x_productid returns.product_id%TYPE
)

AS 
x_countorderid number:=0;
s_countorderid exception;
s_productid exception;
s_orderid exception;
BEGIN
IF x_orderid is null then
    raise s_orderid;
end if;
SELECT count(*) into x_countorderid FROM order_items where orderid= x_orderid and productid = x_productid;
if x_countorderid < 1 then
    raise s_countorderid;
end if;

delete from order_items WHERE orderid=x_orderid and productid= x_productid;
dbms_output.put_line('Product has been removed from your cart');

EXCEPTION
when s_orderid then
    dbms_output.put_line('Order id cannot be null');
when s_productid then
    dbms_output.put_line('Product id cannot be null');
WHEN s_countorderid then
    dbms_output.put_line('product not found in your cart');
end;
