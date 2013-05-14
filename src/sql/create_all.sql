CREATE TABLE active_executing_flows (
	exec_id INT,
	host VARCHAR(255),
	port INT,
	update_time BIGINT,
	PRIMARY KEY (exec_id)
) ENGINE=InnoDB;

CREATE TABLE execution_flows (
	exec_id INT NOT NULL AUTO_INCREMENT,
	project_id INT NOT NULL,
	version INT NOT NULL,
	flow_id VARCHAR(128) NOT NULL,
	status TINYINT,
	submit_user VARCHAR(64),
	submit_time BIGINT,
	update_time BIGINT,
	start_time BIGINT,
	end_time BIGINT,
	enc_type TINYINT,
	flow_data LONGBLOB,
	PRIMARY KEY (exec_id),
	INDEX start_time (start_time),
	INDEX end_time (end_time),
	INDEX time_range (start_time, end_time),
	INDEX (project_id, flow_id)
) ENGINE=InnoDB;

CREATE TABLE execution_jobs (
	exec_id INT NOT NULL,
	project_id INT NOT NULL,
	version INT NOT NULL,
	flow_id VARCHAR(128) NOT NULL,
	job_id VARCHAR(128) NOT NULL,
	attempt INT,
	start_time BIGINT,
	end_time BIGINT,
	status TINYINT,
	input_params LONGBLOB,
	output_params LONGBLOB,
	attachments LONGBLOB,
	PRIMARY KEY (exec_id, job_id, attempt),
	INDEX exec_job (exec_id, job_id),
	INDEX exec_id (exec_id),
	INDEX job_id (project_id, job_id)
) ENGINE=InnoDB;

CREATE TABLE execution_logs (
	exec_id INT NOT NULL,
	name VARCHAR(128),
	attempt INT,
	enc_type TINYINT,
	start_byte INT,
	end_byte INT,
	log LONGBLOB,
	upload_time BIGINT,
	PRIMARY KEY (exec_id, name, attempt, start_byte),
	INDEX log_attempt (exec_id, name, attempt),
	INDEX log_index (exec_id, name)
) ENGINE=InnoDB;

CREATE TABLE project_events (
	project_id INT NOT NULL,
	event_type TINYINT NOT NULL,
	event_time BIGINT NOT NULL,
	username VARCHAR(64),
	message VARCHAR(512),
	INDEX log (project_id, event_time)
) ENGINE=InnoDB;

CREATE TABLE project_files (
	project_id INT NOT NULL,
	version INT not NULL,
	chunk INT,
	size INT,
	file LONGBLOB,
	PRIMARY KEY (project_id, version, chunk),
	INDEX file_version (project_id, version)
) ENGINE=InnoDB;

CREATE TABLE project_flows (
	project_id INT NOT NULL,
	version INT NOT NULL,
	flow_id VARCHAR(128),
	modified_time BIGINT NOT NULL,
	encoding_type TINYINT,
	json BLOB,
	PRIMARY KEY (project_id, version, flow_id),
	INDEX (project_id, version)
) ENGINE=InnoDB;


CREATE TABLE project_permissions (
	project_id VARCHAR(64) NOT NULL,
	modified_time BIGINT NOT NULL,
	name VARCHAR(64) NOT NULL,
	permissions INT NOT NULL,
	isGroup BOOLEAN NOT NULL,
	PRIMARY KEY (project_id, name),
	INDEX project_id (project_id)
) ENGINE=InnoDB;

CREATE TABLE project_properties (
	project_id INT NOT NULL,
	version INT NOT NULL,
	name VARCHAR(128),
	modified_time BIGINT NOT NULL,
	encoding_type TINYINT,
	property BLOB,
	PRIMARY KEY (project_id, version, name),
	INDEX (project_id, version)
) ENGINE=InnoDB;

CREATE TABLE projects (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(64) NOT NULL,
	active BOOLEAN,
	modified_time BIGINT NOT NULL,
	create_time BIGINT NOT NULL,
	version INT,
	last_modified_by VARCHAR(64) NOT NULL,
	description VARCHAR(255),
	enc_type TINYINT,
	settings_blob LONGBLOB,
	UNIQUE INDEX project_id (id),
	INDEX project_name (name)
) ENGINE=InnoDB;

CREATE TABLE project_versions (
	project_id INT NOT NULL,
	version INT not NULL,
	upload_time BIGINT NOT NULL,
	uploader VARCHAR(64) NOT NULL,
	file_type VARCHAR(16),
	file_name VARCHAR(128),
	md5 BINARY(16),
	num_chunks INT,
	PRIMARY KEY (project_id, version),
	INDEX project_version_id (project_id)
) ENGINE=InnoDB;

CREATE TABLE schedules (
	project_id INT NOT NULL,
	project_name VARCHAR(128) NOT NULL,
	flow_name VARCHAR(128) NOT NULL,
	status VARCHAR(16),
	first_sched_time BIGINT,
	timezone VARCHAR(64),
	period VARCHAR(16),
	last_modify_time BIGINT,
	next_exec_time BIGINT,
	submit_time BIGINT,
	submit_user VARCHAR(128),
	enc_type TINYINT,
	schedule_options LONGBLOB,
	primary key(project_id, flow_name)
) ENGINE=InnoDB;


CREATE TABLE active_sla (
	exec_id INT NOT NULL,
	job_name VARCHAR(128) NOT NULL,
	check_time BIGINT NOT NULL,
	rule TINYINT NOT NULL,
	enc_type TINYINT,
	options LONGBLOB NOT NULL,
	primary key(exec_id, job_name)
) ENGINE=InnoDB;

