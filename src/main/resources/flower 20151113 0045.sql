﻿--
-- Скрипт сгенерирован Devart dbForge Studio for Oracle, Версия 3.7.472.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/oracle/studio
-- Дата скрипта: 13.11.2015 0:45:38
-- Версия сервера: Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
-- Версия клиента: 11.2.0.1
--


CONNECT flower/123@XE AS SysDba;


-- 
-- Установка схемы по умолчанию
--
ALTER SESSION SET CURRENT_SCHEMA = "FLOWER";

SET SQLBLANKLINES ON;
SET DEFINE OFF;
ALTER SESSION SET NLS_DATE_FORMAT = 'MM/DD/SYYYY HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT = 'MM/DD/SYYYY HH24:MI:SS.FF TZH:TZM';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'MM/DD/SYYYY HH24:MI:SS.FF';
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = '.,';
ALTER SESSION SET NLS_NCHAR_CONV_EXCP = FALSE;
ALTER SESSION SET TIME_ZONE = '+02:00';

--
-- Описание для последовательности PROVIDER_SEQ
--
CREATE SEQUENCE PROVIDER_SEQ
START WITH 6
INCREMENT BY 1;

--
-- Описание для последовательности SERVICE_SEQ
--
CREATE SEQUENCE SERVICE_SEQ
START WITH 31
INCREMENT BY 1;

--
-- Описание для последовательности SERVICE_TYPE_SEQ
--
CREATE SEQUENCE SERVICE_TYPE_SEQ
START WITH 4
INCREMENT BY 1;

--
-- Описание для таблицы PROVIDER
--
CREATE TABLE PROVIDER (
  ID        NUMBER(10, 0),
  NAME      NVARCHAR2(255),
  LONGITUDE BINARY_DOUBLE,
  LATITUDE  BINARY_DOUBLE,
  CONSTRAINT PK_PROVIDER PRIMARY KEY (ID) USING INDEX TABLESPACE USERS STORAGE (INITIAL 64 K
                                                                                NEXT 1 M
                                                                                MAXEXTENTS UNLIMITED)
)
TABLESPACE USERS
STORAGE (INITIAL 64 K
         NEXT 1 M
         MAXEXTENTS UNLIMITED)
LOGGING;

--
-- Описание для таблицы SERVICETYPE
--
CREATE TABLE SERVICETYPE (
  ID          NUMBER(10, 0),
  NAMESERVICE VARCHAR2(255 BYTE),
  SPEED       NVARCHAR2(255),
  CONSTRAINT PK_SERVICETYPE PRIMARY KEY (ID) USING INDEX TABLESPACE USERS STORAGE (INITIAL 64 K
                                                                                   NEXT 1 M
                                                                                   MAXEXTENTS UNLIMITED)
)
TABLESPACE USERS
STORAGE (INITIAL 64 K
         NEXT 1 M
         MAXEXTENTS UNLIMITED)
LOGGING;

--
-- Описание для таблицы SERVICE
--
CREATE TABLE SERVICE (
  ID             NUMBER(10, 0),
  ID_SERVICETYPE NUMBER(10, 0),
  PRICE          NUMBER(19, 2),
  ID_PROVIDER    NUMBER(10, 0),
  CONSTRAINT PK_SERVICE PRIMARY KEY (ID) USING INDEX TABLESPACE USERS STORAGE (INITIAL 64 K
                                                                               NEXT 1 M
                                                                               MAXEXTENTS UNLIMITED),
  CONSTRAINT FK_SERVICE_PROVIDER_ID FOREIGN KEY (ID_PROVIDER)
  REFERENCES PROVIDER (ID),
  CONSTRAINT FK_SERVICE_SERVICETYPE_ID FOREIGN KEY (ID_SERVICETYPE)
  REFERENCES SERVICETYPE (ID)
)
TABLESPACE USERS
STORAGE (INITIAL 64 K
         NEXT 1 M
         MAXEXTENTS UNLIMITED)
LOGGING;

-- 
-- Вывод данных для таблицы PROVIDER
--
INSERT INTO PROVIDER VALUES
(1, N'Main office', 30.52259982, 50.45095993);
INSERT INTO PROVIDER VALUES
(2, N'Solomenka office', 30.4529175, 50.4282552);
INSERT INTO PROVIDER VALUES
(3, N'Darnitsa office', 30.601521, 50.4535873);
INSERT INTO PROVIDER VALUES
(4, N'Pozniaki office', 30.634579, 50.397944);
INSERT INTO PROVIDER VALUES
(5, N'Obolon office', 30.492778, 50.526944);

-- 
-- Вывод данных для таблицы SERVICETYPE
--
INSERT INTO SERVICETYPE VALUES
(1, 'Basic', N'30 MB/s');
INSERT INTO SERVICETYPE VALUES
(2, 'Standart', N'60 MB/s');
INSERT INTO SERVICETYPE VALUES
(3, 'Premium', N'100 MB/s');

-- 
-- Вывод данных для таблицы SERVICE
--
INSERT INTO SERVICE VALUES
(1, 1, 10, 1);
INSERT INTO SERVICE VALUES
(2, 2, 20, 1);
INSERT INTO SERVICE VALUES
(10, 3, 25, 1);
INSERT INTO SERVICE VALUES
(11, 1, 10, 2);
INSERT INTO SERVICE VALUES
(12, 2, 30, 2);
INSERT INTO SERVICE VALUES
(13, 3, 40, 2);
INSERT INTO SERVICE VALUES
(14, 1, 20, 3);
INSERT INTO SERVICE VALUES
(15, 2, 30, 3);
INSERT INTO SERVICE VALUES
(16, 1, 15, 4);
INSERT INTO SERVICE VALUES
(17, 2, 25, 4);
INSERT INTO SERVICE VALUES
(18, 3, 35, 4);
INSERT INTO SERVICE VALUES
(19, 1, 15, 5);
INSERT INTO SERVICE VALUES
(20, 2, 25, 5);
INSERT INTO SERVICE VALUES
(21, 3, 35, 5);

--
-- Описание для триггера PROVIDER_ID_TRG
--
CREATE OR REPLACE TRIGGER PROVIDER_ID_TRG
  BEFORE INSERT
  ON PROVIDER
  FOR EACH ROW
BEGIN
  IF :new.id IS NULL
  THEN
    SELECT PROVIDER_SEQ.NEXTVAL
      INTO :new.id
      FROM dual;
  END IF;
END;

/

--
-- Описание для триггера SERVICE_ID_TRG
--
CREATE OR REPLACE TRIGGER SERVICE_ID_TRG
  BEFORE INSERT
  ON SERVICE
  FOR EACH ROW
BEGIN
  IF :new.id IS NULL
  THEN
    SELECT service_seq.NEXTVAL
      INTO :new.id
      FROM dual;
  END IF;
END;

/

--
-- Описание для триггера SERVICE_TYPE_ID_TRG
--
CREATE OR REPLACE TRIGGER SERVICE_TYPE_ID_TRG
  BEFORE INSERT
  ON SERVICETYPE
  FOR EACH ROW
BEGIN
  IF :new.id IS NULL
  THEN
    SELECT SERVICE_TYPE_seq.NEXTVAL
      INTO :new.id
      FROM dual;
  END IF;
END;

/

COMMIT;

-- 
-- Установка схемы по умолчанию
--
DECLARE
  p VARCHAR2(255);
BEGIN 
  SELECT USER INTO p FROM DUAL;
  EXECUTE IMMEDIATE 'ALTER SESSION SET CURRENT_SCHEMA = ' || p;
END;
/