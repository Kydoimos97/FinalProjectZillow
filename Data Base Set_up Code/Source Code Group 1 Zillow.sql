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
	email_address VARCHAR2(250) NOT NULL,
	first_name VARCHAR2(100),
	last_name VARCHAR2(100), 
	screen_name VARCHAR2(25),
	photo_url_user VARCHAR2(1000),
CONSTRAINT user_tb_pk PRIMARY KEY (email_address)
);
	
CREATE TABLE listing (
	zillow_id INTEGER NOT NULL,
	street VARCHAR2(250) NOT NULL,
	city VARCHAR2(250) NOT NULL,
	zip_code NUMBER(5,0) NOT NULL,
	NMLS_num NUMBER(9,0) NOT NULL,
	state_name VARCHAR2(21) NOT NULL,
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
CONSTRAINT listing_fk3 FOREIGN KEY (zip_code) REFERENCES neighborhood (neighborhood_zip)
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
	email_address VARCHAR2(250) NOT NULL,
	zillow_id INTEGER NOT NULL,
	timestamp_view TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
CONSTRAINT views_tb_pk PRIMARY KEY (zillow_id, email_address, timestamp_view),
CONSTRAINT views_tb_fk1 FOREIGN KEY (email_address) REFERENCES user_tb (email_address),
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
	email_address VARCHAR2(250) NOT NULL,
	listing_type VARCHAR2(25),
	price_from NUMBER(12,2),
	price_to NUMBER(12,2),
	bedrooms_num NUMBER(3,0),
	bathrooms_num NUMBER(3,0),
	zip_code NUMBER(5,0),
	save_index INTEGER NOT NULL,
CONSTRAINT user_saved_searches_pk PRIMARY KEY (email_address, save_index),
CONSTRAINT user_saved_searches_fk FOREIGN KEY (email_address) REFERENCES user_tb (email_address)
);
 
CREATE TABLE user_saved_listing (
	email_address VARCHAR2(250) NOT NULL,
	zillow_id INTEGER NOT NULL,
CONSTRAINT user_saved_listing_pk PRIMARY KEY (email_address, zillow_id),
CONSTRAINT user_saved_listing_fk1 FOREIGN KEY (email_address) REFERENCES user_tb (email_address),
CONSTRAINT user_saved_listing_fk2 FOREIGN KEY (zillow_id) REFERENCES listing (zillow_id)
);

---------------------------------------------------------------------------
-- execute the following statements to insert data
---------------------------------------------------------------------------

--Agent Table
INSERT INTO agent_tb (NMLS_num, agent_first_name, agent_middle_name, agent_last_name, realtor_firm, agent_photo_url)
VALUES (220892, 'Tracy', 'W', 'Burton', 'Coldwell Banker Realty', 'mortgageapi.zillow.com/getLenderProfileImage?lenderId=ZU105rqhtvat895_a57uh');
INSERT INTO agent_tb (NMLS_num, agent_first_name, agent_middle_name, agent_last_name, realtor_firm, agent_photo_url)
VALUES (340314, 'Peter', NULL, 'Thomson', 'BlueMountain Realty', 'mortgageapi.zillow.com/getLenderProfileImage?lenderId=ZUzngaas7bd5op_7vqv3');
INSERT INTO agent_tb (NMLS_num, agent_first_name, agent_middle_name, agent_last_name, realtor_firm, agent_photo_url)
VALUES (210683, 'Charles', NULL, 'Taylor', 'Tyler Parrish Windermere RE', 'https://mortgageapi.zillow.com/getLenderProfileImage?lenderId=ZUymqcks0usnpl_3jtqo');
INSERT INTO agent_tb (NMLS_num, agent_first_name, agent_middle_name, agent_last_name, realtor_firm, agent_photo_url)
VALUES (258528, 'Christopher', NULL, 'Corroon', 'Axis Realty Group', 'https://mortgageapi.zillow.com/getLenderProfileImage?lenderId=ZUt5riwuahs5qh_32yx0');
INSERT INTO agent_tb (NMLS_num, agent_first_name, agent_middle_name, agent_last_name, realtor_firm, agent_photo_url)
VALUES (293023, 'Michael', NULL, 'Elifritz', 'iPro Realty Network', 'https://mortgageapi.zillow.com/getLenderProfileImage?lenderId=ZU10684i1kthfd5_8fetp');
INSERT INTO agent_tb (NMLS_num, agent_first_name, agent_middle_name, agent_last_name, realtor_firm, agent_photo_url)
VALUES (450615, 'Kathleen', NULL, 'Haas', 'THE RESOURCE GROUP LLC', 'https://mortgageapi.zillow.com/getLenderProfileImage?lenderId=ZU11yh42jsn2pl5_4u6i9');

--Neighbourhood Table
INSERT INTO neighborhood  (neighborhood_zip, aerial_iframe, transit_score, walk_score, average_zestimate, neighborhood_name)
VALUES (84102, NULL, 59, 65, 472018.00, 'East Central');
INSERT INTO neighborhood  (neighborhood_zip, aerial_iframe, transit_score, walk_score, average_zestimate, neighborhood_name)
VALUES (84103, NULL, 50, 6, 621506.00, 'Greater Avenues');
INSERT INTO neighborhood  (neighborhood_zip, aerial_iframe, transit_score, walk_score, average_zestimate, neighborhood_name)
VALUES (84101, NULL, 68, 91, 387903.00, 'Downtown');
INSERT INTO neighborhood  (neighborhood_zip, aerial_iframe, transit_score, walk_score, average_zestimate, neighborhood_name)
VALUES (84106, NULL, NULL, 72, 478920.00, '84106');
INSERT INTO neighborhood  (neighborhood_zip, aerial_iframe, transit_score, walk_score, average_zestimate, neighborhood_name)
VALUES (80205, NULL, 86, 94, 553430.00, 'Five Points');
 
--State Table
INSERT INTO state_tb (state_name, pa_gender_iden, pa_sexual_orient, emp_gender_iden, emp_sexual_orient, hous_gender_iden, hous_sexual_orient)
VALUES ('Utah', 'Y', 'Y', 'Y', 'Y', 'N', 'N');
INSERT INTO state_tb (state_name, pa_gender_iden, pa_sexual_orient, emp_gender_iden, emp_sexual_orient, hous_gender_iden, hous_sexual_orient)
VALUES ('Colorado', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y');
 
--User Table
INSERT INTO user_tb (email_address, first_name, last_name, screen_name, photo_url_user)
VALUES ('ceslemont0@etsy.com', 'Charles', 'Eslemont', 'ceslemont0', 'https://photos.zillowstatic.com/h_i/ISvkb3cx783hla0000000000.jpg');
INSERT INTO user_tb (email_address, first_name, last_name, screen_name, photo_url_user)
VALUES ('tbevens0@phoca.cz', 'Tammie', 'Bevens', 'tbevens0', 'https://photos.zillowstatic.com/h_i/ISvkb3cx783hla0000000001.jpg');
INSERT INTO user_tb (email_address, first_name, last_name, screen_name, photo_url_user)
VALUES ('gyelland1@about.com', 'Ginelle', 'Yelland', 'gyelland1', 'https://photos.zillowstatic.com/h_i/ISvkb3cx783hla0000200000.jpg');
INSERT INTO user_tb (email_address, first_name, last_name, screen_name, photo_url_user)
VALUES ('jcansdill2@epa.gov', 'Julianna', 'Cansdill', 'jcansdill2', 'https://photos.zillowstatic.com/h_i/ISvkb3cx783hla0030000000.jpg');
INSERT INTO user_tb (email_address, first_name, last_name, screen_name, photo_url_user)
VALUES ('lcopozio3@deliciousdays.com', 'Loren', 'Copozio', 'lcopozio3', 'https://photos.zillowstatic.com/h_i/ISvkb3cx783hla0040000000.jpg');
INSERT INTO user_tb (email_address, first_name, last_name, screen_name, photo_url_user)
VALUES ('jdawber4@thetimes.co.uk', 'Jim', 'Dawber', 'jdawber4', 'https://photos.zillowstatic.com/h_i/ISvkb3cx783hla0000000050.jpg');
INSERT INTO user_tb (email_address, first_name, last_name, screen_name, photo_url_user)
VALUES ('ppedgrift5@instagram.com', 'Peggy', 'Pedgrift', 'ppedgrift5', 'https://photos.zillowstatic.com/h_i/ISvkb3cx783hla0060000000.jpg');
INSERT INTO user_tb (email_address, first_name, last_name, screen_name, photo_url_user)
VALUES ('spalffrey6@buzzfeed.com', 'Sela', 'Palffrey', 'spalffrey6', 'https://photos.zillowstatic.com/h_i/ISvkb3cx783hla0000700000.jpg');
INSERT INTO user_tb (email_address, first_name, last_name, screen_name, photo_url_user)
VALUES ('nbaldwin7@simplemachines.org', 'Natassia', 'Baldwin', 'nbaldwin7', 'https://photos.zillowstatic.com/h_i/ISvkb3cx783hla8000000000.jpg');
INSERT INTO user_tb (email_address, first_name, last_name, screen_name, photo_url_user)
VALUES ('mpounsett8@usatoday.com', 'Mattie', 'Pounsett', 'mpounsett8', 'https://photos.zillowstatic.com/h_i/ISvkb3cx783hla0000090000.jpg');
INSERT INTO user_tb (email_address, first_name, last_name, screen_name, photo_url_user)
VALUES ('amuzzlewhite9@com.com', 'Artair', 'Muzzlewhite', 'amuzzlewhite9', 'https://photos.zillowstatic.com/h_i/ISvkb3cx783hla01000000000.jpg');
 
--Listing Table
INSERT INTO listing (zillow_id, street, city, zip_code, NMLS_num, state_name, listing_date, price, sqft, bedrooms_num, bathrooms_num, hoa, property_tax, listing_desc, zestimate, MLS_num, expiration_date, date_sold, listing_type)
VALUES (2072429152,'374 S 1200 E', 'Salt Lake City', 84102, 220892, 'Utah', TO_DATE('2021-03-18', 'YYYY-MM-DD'),  574900.00, 2217.00, 3, 2, 'Has HOA fee: No', 355.00,
'Perfect original woodwork, Original lead glass light fixtures and sconces, Crown moldings, Coved ceilings and immaculate Oak floors. Main floor bath has period tile with newer granite counters. Kitchen was updated approximately 1998 w/Wolfe Range and hood. Newer roof, furnace and A/C. ALL of this AND a 2 car garage with storage above!',
NULL, 1730405,NULL, NULL, 'For Sale');
 
INSERT INTO listing (zillow_id, street, city, zip_code, NMLS_num, state_name, listing_date, price, sqft, bedrooms_num, bathrooms_num, hoa, property_tax, listing_desc, zestimate, MLS_num, expiration_date, date_sold, listing_type)
VALUES (2073227522,'558 S Windsor St E', 'Salt Lake City', 84102, 340314, 'Utah', TO_DATE('2021-02-26', 'YYYY-MM-DD'),  414900.00, 1194.00, 3, 1, 'Has HOA fee: No', 256.00,
'Talk about an amazing location! This home has been updated with quartz countertops, stainless steel appliances, tile, bathroom fixtures, carpet and so much more! Easy to show and ready for you to move in ASAP!',
432939.00, 1726677,NULL, NULL, 'For Sale');
 
INSERT INTO listing (zillow_id, street, city, zip_code, NMLS_num, state_name, listing_date, price, sqft, bedrooms_num, bathrooms_num, hoa, property_tax, listing_desc, zestimate, MLS_num, expiration_date, date_sold, listing_type)
VALUES (145095302,'350 N Federal Heights Cir', 'Salt Lake City', 84103, 210683, 'Utah', TO_DATE('2021-03-11', 'YYYY-MM-DD'),  6750000.00, 14996, 3, 5, NULL, 4163.00,
'Welcome to 350 N Federal Heights Circle. A landmark Utah estate arrives on the market, situated on almost eight acres in the foothills of Federal Heights. The home has nearly 15,000 square feet and boasts unobstructed 270-degree views of the entire Salt Lake Valley. An additional 3,300 square feet of terraces span the south of the home and feature an outdoor pool capable of year-round use.',
6434882.00, 12100932,NULL, NULL, 'For Sale');
 
INSERT INTO listing (zillow_id, street, city, zip_code, NMLS_num, state_name, listing_date, price, sqft, bedrooms_num, bathrooms_num, hoa, property_tax, listing_desc, zestimate, MLS_num, expiration_date, date_sold, listing_type)
VALUES (2077063137,'55 W South Temple St 701', 'Salt Lake City', 84101, 258528, 'Utah', TO_DATE('2020-11-23', 'YYYY-MM-DD'),  1775000.00, 2027, 2, 3, 'HOA fee: $901 monthly', 1095.00,
'In the heart of the city and directly across from Temple Square, this luxury home offers exceptional living with unbeatable views of the Salt Lake Citys historic Temple grounds. Couple this with world-class shopping at City Creek Center, the citys best dining and entertainment options (all right outside your door) and you have a home that offers it all.',
1705638.00, 1714105,NULL, NULL, 'For Sale');
 
INSERT INTO listing (zillow_id, street, city, zip_code, NMLS_num, state_name, listing_date, price, sqft, bedrooms_num, bathrooms_num, hoa, property_tax, listing_desc, zestimate, MLS_num, expiration_date, date_sold, listing_type)
VALUES (2077681201,'712 S 1000 E', 'Salt Lake City', 84102, 220892, 'Utah', TO_DATE('2020-09-29', 'YYYY-MM-DD'),  995000.00, 2343, 4, 4, 'HOA fee: $150 monthly', 614.00,
'Location- near the U of U, near downtown Salt Lake City. Perched on 10th East with Incredible views. Walking distance from shopping and movies. Close to everything, but yet in a peaceful and quite neighborhood. New contemporary construction inside and out. Quality built with the latest in designer features. This is a true masterpiece.',
NULL, 1704218,NULL, NULL, 'For Sale');
 
INSERT INTO listing (zillow_id, street, city, zip_code, NMLS_num, state_name, listing_date, price, sqft, bedrooms_num, bathrooms_num, hoa, property_tax, listing_desc, zestimate, MLS_num, expiration_date, date_sold, listing_type)
VALUES (2119043326,'3103 S 1000 E', 'South Salt Lake City', 84106, 293023, 'Utah', TO_DATE('2021-02-25', 'YYYY-MM-DD'),  995000.00, 4208, 6, 5, 'Has HOA fee: No', 614.00,
'Modern fully remodeled home located in the heart of Millcreek City. The home was completely renovated in 2019 with full permits. Two new central air HVAC systems, new roof, new skylights, new flooring, new drywall/paint, 2 brand new high end kitchens with marble countertops and custom cabinets, 2 laundries, Luxury Vinyl Tile throughout the living areas and marble tile in the bathrooms, new electrical and plumbing. Owner is a licensed real estate agent in the state of Utah',
1100009.00, 1725040,NULL, NULL, 'For Sale');
 
INSERT INTO listing (zillow_id, street, city, zip_code, NMLS_num, state_name, listing_date, price, sqft, bedrooms_num, bathrooms_num, hoa, property_tax, listing_desc, zestimate, MLS_num, expiration_date, date_sold, listing_type)
VALUES (61470755,'2245 Blake St APT M', 'Denver', 80205, 450615, 'Colorado', TO_DATE('2021-10-16', 'YYYY-MM-DD'),  18000000.00, 6903.50, 4, 7, 'HOA fee: $2,430 monthly', 7950.00,
'This exclusive residential loft is unlike anything else that currently exists in Downtown Denver. The owners  spent years renovating both Penthouse units and a 3rd adjacent unit to individually occupy the top two floors of the building which is located next to Coors Field. If you desire a lot of open space, this is one of the largest residential lofts in Downtown Denver at nearly 7000 square feet.',
1368037.00, 4180033,NULL, NULL, 'For Sale');
 
INSERT INTO listing (zillow_id, street, city, zip_code, NMLS_num, state_name, listing_date, price, sqft, bedrooms_num, bathrooms_num, hoa, property_tax, listing_desc, zestimate, MLS_num, expiration_date, date_sold, listing_type)
VALUES (2075168881,'1140 26th St', 'Denver', 80205, 450615, 'Colorado', TO_DATE('2021-02-05', 'YYYY-MM-DD'),  999000.00, 2414.00, 3, 4, 'Has HOA fee: No', 441.00,
'Urban contemporary architecture has taken root in the heart of RiNo and around the corner from Sustainability Park and Denver Central Market. This brand-new townhome community centers around the urban experience boasting high walkability to the best of RiNos vibrant culture, alongside giving you a stunning space to entertain.',
1032299.00, 3826320,NULL, NULL, 'For Sale');
 
--Listing Photos
--House 1
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2072429152, 'https://photos.zillowstatic.com/fp/a24017a2522803454c6e91056efa10f1-cc_ft_768.jpg', 1);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2072429152, 'https://photos.zillowstatic.com/fp/ec9851314cd76ecb295b80a875f44668-cc_ft_384.jpg', 2);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2072429152, 'https://photos.zillowstatic.com/fp/a24017a2522803454c6e91056efa10f1-cc_ft_768.jpg', 3);
 
--House 2
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2073227522, 'https://photos.zillowstatic.com/fp/f81a814ee8879da7b02e64d8e4222e2a-cc_ft_768.jpg', 1);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2073227522, 'https://photos.zillowstatic.com/fp/e758b8a62fbd08773c1dfeec03f8585f-cc_ft_384.jpg', 2);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2073227522, 'https://photos.zillowstatic.com/fp/7b46ee25bd6bb4a54d277b440d83a62e-cc_ft_384.jpg', 3);
 
--House 3
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (145095302, 'https://photos.zillowstatic.com/fp/8a5009041d016ccaaa4d8b422b395ce4-cc_ft_768.jpg', 1);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (145095302, 'https://photos.zillowstatic.com/fp/4c458397a96b4033318a9e0bb7f5cd0d-cc_ft_384.jpg', 2);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (145095302, 'https://photos.zillowstatic.com/fp/4219fee49e6e5ef29ef29c7843e6e905-cc_ft_384.jpg', 3);
 
--House 4
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2077063137, 'https://photos.zillowstatic.com/fp/b3731e8f1128ecb7bec981b6093b5082-cc_ft_768.jpg', 1);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2077063137, 'https://photos.zillowstatic.com/fp/18314a98be8ceb1c3377c74a67008f3a-cc_ft_384.jpg', 2);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2077063137, 'https://photos.zillowstatic.com/fp/714689eb0fff454a4e882bd278efdbd0-cc_ft_384.jpg', 3);
 
--House 5
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2077681201, 'https://photos.zillowstatic.com/fp/772cc21fbc497459ce88817a729240dc-cc_ft_768.jpg', 1);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2077681201, 'https://photos.zillowstatic.com/fp/ea254420a1e6b7b06ce502959e79393d-cc_ft_384.jpg', 2);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2077681201, 'https://photos.zillowstatic.com/fp/ebf16cf9ce67e2d0fbabf972725ff99d-cc_ft_384.jpg', 3);
 
--House 6
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2119043326, 'https://photos.zillowstatic.com/fp/cf3897b9cec237fdd14ba2b3a90d72e5-cc_ft_768.jpg', 1);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2119043326, 'https://photos.zillowstatic.com/fp/4e1d1152d4504b54e09361e898d4e4a1-cc_ft_384.jpg', 2);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2119043326, 'https://photos.zillowstatic.com/fp/06b6d34894c458a1415f8cb9e55abcea-cc_ft_384.jpg', 3);
 
--House 7
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (61470755, 'https://photos.zillowstatic.com/fp/2788ff77d06dd30af4d91d9a2d53dfc8-cc_ft_768.jpg', 1);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (61470755, 'https://photos.zillowstatic.com/fp/479429c6117fb477aa3850523e8d3180-cc_ft_384.jpg', 2);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (61470755, 'https://photos.zillowstatic.com/fp/cae8528b2c4d44901b2355a39b4e83b0-cc_ft_384.jpg', 3);
 
--House 8
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2075168881, 'https://photos.zillowstatic.com/fp/f1450c0fba3039bd4e9d758e49f770d7-cc_ft_768.jpg', 1);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2075168881, 'https://photos.zillowstatic.com/fp/f4e53f3a91f5a97a1a27fd26e3c34087-cc_ft_384.jpg', 2);
INSERT INTO listing_photos (zillow_id, photo_url, listing_index)
VALUES (2075168881, 'https://photos.zillowstatic.com/fp/57588578c69a3ab5ae64aadd9bb3254b-cc_ft_384.jpg', 3);
 

--Listing Update
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (2073227522, TO_DATE('2021/03/17', 'YYYY-MM-DD'), 414900.00, 'Price Change');
 
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (145095302, TO_DATE('2016/12/02', 'YYYY-MM-DD'), NULL, 'Sold');
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (145095302, TO_DATE('2016/04/16', 'YYYY-MM-DD'), NULL, 'Sold');
 
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (2077681201, TO_DATE('2021/03/01', 'YYYY-MM-DD'), 995000.00, 'Price Change');
 
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (2119043326, TO_DATE('2012/05/25', 'YYYY-MM-DD'), 290000.00, 'Listing Removed');
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (2119043326, TO_DATE('2012/07/26', 'YYYY-MM-DD'), 290000.00, 'Listing Removed');
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (2119043326, TO_DATE('2018/10/31', 'YYYY-MM-DD'), NULL, 'Sold');
 
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (61470755, TO_DATE('2020/10/14', 'YYYY-MM-DD'), 18000.00, 'Listed for Sale');
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (61470755, TO_DATE('2012/11/20', 'YYYY-MM-DD'), 759000.00, 'Sold');
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (61470755, TO_DATE('2020-10-16', 'YYYY-MM-DD'), 18000000.00, 'Listed for Sale');
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (61470755, TO_DATE('2020/10/15', 'YYYY-MM-DD'), 18000000.00, 'Price Change');
 
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (2075168881, TO_DATE('2020/03/04', 'YYYY-MM-DD'), 999000.00, 'Price Change');
INSERT INTO listing_update (zillow_id, date_update, price, event)
VALUES (2075168881, TO_DATE('2020/02/05', 'YYYY-MM-DD'), 959000.00, 'Listed for Sale');
 
--Views Table
--Utah
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('ceslemont0@etsy.com',2072429152, TO_TIMESTAMP ('3/23/2020 9:22:00 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('ceslemont0@etsy.com',2073227522, TO_TIMESTAMP ('3/23/2020 9:23:50 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('ceslemont0@etsy.com',2077063137, TO_TIMESTAMP ('3/23/2020 9:25:25 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('ceslemont0@etsy.com',2119043326, TO_TIMESTAMP ('3/23/2020 9:30:18 AM', 'MM/DD/YYYY HH:MI:SS AM'));
 
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('tbevens0@phoca.cz',61470755, TO_TIMESTAMP ('3/20/2021 5:55:25 PM', 'MM/DD/YYYY HH:MI:SS AM'));
 
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('gyelland1@about.com',2073227522, TO_TIMESTAMP ('3/22/2020 7:05:18 PM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('gyelland1@about.com',145095302, TO_TIMESTAMP ('3/22/2020 7:05:18 PM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('gyelland1@about.com',2077681201, TO_TIMESTAMP ('3/22/2020 7:05:18 PM', 'MM/DD/YYYY HH:MI:SS AM'));
 
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('jcansdill2@epa.gov',2072429152, TO_TIMESTAMP ('3/20/2020 11:05:15 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('jcansdill2@epa.gov',145095302, TO_TIMESTAMP ('3/20/2020 11:06:26 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('jcansdill2@epa.gov',2077063137, TO_TIMESTAMP ('3/20/2020 11:08:48 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('jcansdill2@epa.gov',2077681201, TO_TIMESTAMP ('3/20/2020 11:09:10 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('jcansdill2@epa.gov',2119043326, TO_TIMESTAMP ('3/20/2020 11:10:10 AM', 'MM/DD/YYYY HH:MI:SS AM'));
 
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('lcopozio3@deliciousdays.com',2073227522, TO_TIMESTAMP ('3/22/2020 10:05:29 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('lcopozio3@deliciousdays.com',2077063137, TO_TIMESTAMP ('3/22/2020 10:06:58 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('lcopozio3@deliciousdays.com',2119043326, TO_TIMESTAMP ('3/22/2020 10:09:31 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('lcopozio3@deliciousdays.com',2119043326, TO_TIMESTAMP ('3/23/2020 11:10:12 PM', 'MM/DD/YYYY HH:MI:SS AM'));
 
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('jdawber4@thetimes.co.uk',2073227522, TO_TIMESTAMP ('3/21/2020 9:25:30 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('jdawber4@thetimes.co.uk',2072429152, TO_TIMESTAMP ('3/21/2020 9:30:25 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('jdawber4@thetimes.co.uk',2072429152, TO_TIMESTAMP ('3/22/2020 7:13:05 PM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('jdawber4@thetimes.co.uk',2072429152, TO_TIMESTAMP ('3/23/2020 6:00:15 PM', 'MM/DD/YYYY HH:MI:SS AM'));
 
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('ppedgrift5@instagram.com',145095302, TO_TIMESTAMP ('3/20/2020 8:12:10 PM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('ppedgrift5@instagram.com',2077681201, TO_TIMESTAMP ('3/20/2020 8:15:12 PM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('ppedgrift5@instagram.com',2119043326, TO_TIMESTAMP ('3/20/2020 8:19:56 PM', 'MM/DD/YYYY HH:MI:SS AM'));
 
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('spalffrey6@buzzfeed.com',145095302, TO_TIMESTAMP ('3/23/2020 3:15:45 PM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('spalffrey6@buzzfeed.com',2077063137, TO_TIMESTAMP ('3/23/2020 3:18:25 PM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('spalffrey6@buzzfeed.com',145095302, TO_TIMESTAMP ('3/23/2020 6:12:28 PM', 'MM/DD/YYYY HH:MI:SS AM'));
 
--Colorado
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('nbaldwin7@simplemachines.org',61470755, TO_TIMESTAMP ('3/20/2020 6:17:28 PM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('nbaldwin7@simplemachines.org',2075168881, TO_TIMESTAMP ('3/20/2020 6:21:28 PM', 'MM/DD/YYYY HH:MI:SS AM'));
 
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('mpounsett8@usatoday.com',2075168881, TO_TIMESTAMP ('3/21/2020 9:45:58 PM', 'MM/DD/YYYY HH:MI:SS AM'));
 
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('amuzzlewhite9@com.com',61470755, TO_TIMESTAMP ('3/20/2020 6:50:58 PM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('amuzzlewhite9@com.com',61470755, TO_TIMESTAMP ('3/21/2020 7:45:23 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO views_tb (email_address, zillow_id, timestamp_view)
VALUES ('amuzzlewhite9@com.com',61470755, TO_TIMESTAMP ('3/22/2020 9:12:14 PM', 'MM/DD/YYYY HH:MI:SS AM'));
 
--Similar Homes
--House 1
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (2072429152, 2072438404, '129 W 400 N', 'Salt Lake City', 84103, 559900.00, 1878.00, 3, 3, 'https://photos.zillowstatic.com/fp/9f712eea4be949e5e54004be78294263-cc_ft_768.jpg');
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (2072429152, 2072477393, '1369 S 1500 E', 'Salt Lake City', 84105, 619500.00, 2590.00, 3, 2, 'https://photos.zillowstatic.com/fp/d1666692b0d162f33f61ee0cd6cc5a40-cc_ft_768.jpg');
 
--House 2
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (2073227522, 12756132, '534 E Hawthorne Ave', 'Salt Lake City', 84102, 345000.00, 1036.00, 3, 1, 'https://photos.zillowstatic.com/fp/7cae4fe69f3985271b22733c23ec7bdc-cc_ft_768.jpg');
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (2073227522, 2076612683, '522 E Hawthorne Ave', 'Salt Lake City', 84102, 345000.00, 1070.00, 3, 1, 'https://photos.zillowstatic.com/fp/d28e8710432e19e0c9bfc52b4b024806-cc_ft_768.jpg');
 
--House 3
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (145095302, 11895000, '999 N Grove Dr', 'Alpine', 84004, 3499000.00, 10399.00, 4, 6, 'https://photos.zillowstatic.com/fp/32517e8a44b45d01569e033b074692cd-cc_ft_768.jpg');
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (145095302, 12756132, '5678 E Twin Creek Rd S', 'Salt Lake City', 84108, 4900000.00, 12362.00, 6, 10, 'https://photos.zillowstatic.com/fp/eab8664c8ad2514a920a49a212be677b-cc_ft_768.jpg');
 
--House 4
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (2077063137, 2076597900, '99 W South Temple St S 307', 'Salt Lake City', 84101, 1095000.00, 1844.00, 2, 2, 'https://photos.zillowstatic.com/fp/1334764748afdc0d681b6fd41a5fb1e0-cc_ft_768.jpg');
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (2077063137, 2076604697, '99 W South Temple St S 2703', 'Salt Lake City', 84101, 1999900.00, 2023.00, 2, 2, 'https://photos.zillowstatic.com/fp/d1dba74b89f24bfbee36bf789b1feb27-cc_ft_768.jpg');
 
--House 5
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (2077681201, 12759933, '1052 S Douglas St', 'Salt Lake City', 84105, 990000.00, 2500.00, 3, 4, 'https://photos.zillowstatic.com/fp/495132dbd3e17110685cbf667fca2803-cc_ft_768.jpg');
 
--House 6
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (2119043326, 2099267412, '746 E Empire Circle', 'Salt Lake City', 84106, 770000.00, 4032.00, 7, 3, 'https://photos.zillowstatic.com/fp/fe6d68c99adfec9b038a3ea7196d5108-cc_ft_768.jpg');
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (2119043326, 2072359692, '2414 E 3750 S', 'Salt Lake City', 84109, 880000.00, 3906.00, 5, 3, 'https://photos.zillowstatic.com/fp/8d0636abbc69594e41f1ea3cb9efacc8-cc_ft_768.jpg');
 
--House 7
-- Has no Similar Homes
 
--House 8
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (2075168881, 88905734, '2403 E 28th Ave', 'Denver', 80205, 948000.00, 2951.00, 4, 4, 'https://photos.zillowstatic.com/fp/099d90cd80d1b982f6d659cdf4f401cf-cc_ft_768.jpg');
INSERT INTO similar_home (zillow_id, zillow_id_sim, simhome_street, simhome_city, simhome_zip_code, simhome_price, simhome_sqft, simhome_bedrooms_num, simhome_bathrooms_num, first_photo_url)
VALUES (2075168881, 63786364, '2736 Curtis St', 'Denver', 80205, 947500.00, 2625.00, 3, 4, 'https://photos.zillowstatic.com/fp/a857d229d0a50cf899d5e081d5b1a7a7-cc_ft_768.jpg');
 
--User Saved Searches
--Utah
INSERT INTO user_saved_searches (email_address, listing_type, price_from, price_to, bedrooms_num, bathrooms_num, zip_code, save_index)
VALUES ('jcansdill2@epa.gov', 'For Sale', 425388.85, NULL, 6, 7, NULL, 1);
INSERT INTO user_saved_searches (email_address, listing_type, price_from, price_to, bedrooms_num, bathrooms_num, zip_code, save_index)
VALUES ('tbevens0@phoca.cz', 'For Sale', 686193.17, 834230.04, 6, NULL, '84103', 1);
INSERT INTO user_saved_searches (email_address, listing_type, price_from, price_to, bedrooms_num, bathrooms_num, zip_code, save_index)
VALUES ('ceslemont0@etsy.com', 'For Sale', 586750.42, 1128977.08, 11, 11, '84106',1);
INSERT INTO user_saved_searches (email_address, listing_type, price_from, price_to, bedrooms_num, bathrooms_num, zip_code, save_index)
VALUES ('jdawber4@thetimes.co.uk', 'For Sale', 159766.32, 1701469.0, 11, 6, NULL, 1);
INSERT INTO user_saved_searches (email_address, listing_type, price_from, price_to, bedrooms_num, bathrooms_num, zip_code, save_index)
VALUES ('spalffrey6@buzzfeed.com', 'For Sale', 270138.39, 169490.94, 7, NULL, NULL, 1);
INSERT INTO user_saved_searches (email_address, listing_type, price_from, price_to, bedrooms_num, bathrooms_num, zip_code, save_index)
VALUES ('gyelland1@about.com', 'For Sale', 999307.9, 1092838.02, 9, NULL, '84102', 1);
INSERT INTO user_saved_searches (email_address, listing_type, price_from, price_to, bedrooms_num, bathrooms_num, zip_code, save_index)
VALUES ('jdawber4@thetimes.co.uk', 'For Sale', 870063.05, 1015049.69, 6, 5, '84102', 2);
INSERT INTO user_saved_searches (email_address, listing_type, price_from, price_to, bedrooms_num, bathrooms_num, zip_code, save_index)
VALUES ('ppedgrift5@instagram.com', 'For Sale', 686396.18, 1133572.84, 9, NULL, '84106', 1);
 
--Colorado
INSERT INTO user_saved_searches (email_address, listing_type, price_from, price_to, bedrooms_num, bathrooms_num, zip_code, save_index)
VALUES ('nbaldwin7@simplemachines.org', 'For Sale', 445146.15, 1638509.07, 15, 13, 80205, 1);
INSERT INTO user_saved_searches (email_address, listing_type, price_from, price_to, bedrooms_num, bathrooms_num, zip_code, save_index)
VALUES ('mpounsett8@usatoday.com', 'For Sale', 451828.34, NULL, 11, 8, 80205, 1);
INSERT INTO user_saved_searches (email_address, listing_type, price_from, price_to, bedrooms_num, bathrooms_num, zip_code, save_index)
VALUES ('amuzzlewhite9@com.com', 'For Sale', 983783.6, NULL, 6, NULL, 80205, 1);
INSERT INTO user_saved_searches (email_address, listing_type, price_from, price_to, bedrooms_num, bathrooms_num, zip_code, save_index)
VALUES ('nbaldwin7@simplemachines.org', 'For Sale', 400000.00, 750000.07, 1, 12, 80205, 2);
 
--User Saved Listings
--Utah
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('lcopozio3@deliciousdays.com', 2072429152);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('spalffrey6@buzzfeed.com', 145095302);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('jdawber4@thetimes.co.uk', 145095302);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('gyelland1@about.com', 2072429152);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('ppedgrift5@instagram.com', 2077063137);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('tbevens0@phoca.cz', 2072429152);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('jcansdill2@epa.gov', 2119043326);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('ceslemont0@etsy.com', 2119043326);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('gyelland1@about.com', 2119043326);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('gyelland1@about.com', 145095302);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('spalffrey6@buzzfeed.com', 2073227522);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('jcansdill2@epa.gov', 2073227522);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('ppedgrift5@instagram.com', 2077681201);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('ppedgrift5@instagram.com', 145095302);
 
--Colorado
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('amuzzlewhite9@com.com', 61470755);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('mpounsett8@usatoday.com', 61470755);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('amuzzlewhite9@com.com', 2075168881);
INSERT INTO user_saved_listing (email_address, zillow_id)
VALUES ('nbaldwin7@simplemachines.org', 61470755);


