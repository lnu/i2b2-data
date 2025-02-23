--==============================================================
-- Database Script to upgrade CRC from 1.6 to 1.7                  
--==============================================================

alter table QT_QUERY_MASTER  add (PM_XML  clob)
;

alter table MASTER_QUERY_GLOBAL_TEMP add (TEMPORAL_START_DATE DATE)
;

alter table MASTER_QUERY_GLOBAL_TEMP add (TEMPORAL_END_DATE DATE)
;


ALTER TABLE PATIENT_MAPPING
DROP CONSTRAINT PATIENT_MAPPING_PK
;

alter table PATIENT_MAPPING add (PROJECT_ID VARCHAR2(50))
;

update PATIENT_MAPPING set PROJECT_ID = 'Demo'
;

alter table PATIENT_MAPPING modify (PROJECT_ID VARCHAR2(50) NOT NULL)
;

ALTER TABLE PATIENT_MAPPING
ADD CONSTRAINT PATIENT_MAPPING_PK PRIMARY KEY(PATIENT_IDE, PATIENT_IDE_SOURCE, PROJECT_ID)
;

ALTER TABLE ENCOUNTER_MAPPING
DROP CONSTRAINT ENCOUNTER_MAPPING_PK
;

alter table ENCOUNTER_MAPPING add (PROJECT_ID VARCHAR2(50))
;

update ENCOUNTER_MAPPING set PROJECT_ID = 'Demo'
;

alter table ENCOUNTER_MAPPING modify (PROJECT_ID VARCHAR2(50) NOT NULL)
;

ALTER TABLE ENCOUNTER_MAPPING
ADD CONSTRAINT ENCOUNTER_MAPPING_PK PRIMARY KEY(ENCOUNTER_IDE, ENCOUNTER_IDE_SOURCE, PATIENT_IDE, PATIENT_IDE_SOURCE, PROJECT_ID)
;

drop table DX
;

CREATE GLOBAL TEMPORARY TABLE DX  (
	ENCOUNTER_NUM	NUMBER(38,0),
	INSTANCE_NUM	NUMBER(38,0),
	PATIENT_NUM		NUMBER(38,0),
	CONCEPT_CD 		varchar2(50), 
	START_DATE 		DATE,
	PROVIDER_ID 	varchar2(50), 
	temporal_start_date date, 
	temporal_end_date DATE	
 ) on COMMIT PRESERVE ROWS
;
 
drop table MASTER_QUERY_GLOBAL_TEMP
;

CREATE GLOBAL TEMPORARY TABLE MASTER_QUERY_GLOBAL_TEMP    ( 
	ENCOUNTER_NUM	NUMBER(38,0),
	PATIENT_NUM		NUMBER(38,0),
	INSTANCE_NUM	NUMBER(18,0) ,
	CONCEPT_CD      VARCHAR2(50),
	START_DATE	    DATE,
	PROVIDER_ID     VARCHAR2(50),
	MASTER_ID		VARCHAR2(50),
	LEVEL_NO		NUMBER(5,0),
	TEMPORAL_START_DATE DATE,
	TEMPORAL_END_DATE DATE
 ) ON COMMIT PRESERVE ROWS
;

--==============================================================
-- Database Script to upgrade CRC from 1.7.01 to 1.7.02                  
--==============================================================


create  GLOBAL TEMPORARY TABLE TEMP_PDO_INPUTLIST    ( 
char_param1 varchar2(100)
 ) ON COMMIT PRESERVE ROWS
;

ALTER TABLE ENCOUNTER_MAPPING
DROP CONSTRAINT ENCOUNTER_MAPPING_PK
;

alter table ENCOUNTER_MAPPING modify (PATIENT_IDE VARCHAR2(200) NOT NULL)
;

alter table ENCOUNTER_MAPPING modify (PATIENT_IDE_SOURCE VARCHAR2(50) NOT NULL)
;

ALTER TABLE ENCOUNTER_MAPPING
ADD CONSTRAINT ENCOUNTER_MAPPING_PK PRIMARY KEY(ENCOUNTER_IDE, ENCOUNTER_IDE_SOURCE, PROJECT_ID, PATIENT_IDE, PATIENT_IDE_SOURCE)
;


--==============================================================
-- Database Script to upgrade CRC from 1.7.09c to 1.7.10                  
--==============================================================

-- New column added to support new SQL breakdowns - roles based access
alter table QT_QUERY_RESULT_TYPE add (USER_ROLE_CD VARCHAR2(255))
;

--==============================================================
-- Database Script to upgrade CRC from 1.7.10 to 1.7.11                  
--==============================================================

insert into QT_PRIVILEGE(PROTECTION_LABEL_CD, DATAPROT_CD, HIVEMGMT_CD) values ('SETFINDER_QRY_PROTECTED','DATA_PROT','USER')
;
