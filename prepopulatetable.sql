Create or Replace PROCEDURE prepopulatetable 
    is
BEGIN

insert into category values(80,'shoe','wear');
insert into category values(81,'shirt','wear');
insert into category values(82,'pant','wear');
insert into category values(83,'cap','wear');
insert into category values(84,'belt','wear');
insert into category values(85,'gloves','wear');
insert into category values(86,'towel','wear');
insert into category values(87,'socks','wear');
insert into category values(88,'scarf','wear');
insert into category values(89,'jacket','wear');

insert into product values(40,1001,10001,100,date'2025-02-02','shoe','red','nike',30,80);
insert into product values(41,1002,10002,101,date'2025-03-02','shirt','green','adidas',31,81);
insert into product values(42,1003,10003,102,date'2025-04-02','pant','black','jordan',32,82);
insert into product values(43,1004,10004,103,date'2025-05-02','cap','indigo','puma',33,83);
insert into product values(44,1005,10005,104,date'2025-06-02','belt','blue','balmain',34,84);
insert into product values(45,1006,10006,105,date'2025-07-02','gloves','white','primark',35,85);
insert into product values(46,1007,10007,106,date'2025-08-02','towel','pink','gucci',36,86);
insert into product values(47,1008,10008,107,date'2025-09-02','socks','yellow','coach',37,87);
insert into product values(48,1009,10009,108,date'2025-10-02','scarf','orange','channel',38,88);
insert into product values(49,1010,10010,109,date'2025-11-02','jacket','violet','timberland',39,89);

insert into customers VALUES(1,'david','warner','M',9441456907,'david@gmail.com',date'1989-09-08','Savenue',3,'boston','MA','USA',02140);
insert into customers VALUES(2,'steve','smith','M',9443456907,'steve@gmail.com',date'1998-03-04','jvue',4,'Ashland','MA','USA',02490);
insert into customers VALUES(3,'david','miller','M',9421456907,'miller@gmail.com',date'1989-06-04','missionmain',5,'denver','MA','USA',02110);
insert into customers VALUES(4,'ross','taylor','M',9498456907,'ross@gmail.com',date'1999-08-09','boylston',6,'charles','MA','USA',02800);
insert into customers VALUES(5,'virat','kohli','M',9441456877,'virat@gmail.com',date'1992-10-03','aliston',7,'chestnut','MA','USA',02190);
insert into customers VALUES(6,'marcus','harris','M',9441156904,'harris@gmail.com',date'1997-08-11','parkerst',8,'malakpet','hyderabad','India',500040);
insert into customers VALUES(7,'preha','palle','F',944858922,'palle@gmail.com',date'1979-06-06','Huntington',9,'richardson','NJ','USA',06140);
insert into customers VALUES(8,'gautami','rao','F',92241456988,'rao@gmail.com',date'1993-11-12','kothapet',10,'brunshwick','NJ','USA',06640);
insert into customers VALUES(9,'rohith','sharma','M',9441006907,'rohith@gmail.com',date'1994-12-08','rampur',11,'goa','punjab','India',500036);
insert into customers VALUES(10,'ishanth','verma','M',9441456337,'ishanth@gmail.com',date'1989-10-08','goa',12,'kent','MA','USA',02240);

insert into orders values(11,1,100,'Savenue',4,date'2021-12-18');
insert into orders values(12,2,101,'jvue',5,date'2021-12-18');
insert into orders values(13,3,102,'missionmain',6,date'2021-12-18');
insert into orders values(14,4,103,'boylston',7,date'2021-12-18');
insert into orders values(15,5,104,'aliston',8,date'2021-12-18');
insert into orders values(16,6,105,'parkerst',9,date'2021-12-18');
insert into orders values(17,7,106,'Huntington',10,date'2021-12-18');
insert into orders values(18,8,107,'kothapet',21,date'2021-12-18');
insert into orders values(19,9,108,'rampur',22,date'2021-12-18');
insert into orders values(20,10,109,'goa',23,date'2021-12-18');

insert into transactions values(50,11,'card','visa',1234,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(51,12,'card','visa',1123,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(52,13,'card','visa',1224,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(53,14,'card','visa',1244,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(54,15,'card','visa',1233,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(55,16,'card','visa',1231,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(56,17,'card','visa',1232,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(57,18,'card','visa',1221,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(58,19,'card','visa',1235,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(59,20,'card','visa',1239,date'2025-02-02','Y',date'2021-12-18');

insert into order_Items values(11,40,2,100);
insert into order_Items values(12,41,3,101);
insert into order_Items values(13,42,4,102);
insert into order_Items values(14,43,5,103);
insert into order_Items values(15,44,6,104);
insert into order_Items values(16,45,7,105);
insert into order_Items values(17,46,8,106);
insert into order_Items values(18,47,9,107);
insert into order_Items values(19,48,10,108);
insert into order_Items values(20,49,11,109);

insert into supplier values(420,'ziva',40,900);
insert into supplier values(421,'ziva',41,901);
insert into supplier values(422,'ziva',42,902);
insert into supplier values(423,'ziva',43,903);
insert into supplier values(424,'ziva',44,904);
insert into supplier values(425,'ziva',45,905);
insert into supplier values(426,'ziva',46,906);
insert into supplier values(427,'ziva',47,907);
insert into supplier values(428,'ziva',48,908);
insert into supplier values(429,'ziva',49,909);

insert into Inventory values(600,'melon',900,'Delhi');
insert into Inventory values(601,'strawberry',901,'Mirzapur');    
insert into Inventory values(602,'blueberry',902,'Goa');
insert into Inventory values(603,'mango',903,'Hyderabad');
insert into Inventory values(604,'orange',904,'Chennai');   
insert into Inventory values(605,'banana',905,'Mumbai');
insert into Inventory values(606,'apple',906,'Karnataka');
insert into Inventory values(607,'litchi',907,'Kolkata');    
insert into Inventory values(608,'grape',908,'Srinagar');
insert into Inventory values(609,'dragonfruit',909,'Kochi');

insert into supplier_inventory values(420,600,40);
insert into supplier_inventory values(421,601,41);
insert into supplier_inventory values(422,602,42);
insert into supplier_inventory values(423,603,43);
insert into supplier_inventory values(424,604,44);
insert into supplier_inventory values(425,605,45);
insert into supplier_inventory values(426,606,46);
insert into supplier_inventory values(427,607,47);
insert into supplier_inventory values(428,608,48);
insert into supplier_inventory values(429,609,49);

insert into Inventory_product values(600,40,60);
insert into Inventory_product values(601,41,61);
insert into Inventory_product values(602,42,62);
insert into Inventory_product values(603,43,63);
insert into Inventory_product values(604,44,64);
insert into Inventory_product values(605,45,65);
insert into Inventory_product values(606,46,66);
insert into Inventory_product values(607,47,67);
insert into Inventory_product values(608,48,68);
insert into Inventory_product values(609,49,69);

insert into deliverypartner values(19,121,'scott');
insert into deliverypartner values(29,122,'micheal');
insert into deliverypartner values(39,123,'pam');
insert into deliverypartner values(49,124,'kevin');
insert into deliverypartner values(59,125,'dwight');
insert into deliverypartner values(69,126,'oscar');
insert into deliverypartner values(79,127,'angela');
insert into deliverypartner values(89,128,'jim');
insert into deliverypartner values(99,129,'rayn');
insert into deliverypartner values(09,120,'andy');

insert into deliveredby values(19,11,'Y');
insert into deliveredby values(29,12,'Y');
insert into deliveredby values(39,13,'Y');
insert into deliveredby values(49,14,'Y');
insert into deliveredby values(59,15,'Y');
insert into deliveredby values(69,16,'Y');
insert into deliveredby values(79,17,'Y');
insert into deliveredby values(89,18,'Y');
insert into deliveredby values(99,19,'Y');
insert into deliveredby values(09,20,'Y');

insert into returns values(60,1,11,1111,3,19);
insert into returns values(61,2,12,1112,4,29);
insert into returns values(62,3,13,1113,5,39);
insert into returns values(63,4,14,1114,6,49);
insert into returns values(64,5,15,1115,7,59);
insert into returns values(65,6,16,1116,8,69);
insert into returns values(66,7,17,1117,9,79);
insert into returns values(67,8,18,1118,10,89);
insert into returns values(68,9,19,1119,11,99);
insert into returns values(69,10,20,1110,12,09);

insert into location values(150,'huntington',300);
insert into location values(151,'huntington',301);
insert into location values(152,'huntington',302);
insert into location values(153,'huntington',303);
insert into location values(154,'huntington',304);
insert into location values(155,'huntington',305);
insert into location values(156,'huntington',306);
insert into location values(157,'huntington',307);
insert into location values(158,'huntington',308);
insert into location values(159,'huntington',309);

insert into department values(101,'IT','jvue',150);
insert into department values(103,'IT','jvue',151);
insert into department values(105,'IT','jvue',152);
insert into department values(107,'IT','jvue',153);
insert into department values(109,'IT','jvue',154);
insert into department values(111,'IT','jvue',155);
insert into department values(113,'IT','jvue',156);
insert into department values(115,'IT','jvue',157);
insert into department values(117,'IT','jvue',158);
insert into department values(119,'IT','jvue',159);

insert into employees VALUES(1,'Raj','tharun','M',date'1998-12-12',9492442222,'jvue','raj@gmail.com',1000,101,102);
insert into employees VALUES(2,'Ravi','singh','M',date'1990-11-11',9492222112,'Savenue','ravi@gmail.com',2000,103,104);
insert into employees VALUES(3,'varun','baddam','M',date'1980-10-09',949779922,'missionmain','varun@gmail.com',3000,105,106);
insert into employees VALUES(4,'ketan','patel','M',date'1995-03-08',9492445222,'boylston','ketan@gmail.com',4000,107,108);
insert into employees VALUES(5,'tanmay','bhatt','M',date'1998-02-02',9497442222,'aliston','tanmay@gmail.com',5000,109,110);
insert into employees VALUES(6,'teja','bhattar','M',date'1980-06-02',9499442222,'parkerst','teja@gmail.com',6000,111,112);
insert into employees VALUES(7,'rahul','reddy','M',date'1989-1-12',9492440022,'Huntington','rahul@gmail.com',7000,113,114);
insert into employees VALUES(8,'arpitha','ghanate','F',date'1989-11-09',9472442222,'kothapet','arpitha@gmail.com',8000,115,116);
insert into employees VALUES(9,'kiran','poosa','M',date'1988-07-12',9492444422,'rampur','kiran@gmail.com',9000,117,118);
insert into employees VALUES(10,'dhanush','vasa','M',date'1997-09-11',9412442222,'goa','dhanush@gmail.com',10000,119,120);
 
END;
