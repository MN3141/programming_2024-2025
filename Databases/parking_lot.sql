INSERT INTO `user` (`ID`, `EMAIL`, `PASSWORD`, `USERNAME`)
VALUES ('-1', 'admin@admin.com', NULL, 'admin');
INSERT INTO `car` (`ID`, `LICENSEPLATE`, `PARKINGSPOT`, `OWNER_ID`)
VALUES ('-1', 'SB01ABC', 'Spot 1', '-1'), ('-2', 'SB02ABC', 'Spot 2', '-1');

select * from user;
select * from car