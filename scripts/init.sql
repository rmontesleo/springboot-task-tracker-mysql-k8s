DROP TABLE IF EXISTS tasks;

CREATE TABLE tasks( 
    id INTEGER PRIMARY KEY AUTO_INCREMENT,     
    task_text VARCHAR(200) NOT NULL,
    task_day VARCHAR(200) NOT NULL,
    set_reminder TINYINT NOT NULL CHECK( set_reminder IN (0,1) ) DEFAULT 0
); 
