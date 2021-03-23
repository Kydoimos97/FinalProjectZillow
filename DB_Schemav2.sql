---------------------------------------------------------------------------
-- execute the following statements to drop the tables
---------------------------------------------------------------------------
DROP TABLE user_saved_listing;
DROP TABLE user_saved_searches;
DROP TABLE similar_home;
DROP TABLE views_tb;
DROP TABLE listing_update;
DROP TABLE listing_photos;
DROP TABLE listing;
DROP TABLE user_tb;
DROP TABLE state_tb;
DROP TABLE neighborhood;
DROP TABLE agent_tb;


---------------------------------------------------------------------------
-- execute the following statements to create tables
---------------------------------------------------------------------------

    --agent_middle_name CHAR(1) NOT NULL, 

CREATE TABLE agent_tb ( 
    NMLS_num NUMBER(6,0) NOT NULL,
    agent_first_name VARCHAR2(100) NOT NULL, 
    agent_middle_name CHAR(1),
    agent_last_name VARCHAR2(100) NOT NULL, 
    realtor_firm VARCHAR2(250) NOT NULL, 
    agent_photo_url VARCHAR2(1000), 
CONSTRAINT agent_tb_pk PRIMARY KEY (NMLS_num)
);

CREATE TABLE neighborhood (
    neighborhood_zip NUMBER(5,0) NOT NULL,
    aerial_iframe VARCHAR2(1000),
    transit_score NUMBER(3,0),
    walk_score NUMBER(3,0),
    average_zestimate NUMBER(12,2),
    neighborhood_name VARCHAR2(250),
CONSTRAINT neighborhood_pk PRIMARY KEY (neighborhood_zip)
);

CREATE TABLE state_tb (
    state_name VARCHAR2(21) NOT NULL, 
    pa_gender_iden CHAR(1) NOT NULL,
    pa_sexual_orient CHAR(1) NOT NULL,
    emp_gender_iden CHAR(1) NOT NULL,
    emp_sexual_orient CHAR(1) NOT NULL,
    hous_gender_iden CHAR(1) NOT NULL,
    hous_sexual_orient CHAR(1) NOT NULL,
CONSTRAINT state_tb_pk PRIMARY KEY (state_name)
);

CREATE TABLE user_tb (
    email_adress VARCHAR2(250) NOT NULL,
    first_name VARCHAR2(100),
    last_name VARCHAR2(100),  
    screen_name VARCHAR2(25),
    photo_url_user VARCHAR2(1000),
CONSTRAINT user_tb_pk PRIMARY KEY (email_adress)
);
    
CREATE TABLE listing (
    zillow_id INTEGER NOT NULL,
    street VARCHAR2(250) NOT NULL, 
    city VARCHAR2(250) NOT NULL,
    zip_code NUMBER(5,0) NOT NULL,
    NMLS_num NUMBER(9,0) NOT NULL,
    state_name VARCHAR2(21) NOT NULL,
    neighborhood_zip NUMBER(5,0) NOT NULL, 
    listing_date DATE NOT NULL, 
    price NUMBER(10,2) NOT NULL, 
    sqft NUMBER(12,2) NOT NULL, 
    bedrooms_num NUMBER(3,0) NOT NULL, 
    bathrooms_num NUMBER (3,0) NOT NULL, 
    HOA VARCHAR2(250), 
    property_tax NUMBER(9,2),
    listing_desc VARCHAR(1000),
    zestimate NUMBER (9,2), 
    MLS_num NUMBER (9,0) NOT NULL, 
    expiration_date DATE, 
    date_sold DATE, 
    listing_type VARCHAR2(25) NOT NULL, 
CONSTRAINT listing_pk PRIMARY KEY (zillow_id),
CONSTRAINT listing_fk1 FOREIGN KEY (NMLS_num) REFERENCES agent_tb (NMLS_num),
CONSTRAINT listing_fk2 FOREIGN KEY (state_name) REFERENCES state_tb (state_name),
CONSTRAINT listing_fk3 FOREIGN KEY (neighborhood_zip) REFERENCES neighborhood (neighborhood_zip)
);

CREATE TABLE listing_photos (
    zillow_id INTEGER NOT NULL,
    photo_url VARCHAR2(1000),
    listing_index INTEGER NOT NULL,
CONSTRAINT listing_photos_pk PRIMARY KEY (zillow_id, listing_index),
CONSTRAINT listing_photos_fk1 FOREIGN KEY (zillow_id) REFERENCES listing (zillow_id)
);

CREATE TABLE listing_update (
    zillow_id INTEGER NOT NULL,
    date_update DATE NOT NULL,
    price NUMBER(10,2), 
    event varchar(25), 
CONSTRAINT listing_update_pk PRIMARY KEY (zillow_id, date_update),
CONSTRAINT listing_update_fk1 FOREIGN KEY (zillow_id) REFERENCES listing (zillow_id)
);




CREATE TABLE views_tb (
    email_adress VARCHAR2(250) NOT NULL,
    zillow_id INTEGER NOT NULL,
    timestamp_view TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
CONSTRAINT views_tb_pk PRIMARY KEY (zillow_id, email_adress, timestamp_view),
CONSTRAINT views_tb_fk1 FOREIGN KEY (email_adress) REFERENCES user_tb (email_adress),
CONSTRAINT views_tb_fk2 FOREIGN KEY (zillow_id) REFERENCES listing (zillow_id)
);

CREATE TABLE similar_home (
    zillow_id INTEGER NOT NULL, 
    zillow_id_sim INTEGER NOT NULL,
    simhome_street VARCHAR2(250) NOT NULL, 
    simhome_city VARCHAR2(250) NOT NULL, 
    simhome_zip_code NUMBER(5,0) NOT NULL, 
    simhome_price NUMBER(12,2) NOT NULL,
    simhome_sqft NUMBER (9,2) NOT NULL,
    simhome_bedrooms_num NUMBER (3,0) NOT NULL,
    simhome_bathrooms_num NUMBER (3,0) NOT NULL,
    first_photo_url VARCHAR2(1000),
CONSTRAINT similar_home_pk PRIMARY KEY (zillow_id, zillow_id_sim),
CONSTRAINT similar_home_fk1 FOREIGN KEY (zillow_id) REFERENCES listing (zillow_id)
);

CREATE TABLE user_saved_searches (
    email_adress VARCHAR2(250) NOT NULL,
    listing_type VARCHAR2(25),
    price_from NUMBER(12,2),
    price_to NUMBER(12,2),
    bedrooms_num NUMBER(3,0),
    bathrooms_num NUMBER(3,0),
    zip_code NUMBER(5,0),
    save_index INTEGER NOT NULL,
CONSTRAINT user_saved_searches_pk PRIMARY KEY (email_adress, save_index),
CONSTRAINT user_saved_searches_fk FOREIGN KEY (email_adress) REFERENCES user_tb (email_adress)
);

CREATE TABLE user_saved_listing (
    email_adress VARCHAR2(250) NOT NULL,
    zillow_id INTEGER NOT NULL,
CONSTRAINT user_saved_listing_pk PRIMARY KEY (email_adress, zillow_id),
CONSTRAINT user_saved_listing_fk1 FOREIGN KEY (email_adress) REFERENCES user_tb (email_adress),
CONSTRAINT user_saved_listing_fk2 FOREIGN KEY (zillow_id) REFERENCES listing (zillow_id)
);

