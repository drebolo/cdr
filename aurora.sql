DROP DATABASE IF EXISTS minion_jobs;

CREATE DATABASE minion_jobs;

DROP DATABASE IF EXISTS aurora;

CREATE DATABASE aurora;

USE aurora;

DROP TABLE IF EXISTS call_detail_record;

CREATE TABLE IF NOT EXISTS call_detail_record (
    id bigint(20) NOT NULL AUTO_INCREMENT,
    caller_id varchar(12),
    recipient varchar(12) NOT NULL,
    call_date date NOT NULL,
    end_time  time NOT NULL,
    duration smallint NOT NULL,
    cost DECIMAL(10,3) NOT NULL,
    reference VARCHAR(40) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (reference)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


