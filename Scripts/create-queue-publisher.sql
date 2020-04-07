-- Author: Rafael Luis da Costa Coelho
-- Created At: 01/04/2020

-- Change the parameters as you wish
BEGIN
    DBMS_AQADM.CREATE_QUEUE_TABLE
    (
        queue_table        => 'replication.aqt_product', 
        queue_payload_type => 'RAW', 
        multiple_consumers => FALSE
    );
 
    DBMS_AQADM.CREATE_QUEUE
    (
        queue_name=>'replication.aq_product', 
        queue_table=>'replication.aqt_product'
    );

    DBMS_AQADM.START_QUEUE(queue_name => 'replication.test_q');
END;