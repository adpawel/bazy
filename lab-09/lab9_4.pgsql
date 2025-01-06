begin;
set constraints firma.dzial_fk deferred;

insert into firma.dzialy values
    ('PH101','Handlowy','Marki',77),
    ('PR202','Projektowy','Olecko',27),
    ('PK101','Personalny','Niwka',72);

insert into firma.pracownicy VALUES
    (27,'Kruk','Adam','1989-12-15','PK101','kierownik',2200.00),
    (270,'Kowalik','Artur','1988-12-13','PK101','analityk',2400.00),
    (72,'Kowalik','Adam','1989-11-15','PR202','kierownik',2600.00),
    (720,'Kowalik','Amadeusz','1988-12-17','PK101','analityk',3200.00),
    (707,'Kukulka','Antoni','1999-12-15','PH101','robotnik',1600.00),
    (207,'Kowal','Alojzy','1998-10-15','PH101','robotnik',2000.00),
    (77,'Kowalus','Adam','1998-11-12','PH101','kierownik',5400.00),
    (1010,'Kawula','Alojzy','1998-11-15','PK101','robotnik',2500.00);

commit;