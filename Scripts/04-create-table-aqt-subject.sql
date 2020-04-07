-- Author: Rafael Luis da Costa Coelho
-- Created At: 01/04/2020

-- Connect as replication user.

CREATE SEQUENCE safeguard.seq_subject
       MINVALUE 1
       MAXVALUE 999999999
     START WITH 1
   INCREMENT BY 1
        NOCACHE;

CREATE TABLE safeguard.aqt_subject
(
    id        NUMBER(9) DEFAULT safeguard.seq_subject.NEXTVAL NOT NULL,
    name      VARCHAR2(32) NOT NULL,
    situation VARCHAR2(4) NOT NULL
)
TABLESPACE tbs_safeguard
   PCTFREE 10
  INITRANS 1
  MAXTRANS 255
   STORAGE
   (
       INITIAL 64K
       NEXT 1M
       MINEXTENTS 1
       MAXEXTENTS UNLIMITED
   );

COMMENT ON TABLE safeguard.subject IS 'Subject table.';

COMMENT ON COLUMN safeguard.subject.ID IS 'Subject identification.';
COMMENT ON COLUMN safeguard.subject.NAME IS 'Ssubject name.';
COMMENT ON COLUMN safeguard.subject.SITUATION IS 'Subject situation, (0) offline, (1) online, (2) bloqued (3) disabled.';

ALTER TABLE safeguard.subject
        ADD CONSTRAINT pk_subject
    PRIMARY KEY (id)
      USING INDEX TABLESPACE tbs_safeguard;

ALTER TABLE safeguard.subject
        ADD CONSTRAINT ck_subject_situation
      CHECK (SITUATION IN (0, 1, 2, 3));

GRANT SELECT ON safeguard.seq_subject TO replication;
GRANT SELECT, INSERT, UPDATE, DELETE ON safeguard.subject TO replication;