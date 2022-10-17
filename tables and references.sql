
CREATE TABLE location (
  locationno number PRIMARY KEY,
  location_name varchar(20),
  location_mgrid number
);

CREATE TABLE department (
  deptno number PRIMARY KEY,
  deptname varchar(10),
  deptaddress varchar(10),
  locationno number,
  FOREIGN KEY (locationno) REFERENCES location (locationno)
);

CREATE TABLE employees (
  empid number PRIMARY KEY,
  firstname varchar(20),
  lastname varchar(20),
  gender char,
  DOB date,
  phnumber number,
  address varchar(20),
  email varchar(20),
  salary number,
  deptno number,
  mgrid number,
  FOREIGN KEY (deptno) REFERENCES department (deptno)
);


CREATE TABLE deliverypartner (
  partner_id number primary key,
  partner_no number,
  partner_name varchar(255)
  
);



CREATE TABLE supplier (
  supplierno number,
  suppliername varchar(20),
  Product_id number,
  quantity_suppliable number,
  PRIMARY KEY (supplierno)
);



CREATE TABLE inventory (
  inventory_id number PRIMARY KEY,
  inventory_name varchar(20),
  storage_space number,
  invlocation varchar(20)
);


CREATE TABLE supplier_inventory (
  supplierno number,
  inventory_id number,
  Product_id number,
  primary key (supplierno, inventory_id),
  FOREIGN KEY (supplierno) REFERENCES supplier (supplierno),
  FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id)
);



CREATE TABLE category (
  category_id number PRIMARY KEY,
  sub_category varchar(20),
  category_main varchar(20)
);

CREATE TABLE product (
  productid number PRIMARY KEY,
  upc_code number,
  sku_code number,
  price number,
  expiry_date date,
  product_name varchar(20),
  description varchar(20),
  brand varchar(20),
  supplier_id number,
  category_id number,
  FOREIGN KEY (category_id) REFERENCES category (category_id)
);


CREATE TABLE inventory_product (
  inventory_id number,
  productid number,
  quantity number,
  primary key(inventory_id, productid),
  FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id),
  FOREIGN KEY (productid) REFERENCES product (productid)
);


CREATE TABLE customers (
  customerid number PRIMARY KEY,
  customer_fname varchar(20),
  customer_lname varchar(20),
  customer_gender varchar(20),
  customer_phno number,
  customer_email varchar(20),
  customer_DOB date,
  street_address varchar(20),
  apt_house_no number,
  city varchar(20),
  state varchar(20),
  country varchar(20),
  zip number
);

CREATE TABLE returns (
  returnid number PRIMARY KEY,
  customerid number,
  orderid number,
  product_id number,
  quantity number,
  partnerid number,
  FOREIGN KEY (customerid) REFERENCES customers (customerid)
);
CREATE TABLE orders (
  orderid number PRIMARY KEY,
  customerid number,
  amount number,
  delivery_address varchar(20),
  transaction_id number,
  order_date date,
  FOREIGN KEY (customerid) REFERENCES customers (customerid)
);

CREATE TABLE transactions (
  transaction_id number primary key,
  orderid number ,
  modeof_payment varchar(20),
  card_type varchar(20),
  card_number number,
  card_expirydate date,
  payment_status char,
  transaction_date date,
  FOREIGN KEY (orderid) REFERENCES orders (orderid)
);


CREATE TABLE order_items (
  orderid number,
  productid number,
  quantity number,
  Product_price number,
  primary key(orderid, productid),
  FOREIGN KEY (productid) REFERENCES product (productid),
  FOREIGN KEY (orderid) REFERENCES orders (orderid)
);

CREATE TABLE deliveredby(
partner_id number,
orderid number,
delivery_status char,
primary key(partner_id, orderid),
FOREIGN KEY (partner_id) REFERENCES deliverypartner (partner_id),
FOREIGN KEY (orderid) REFERENCES orders (orderid)
);
