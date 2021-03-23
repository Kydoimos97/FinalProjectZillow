--------------------------------------------------------------------
-- reference: https://www.oracletutorial.com/
--------------------------------------------------------------------

--------------------------------------------------------------------
-- execute the following statements to create a user name IS6420 and
-- grant priviledges
--------------------------------------------------------------------

ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- create new user
CREATE USER User1 IDENTIFIED BY "REDACTED";

-- grant priviledges
GRANT CONNECT, RESOURCE, DBA TO User1;
