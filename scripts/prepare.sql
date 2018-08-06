;;
;; @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
;; @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
;; @author W. Sibo <sibow@bloomington.in.gov>
;;
 
	  create table vendors(                                                            id int not null ,                                                               lname   varchar(50),                                                            fname     varchar(30),                                                          active   char(1),                                                               unique(id)                                                                      )engine=InnoDB;
		
	  create table users(                                                               id int not null auto_increment,                                                 userid varchar(10) not null,                                                    fullname varchar(70),                                                           role enum('Edit','Edit:Delete','Admin:Edit:Delete'),                            primary key(id),                                                                unique(userid)                                                                )engine=InnoDB; 
		
	  create table buck_types(                                                           id int not null auto_increment,                                                 name varchar(30),                                                               primary key(id)                                                               )engine=InnoDB;

	  create table gl_accounts(                                                         id int not null auto_increment,                                                 name varchar(20),                                                               primary key(id)                                                                 )engine=InnoDB;";
;;
;; gl account numbers, these may be different for your organization, check
;; with your accounting people, these are gl accounts related to funding the
;; three types of market bucks and gift certificates. Change them according
;; to your needs
;; 
	  insert into gl_accounts values(1,'201-18-186503-47240'),(2,'201-18-186503-47230'),(3,'201-18-186503-47230');
				
		create table buck_confs(                                                         id int not null auto_increment,                                                 value int not null,                                                             type_id int,                                                                    date date,                                                                      donor_max_value int not null,                                                   user_id int,                                                                    name varchar(50),                                                               gl_account varchar(20),                                                         primary key(id),                                                                foreign key(user_id) references users(id),                                      foreign key(type_id) references buck_types(id)                                )engine=InnoDB ;		

		create table batches(                                                            id int not null auto_increment,                                                 conf_id int,                                                                    batch_size    int,                                                              status enum('Printed','Waiting'),                                               start_seq      int,                                                             date     date,                                                                  user_id  int,                                                                   primary key(id),                                                                foreign key(conf_id) references buck_confs(id),                                 foreign key(user_id) references users(id)                                      )engine=InnoDB; 		
		
		create table buck_seq(                                                            id int not null auto_increment,                                                 batch_id int,                                                                   primary key(id),                                                                foreign key(batch_id) references batches(id)                                  )engine=InnoDB auto_increment=500; 
		
		create table bucks(                                                               id           int not null,                                                      value         int,                                                              fund_type     enum('ebt','mbd','iuh'),                                          voided        char(1),                                                          expire_date   date,                                                             primary key(id),                                                                foreign key(id) references buck_seq(id)                                        )engine=InnoDB;
		
		create table ebts(                                                               id int not null auto_increment,                                                 amount int,                                                                     approve varchar(30),                                                            card_last_4 varchar(4),                                                         user_id int,                                                                    date_time    timestamp,                                                         dmb_amount int,                                                                 cancelled char(1),                                                              primary key(id),                                                                foreign key(user_id) references users(id)                                    )engine=InnoDB; 
		
		 create table gifts(                                                              id int not null auto_increment,                                                 amount int,                                                                     pay_type enum('Cash','Check','Money Order','Credit Card','Honorary'),           check_no varchar(20),                                                           user_id int,                                                                    date_time    timestamp,
      dmb_amount int,	 
		  cancelled char(1),
      primary key(id),                                                                foreign key(user_id) references users(id)                                     )engine=InnoDB; 
		
		 create table ebt_bucks(                                                          ebt_id int not null,                                                            buck_id int not null,                                                           primary key(buck_id),                                                           foreign key(ebt_id) references ebts(id),                                        foreign key(buck_id) references bucks(id)                                      )engine=InnoDB; 
		
		create table gift_bucks(                                                          gift_id int not null,                                                           buck_id int not null,                                                           primary key(buck_id),                                                           foreign key(gift_id) references gifts(id),                                      foreign key(buck_id) references bucks(id)                                      )engine=InnoDB; ";
		
		 create table redeems(                                                            id int not null auto_increment,                                                 date_time     timestamp,                                                        vendor_id  int,                                                                 user_id  int,                                                                   status enum('Open','Completed'),                                                notes varchar(500),                                                             primary key(id),                                                                foreign key(user_id) references users(id)                                      )engine=InnoDB; 

		 create table redeem_bucks(                                                        redeem_id int not null,                                                         buck_id int not null,                                                           primary key(buck_id),                                                          foreign key(redeem_id) references redeems(id),                                  foreign key(buck_id) references bucks(id)                                      )engine=InnoDB; 

		 create table exports(                                                             id int not null auto_increment,                                                 date_time timestamp,                                                            user_id int,                                                                    nw_batch_name varchar(20),                                                      primary key(id),                                                                foreign key(user_id) references users(id)                                     )engine=InnoDB; 
		
		
			create table export_redeems(                                                      export_id int not null,                                                         redeem_id int not null,                                                         primary key(redeem_id),                                                         foreign key(export_id) references exports(id),                                  foreign key(redeem_id) references redeems(id)                                 )engine=InnoDB 

		   create table sweeps(                                                             id int not null auto_increment,                                                 date_time timestamp,                                                            user_id int,                                                                    sweep_name varchar(20),                                                         primary key(id),                                                                foreign key(user_id) references users(id)                                      )engine=InnoDB; 
				
		    create table sweep_bucks(                                                        sweep_id int not null,                                                          buck_id int not null,                                                           primary key(buck_id),                                                           foreign key(sweep_id) references sweeps(id),                                    foreign key(buck_id) references bucks(id)                                     )engine=InnoDB 
		
				create table disputes(                                                           id int not null auto_increment,                                                 redeem_id int not null,                                                         buck_id int not null,                                                           status enum('Waiting','Rejected','Resolved'),                                   reason enum('Expired','Not Exist','Not Issued','Redeemed','Voided')             user_id int,                                                                    date_time timestamp,                                                            suggestions varchar(500),                                                       notes varchar(500),                                                             primary key(id),                                                               foreign key(redeem_id) references redeems(id),                                  foreign key(user_id) references users(id)                                      )engine=InnoDB; 
		
				create table resolutions(                                                           id int not null auto_increment,                                                 dispute_id int not null,                                                        conf_id int,                                                                    value int,                                                                      approve varchar(30),                                                            card_last_4 varchar(4),                                                         pay_type varchar(10),                                                           check_no varchar(20),                                                           expire_date date,                                                               user_id int,                                                                    date_time timestamp,                                                            status  enum('Success','Failure'),                                              new_buck_id int,                                                                primary key(id),                                                                foreign key(dispute_id) references disputes(id),                                foreign key(conf_id) references buck_confs(id),                                 foreign key(user_id) references users(id),                                      foreign key(buck_id) references bucks(id),                                      foreign key(new_buck_id) references bucks(id))engine=InnoDB; 
		
     				create table vendor_updates(                                                     id int not null auto_increment,                                                 date date,                                                                      primary key(id)                                                               )engine=InnoDB; 
		
		     	create table cancelled_bucks(                                                    id int not null,                                                                user_id int,                                                                    date_time    timestamp default current_timestamp,                               primary key(id),                                                                foreign key(id) references bucks(id),                                           foreign key(user_id) references users(id)                                     )engine=InnoDB;
		
			  	create table mail_notifications(                                                 id int not null,                                                                super_user char(1),                                                             primary key(id),                                                                foreign key(id) references users(id)                                          )engine=InnoDB; 

;;
;; you will need to create quartz tables,  look at quartz-scheduler.org for
;; more info and download the latest jar libraries. If you use the included
;; quartz jars then the following tables should work. If you download the
;; latest, make sure to create the tables according to their
;; recommendation as they might haved changed some of the tables.
;; 
 CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

   CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 

 CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


  CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1`
	FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


 CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
   PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

  CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

  CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
				
  CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

   CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1`
	FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


  CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1`
	FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
				
				




































