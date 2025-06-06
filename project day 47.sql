create database project;

use project;

select * from account;
select * from card;
select * from client;
select * from disp;
select * from district;
select * from loan;
select * from orders;
select * from transaction_data;


#Transaction and Loans table
create table trans_loan as 
select td.*, ln.loan_id as loan_id, ln.date as loan_date, ln.amount as loan_amt, ln.duration as loan_duration, ln.payments, ln.status
from loan ln join transaction_data td on ln.account_id = td.account_id;

select * from trans_loan;

#Account and Orders table 
create table acc_ord as 
select o.*, a.district_id, a.frequency, a.date as account_date
from orders o join account a on a.account_id = o.account_id;

select * from acc_ord;

#Card and Disposition table 
create table card_disp as
select c.card_id, c.disp_id, c.type as card_type, c.issued as issue_date, d.client_id, d.account_id, d.type as disp_type
from card c join disp d on c.disp_id = d.disp_id;

select * from card_disp;

#Card and disposition combine with Client table based on client_id 
create table card_disp_client as
select card_disp.*, client.birth_number, client.district_id
from card_disp join client on card_disp.client_id = client.client_id;

select * from card_disp_client;

drop table if exists card_disp_client_dist;

#Card, Dispositon, client table with district Table based on district id (inner join)
create table card_disp_client_dist as
select * 
from card_disp_client cdc join district d on cdc.district_id = d.A1;

select * from card_disp_client_dist;

#Account, order table with card, disposition, client, district table based on account id (left join)
create table acc_ord_card_disp_client_dist as
select cdcd.*, ao.order_id, ao.bank_to, ao.account_to, ao.amount, ao.k_symbol, ao.frequency, ao.account_date
from acc_ord ao left join card_disp_client_dist cdcd on ao.account_id = cdcd.account_id;

select * from acc_ord_card_disp_client_dist;

