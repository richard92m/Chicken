CREATE TABLE CHATUSERS
(
ID NUMBER PRIMARY KEY,
EMAIL VARCHAR2(100) NOT NULL UNIQUE,
PASSWORD VARCHAR2(100) NOT NULL,
FNAME VARCHAR2(50) NOT NULL,
LNAME VARCHAR2(50) NOT NULL,
ISADMIN NUMBER CHECK(ISADMIN IN (0,1)),
AVATAR VARCHAR(255),
STATUS NUMBER DEFAULT 0,
FILTER NUMBER DEFAULT 0,
LASTLOGIN DATE,
TIMESVOTED NUMBER
);

/

CREATE TABLE USERSTATUS
(
ID NUMBER PRIMARY KEY,
NAME VARCHAR2(50) NOT NULL
);

/

INSERT INTO USERSTATUS(ID, NAME) VALUES(0, 'safe');
/
INSERT INTO USERSTATUS(ID, NAME) VALUES(1, 'banned');

/

CREATE TABLE SPOTLIGHTROUND
(
ID NUMBER PRIMARY KEY,
WINNER NUMBER NOT NULL,
LOSER NUMBER NOT NULL,
FOREIGN KEY(WINNER) REFERENCES CHATUSERS(ID),
FOREIGN KEY(LOSER) REFERENCES CHATUSERS(ID),
STARTDATE DATE NOT NULL,
ENDDATE DATE NOT NULL,
WINNERVOTES NUMBER NOT NULL,
LOSERVOTES NUMBER NOT NULL
);

/

CREATE SEQUENCE USER_SEQ
START WITH 1
INCREMENT BY 1;

/

CREATE OR REPLACE TRIGGER USER_SEQ
BEFORE INSERT ON CHATUSERS
FOR EACH ROW
BEGIN
IF :NEW.ID IS NULL THEN
  SELECT USER_SEQ.NEXTVAL INTO :NEW.ID FROM DUAL;
  END IF;
END;

/

CREATE SEQUENCE SPOTLIGHTROUND_SEQ
START WITH 1
INCREMENT BY 1;

/

CREATE OR REPLACE TRIGGER SPOTLIGHTROUND_SEQ
BEFORE INSERT ON SPOTLIGHTROUND
FOR EACH ROW
BEGIN
IF :NEW.ID IS NULL THEN
  SELECT SPOTLIGHTROUND_SEQ.NEXTVAL INTO :NEW.ID FROM DUAL;
  END IF;
END;