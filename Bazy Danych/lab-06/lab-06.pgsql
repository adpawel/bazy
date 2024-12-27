-- 6.1
insert into czekoladki (idczekoladki, nazwa, czekolada, orzechy, nadzienie, opis, koszt, masa) 
values ('W98', 'Biały kieł', 'biała', 'laskowe','marcepan', 'Rozpływające się w rękach i kieszeniach', 0.45, 20);

insert into klienci 
(idklienta, nazwa, ulica, miejscowosc, kod, telefon)
values 
(90, 'Matusiak Edward', 'Kropiwnickiego 6/3','Leningrad', '31-471', '031 423 45 38'),
(91, 'Matusiak Alina', 'Kropiwnickiego 6/3', 'Leningrad', '31-471','031 423 45 38'),
(92, 'Kimono Franek', 'Karateków 8', 'Mistrz', '30-029', '501 498 324');

insert into klienci
(idklienta, nazwa, ulica, miejscowosc, kod, telefon)
values
(93,
'Matusiak Iza',
(SELECT ulica FROM klienci WHERE nazwa = 'Matusiak Edward'),
(SELECT miejscowosc FROM klienci WHERE nazwa = 'Matusiak Edward'),
(SELECT kod FROM klienci WHERE nazwa = 'Matusiak Edward'),
(SELECT telefon FROM klienci WHERE nazwa = 'Matusiak Edward')
);

-- 6.2
insert into czekoladki
values 
('X91', 'Nieznana Nieznajoma', null, null, null, 'Niewidzialna czekoladka wspomagajaca odchudzanie.', 0.26, 0),
('M98', 'Mleczny Raj', 'Mleczna', null, null, 'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.', 0.26, 36);

-- 6.3
delete from czekoladki where idczekoladki in ('X91', 'M98');

insert into czekoladki
(idczekoladki, nazwa, czekolada, opis, koszt, masa)
values
('X91', 'Nieznana Nieznajoma', null, 'Niewidzialna czekoladka wspomagajaca odchudzanie.', 0.26, 0),
('M98', 'Mleczny Raj', 'Mleczna', 'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.', 0.26, 36);

-- 6.4
update klienci set nazwa = 'Nowak Iza' where nazwa = 'Matusiak Iza';

update czekoladki set koszt = koszt * 1.1 
where idczekoladki in ('W98', 'M98', 'X91');

update czekoladki set koszt = (select koszt from czekoladki where idczekoladki = 'W98') 
where nazwa = 'Nieznana Nieznajoma';

update klienci set miejscowosc = 'Piotrograd'
where miejscowosc = 'Leningrad';

update czekoladki set koszt = koszt + 0.15 
where substr(idczekoladki, 2, 2)::int > 90;

-- 6.5
delete from klienci where nazwa like 'Matusiak %';

delete from klienci where idklienta > 91;

delete from czekoladki where (koszt >= 0.45) or (masa >= 36) or (masa = 0);

-- 6.6
insert into pudelka
(idpudelka, nazwa, opis, cena, stan)
values
('czek', 'Czekoladowe', 'Kreatywny opis', 25, 500),
('slod', 'Slodkie', 'Opis slodkiej czekoladki', 20, 300);

insert into zawartosc
(idpudelka, idczekoladki, sztuk)
values
('czek', 'b01', 3),
('czek', 'b02', 3),
('czek', 'b04', 2),
('czek', 'b05', 2),
('slod', 'm08', 2),
('slod', 'm12', 2),
('slod', 'm05', 3),
('slod', 'f02', 3);

select * from pudelka where idpudelka in ('czek', 'slod');
select * from zawartosc where idpudelka in ('czek', 'slod');


-- 6.7
-- COPY pudelka (id_pudelka, nazwa) FROM stdin;
-- abcd Nazwa 
-- efgh Pudelko

-- 6.8
update zawartosc set sztuk = sztuk + 1
where idpudelka in ('czek', 'slod');

update czekoladki set czekolada = 'brak'
where czekolada is null;
update czekoladki set orzechy = 'brak'
where orzechy is null;
update czekoladki set nadzienie = 'brak'
where nadzienie is null;


select * from czekoladki;

update czekoladki set czekolada = null
where czekolada = 'brak';
update czekoladki set orzechy = null
where orzechy = 'brak';
update czekoladki set nadzienie = null
where nadzienie = 'brak';
