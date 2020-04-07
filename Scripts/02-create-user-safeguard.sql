-- Author: Rafael Luis da Costa Coelho
-- Created At: 01/04/2020

-- Connect as SYSDBA to create new users

-- Check if your SYSDBA account has the required privileges
SELECT PRIVILEGE FROM USER_SYS_PRIVS WHERE PRIVILEGE IN ('SET CONTAINER', 'CREATE SESSION', 'CREATE USER');

-- Execute this or you can not create new users
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE TABLESPACE tbs_safeguard
         DATAFILE 'tbs_safeguard.dat'
             SIZE 10M AUTOEXTEND ON;
  
-- Execute this to create your new user
CREATE USER safeguard
 IDENTIFIED BY safeguard
    DEFAULT TABLESPACE tbs_safeguard
      QUOTA 5M ON tbs_safeguard;

-- Execute this to grant login access to your user
GRANT CREATE SESSION TO safeguard;
GRANT CREATE TABLE TO safeguard;
GRANT CREATE VIEW TO safeguard;
GRANT CREATE ANY TRIGGER TO safeguard;
GRANT CREATE ANY PROCEDURE TO safeguard;
GRANT CREATE SEQUENCE TO safeguard;
GRANT CREATE SYNONYM TO safeguard;