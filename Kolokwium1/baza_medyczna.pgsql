select p.nazwa, l.specjalizacje, k.zrealizowana
from kolos1.pacjenci p 
    join kolos1.konsultacje k on(p.id_pacjenta = k.id_pacjenta)
    join kolos1.lekarze l on(k.id_lekarza = l.id_lekarza)
where 'dermatolog' = ANY(l.specjalizacje)
and zrealizowana = false;

select l.nazwa, p.data_urodzenia, p.id_pacjenta
from kolos1.lekarze l
    join kolos1.konsultacje k using(id_lekarza)
    join kolos1.pacjenci p using(id_pacjenta)
where extract(year from p.data_urodzenia) >  1990
and k.zrealizowana = true;

select * from kolos1.badania where na_czczo = true;

select nazwa from kolos1.pacjenci
where id_pacjenta not in (
    select distinct id_pacjenta from kolos1.konsultacje
    where zrealizowana = true
);

select * from kolos1.konsultacje
where termin between now() - interval '30 days' and now()
and zrealizowana = true;

select * from kolos1.badania
where cena > (select ceil(avg(cena)) from kolos1.badania);

select distinct id_pacjenta
from kolos1.konsultacje where id_pacjenta is not null and cena > 270;

select distinct k.id_lekarza, p.data_urodzenia
from kolos1.konsultacje k 
    join kolos1.pacjenci p using(id_pacjenta)
where extract(year from p.data_urodzenia) = 1980;

select nazwa from kolos1.lekarze where 'onkolog' = ANY(specjalizacje);

select * from kolos1.pacjenci where pesel like '99%';

-- czesc 2
select l.id_lekarza, coalesce(tab.koszt, 0)
from kolos1.lekarze l 
    left join (select id_lekarza, sum(cena) as koszt
            from kolos1.konsultacje
            group by id_lekarza
            ) tab on tab.id_lekarza = l.id_lekarza;

select specjalizacja, avg(cena)
from kolos1.konsultacje 
group by specjalizacja;

select l.id_lekarza, coalesce(tab.liczba, 0) 
from kolos1.lekarze l 
    left join (
        select id_lekarza, count(id_zlecenia) as liczba
        from kolos1.zlecenia
        group by id_lekarza
        ) tab on tab.id_lekarza = l.id_lekarza;

select max(cena)
from kolos1.badania b 
    join kolos1.zlecenia z on z.id_badania = b.id_badania;

select avg(floor((now()::date - p.data_urodzenia::date)/365))
from kolos1.pacjenci p 
    join kolos1.konsultacje k on k.id_pacjenta = p.id_pacjenta
where k.zrealizowana = true;

select extract(month from termin) as month_num, count(*)
from kolos1.konsultacje
where zrealizowana = FALSE
and now()::date < termin::date
group by extract(month from termin)
order by month_num;

select max(zlec.liczba)
from (select count(*) as liczba
from kolos1.zlecenia
where data_realizacji > now()::date
group by id_badania) zlec;

select z.id_pacjenta, sum(b.cena)
from kolos1.zlecenia z 
    join kolos1.badania b on b.id_badania = z.id_badania
group by z.id_pacjenta
order by z.id_pacjenta;

select l.nazwa 
from kolos1.zlecenia z
    join kolos1.lekarze l using(id_lekarza)
group by l.nazwa
having count(*) = (
select max(tab.liczba) as maksimum 
from (
    select z.id_lekarza, count(*) as liczba 
    from kolos1.zlecenia z
    group by z.id_lekarza
    ) as tab);

SELECT COUNT(*)
FROM (
    SELECT id_pacjenta
    FROM kolos1.konsultacje
    GROUP BY id_pacjenta
    HAVING COUNT(DISTINCT id_lekarza) > 1
) AS pacjenci;


-- czesc 3
select distinct p.id_pacjenta, p.nazwa, p.data_urodzenia, p.pesel
from kolos1.pacjenci p 
    join kolos1.konsultacje k using(id_pacjenta)
    join kolos1.lekarze l using(id_lekarza)
where 'kardiolog' = ANY(l.specjalizacje) 
or 'dermatolog' = ANY(l.specjalizacje);

select id_pacjenta from konsultacje where specjalizacja = 'kardiolog'
EXCEPT
select id_pacjenta from konsultacje where specjalizacja = 'dermatolog';

-- zad 3 omijamy

select distinct id_pacjenta from kolos1.konsultacje
intersect 
select distinct id_pacjenta from kolos1.zlecenia;

select id_lekarza from kolos1.lekarze where not 'gastroenterolog' = ANY(specjalizacje)
intersect
select distinct id_lekarza from kolos1.zlecenia;

-- czesc 4
select id_pacjenta, termin::date
from kolos1.konsultacje
where id_pacjenta is not null
group by termin::date, id_pacjenta
having count(*) > 1;

select id_lekarza from kolos1.zlecenia
where id_pacjenta not in (select id_pacjenta from kolos1.konsultacje);

select * from kolos1.badania 
where cena > 
(select ceil(avg(b.cena)) as srednia
from kolos1.badania b  
    join kolos1.zlecenia z on z.id_badania = b.id_badania
    where z.data_realizacji is not null);

SELECT k.id_konsultacji, k.id_pacjenta, k.id_lekarza, k.specjalizacja, k.cena
FROM kolos1.konsultacje k
WHERE k.cena > (
    SELECT AVG(k2.cena) 
    FROM kolos1.konsultacje k2 
    WHERE k2.specjalizacja = k.specjalizacja
);

select id_pacjenta
from kolos1.konsultacje
where id_pacjenta is not NULL
group by id_pacjenta
having count(distinct id_lekarza) = 1;

-- czesc 6
SELECT id_pacjenta
FROM kolos1.pacjenci p
where (
    select count(*)
    from kolos1.konsultacje k
    where k.id_pacjenta = p.id_pacjenta
) > (
    select count(*)
    from kolos1.zlecenia z
    where p.id_pacjenta = z.id_pacjenta and data_realizacji is not null
);

SELECT 
    l.id_lekarza, 
    l.nazwa AS nazwa_lekarza, 
    z.id_pacjenta, 
    COUNT(z.id_zlecenia) AS liczba_zlecen
FROM 
    kolos1.lekarze l
JOIN 
    kolos1.zlecenia z ON l.id_lekarza = z.id_lekarza
GROUP BY 
    l.id_lekarza, l.nazwa, z.id_pacjenta
HAVING 
    COUNT(z.id_zlecenia) > 5;

-- czesc 5
update kolos1.lekarze 
set specjalizacje = ARRAY['neurolog']
where id_lekarza = 5;

delete from kolos1.konsultacje
where zrealizowana = false and termin::date > (now()::date - interval'6 months');

insert into kolos1.badania(id_badania, nazwa, cena, na_czczo)
VALUES(6, 'Badanie kontrolne', 150, true);

update kolos1.badania
set cena = cena * 1.1
where cena < 200;

delete from kolos1.pacjenci 
where id_pacjenta not in (select id_pacjenta from kolos1.konsultacje)
and id_pacjenta not in (select id_pacjenta from kolos1.zlecenia);

insert into kolos1.pacjenci(id_pacjenta, nazwa, data_urodzenia, pesel)
values(123,'Nowak', '1990-12-12', '90121212345');

update konsultacje
set zrealizowana = true
where termin::date < '2024-01-01';


select nazwa, ceil(dlugosc/60) as dlugosc_minuty
from utwory
where dlugosc between 60 and 300
order by nazwa, dlugosc desc;

(select idwykonawcy from wykonawcy where data_zakonczenia is null)
intersect 
(select distinct idwykonawcy from albumy where extract(month from data_wydania) = 11);

select gatunek
from albumy
where idalbumu in (
    select distinct u.idalbumu
    from utwory u 
        join zawartosc z using(idutworu)
        join playlisty p using(idplaylisty)
        join klienci k using(idklienta)
    where k.data_rejestracji = (select data_urodzenia from klienci where login = 'jim')
); 

select idutworu 
from utwory 
where idutworu not in (
    select o.idutworu
    from oceny o 
        join klienci k using(idklienta)
    where idklienta = (select idklienta from klienci where login = 'kamila')
)
and idutworu 

update zawartosc z
set idplaylisty = 30
from utwory u
where u.idutworu = z.idutworu 
and u.dlugosc < 30
and z.idplaylisty = 20
and z.idutworu not in (select idutworu from oceny); 



insert into playlisty(idplaylisty, idklienta, nazwa)
values(30, (select idklienta from playlisty where idplaylisty = 20),'kopia popu');
insert into zawartosc 
select 30, idutworu from zawartosc where idplaylisty = 20;

select u.idutworu
from utwory u
    join zawartosc z on u.idutworu = z.idutworu
    join playlisty p on p.idplaylisty = z.idplaylisty
    join klienci k on k.idklienta = p.idklienta
where k.idklienta != (select idklienta from klienci where login = 'kamila')

select u.nazwa, coalesce(tab.srednia, 0)
from utwory u
    left join(select idutworu, avg(lubi::int) as srednia
    from oceny
    where idutworu in(
        select u.idutworu
        from utwory u
            join zawartosc z on u.idutworu = z.idutworu
            join playlisty p on p.idplaylisty = z.idplaylisty
            join klienci k on k.idklienta = p.idklienta
        where k.idklienta != (select idklienta from klienci where login = 'kamila')
    )
    group by idutworu) tab on tab.idutworu = u.idutworu;


select u.nazwa, coalesce(avg(o.lubi::int), 0.5) as srednia_ocena
from utwory u 
    left join oceny o using(idutworu)
where u.idutworu not in (
    select z.idutworu
    from zawartosc z 
        join playlisty p using(idplaylisty)
        join klienci k using(idklienta)
    where k.login = 'kamila'
)
group by u.idutworu, u.nazwa
order by u.nazwa;


select idpunktu as identyfikator_punktu_pomiarowego, poziom_wody
from pomiary
where poziom_wody between 100 and 150
order by poziom_wody desc;

select * from pomiary  
EXCEPT
select from pomiary p natural join ostrzezenia

select g.nazwa, pp.numer_porzadkowy, pp.dlugosc_geograficzna, pp.szerokosc_geograficzna
from punkty_pomiarowe pp 
    join gminy g using(idgminy)
where g.nazwa like '%ko%' or g.nazwa like 'Ko%';

select p.nazwa, max(pp.stan_ostrzegawczy - pp.stan_alarmowy)
from punkty_pomiarowe pp
    join gminy g using(id_gminy)
    join powiaty p using(id_powiatu)
group by p.nazwa


insert into punkty_pomiarowe(id_punktu, nr_porzadkowy, id_gminy, id_rzeki, dlugosc_geogr, szerokosc_geogr, stan_ostrzegawczy, stan_alarmowy)
values(
    90211,
    (select max(nr_porzadkowy) + 1
    from punkty_pomiarowe
    where id_rzeki = (select id_rzeki from rzeki where nazwa = 'Wisła')),
    1500,
    (select idrzeki from rzeki where nazwa = 'Wisła'),
    54.344765,
    18.946329,
    50,
    100
);









select idpunktu, poziom_wody
from pomiary 
where poziom_wody between 30 and 40
order by poziom_wody;

select id_pomiaru, id_punktu, czas_pomiaru, poziom_wody
from pomiary 
except 
select p.id_pomiaru, p.id_punktu, p.czas_pomiaru, p.poziom_wody
from pomiary p natural join ostrzezenia o;

select r.nazwa, pp.nr_porzadkowy, pp.dlugosc_geogr, pp.szerokosc_geogr
from punkty_pomiarowe pp 
    join rzeki r on r.id_rzeki = pp.id_rzeki
where r.nazwa like '%li%';

select p.nazwa, avg(pp.stan_ostrzegawczy - pp.stan_alarmowy) 
from powiaty p 
    join gminy g on g.id_powiatu = p.id_powiatu
    join punkty_pomiarowe pp on pp.idgminy = g.id_gminy
group by p.id_powiatu;

insert into punkty_pomiarowe
values(
    90212,
    (select max(pp.nr_porzadkowy) + 1 
     from punkty_pomiarowe pp
        join rzeki r using(idrzeki)
    where r.nazwa = 'Odra'),
    1500,
    (select id_rzeki from rzeki where nazwa = 'Odra'),
    53.244608,
    14.438567,
    80,
    120
)

-- grupa a
select * from ostrzezenia 
where czas_ostrzezenia::date > (now()::date - interval'6  months')
and zmiana_poziomu >= 1.07 

select pp.id_punktu from punkty_pomiarowe pp join pomiary p using(id_punktu)
except 
select id_punktu from ostrzezenia
where czas_ostrzezenia::date > (now()::date - interval'2 months');

select distinct g.nazwa
from gminy g
    join punkty_pomiarowe pp using(id_gminy)
    join ostrzezenia o using(id_punktu)
where o.przekroczony_stan_alarm > 0;

select r.nazwa_rzeki, p.czas_pomiaru::date
from rzeki r 
    join punkty_pomiarowe pp using(id_rzeki)
    join pomiary p using(id_punktu)
    join(
        select r.id_rzeki, r.nazwa_rzeki, max(p.poziom_wody) as max_poziom
        from rzeki r 
            join punkty_pomiarowe pp using(id_rzeki)
            join pomiary p using(id_punktu)
        group by r.id_rzeki, r.nazwa_rzeki
    ) tab using(id_rzeki);
where r.id_rzeki = tab.id_rzeki
and p.poziom_wody = tab.max_poziom 

update punkty_pomiarowe
set stan_alarmowy = stan_alarmowy - 5
where id_punktu = 10;
update ostrzezenia
set przekroczony_stan_alarm = przekroczony_stan_alarm + 5
where id_punktu = 10;

-- grupa b
select pp.id_punktu, pp.stan_alarmowy, pp.stan_ostrzegawczy
from punkty_pomiarowe pp 
    join gminy g using(id_gminy)
where pp.stan_alarmowy > (1 + 5*PI()/100) * stan_ostrzegawczy

select id_gminy from gminy where id_powiatu = 1)
except
select pp.idgminy
from punkty_pomiarowe pp 
    join rzeki r using(id_rzeki)
where r.id_rzeki = 1;

select pp.id_punktu, pp.stan_alarmowy
from punkty_pomiarowe pp 
    join rzeki r using(id_rzeki)
    join gminy g using(id_gminy)
where r.nazwa = 'Wisła'
and g.nazwa = 'Skoczów';

select g.nazwa, p.czas_pomiaru::date as data_pomiaru 
from gminy g 
    join punkty_pomiarowe pp using(id_gminy)
    join pomiary p using(id_punktu)
    join (
        select g.nazwa, g.id_gminy, max(p.poziom_wody) as max_poziom
        from gminy g 
            join punkty_pomiarowe pp using(id_gminy)
            join pomiary p using(id_punktu)
        group by g.id_gminy, g.nazwa
    ) tab using(id_gminy)
where g.id_gminy = tab.id_gminy 
and p.poziom_wody = tab.max_poziom;

insert into punkty_pomiarowe
values(
    34,
    10,
    246,
    3,
    50.134,
    22.11,
    (select stan_ostrzegawczy from punkty_pomiarowe where id_punktu = 25),
    (select stan_alarmowy from punkty_pomiarowe where id_punktu = 25)
    );

-- bd-kolos grupa A 
select * from zamowienia 
where (odbiorca is null or odbiorca like 'y%' or odbiorca like 'Y%') 
and data > (now()::date - interval'7 days');

select idzamow, idmebla from zamawiane_meble
union 
select idzamow, idmebla from zamawiane paczki

select e.nazwa, e.cena, coalesce(p.kod, 0)
from element e
    left join zawartosc z on z.idelementu = e.idelementu
    left join paczka p on (p.numer = z.numer and p.idmebla = z.idmebla)
    
select z.idzamow, z.odbiorca, sum(p.cena * zp.ilosc) as wartosc 
from zamowienia z 
    join zamawiane_paczki zp on zp.idzamow = z.idzamow
    join paczka p on p.numer = zp.numer and p.idmebla = zp.idmebla
group by z.idzamow, z.odbiorca

insert into element (nazwa, opis, cena)
select nazwa, concat(opis, ' Wersja wzmacniana'), cena + 2
from element
where nazwa ~* '%śruba%' and opis ~ '[M-Z]3%';

select * from paczka 
where (cena between 129 and 199 and kod is null) or kod ~*'%x'

select idzamow, idmebla, from zamawiane_meble order by idzamow, idmebla desc
except 
select idzamow, idmebla from zamawiane_paczki

select z.idzamow, m.nazwa
from zamawiane_meble zm 
    join mebel m on m.idmebla = zm.idmebla
    join zamowieni z on z.idzamow = zm.idzamow
where idmebla in (
    select idmebla
    from zamowienia z 
        join zamawiane_meble zm using(idzamow)
        join mebel m using(idmebla)
    where odbiorca = 'Kowalski'
)


select idalbumu, nazwa from albumy
except 
select a.idalbumu, a.nazwa from utwory u 
    join albumy a on a.idalbumu = u.idalbumu
where u.idutworu in (select distinct idutworu from oceny)

select idalbumu, nazwa, count(*), avg(dlugosc)
from albumy a 

select distinct a.idalbumu, a.nazwa, tab.liczba, tab.srednia
from albumy a join(
select id_albumu, count(idutworu) as liczba, avg(dlugosc) as srednia 
from utwory
group by idalbumu
having count(idutworu) > 5
) tab using(id_albumu)
order by tab.liczba desc;

SELECT p.nazwa,
CASE WHEN substring(p.pesel, 10, 1)::int % 2 = 1 THEN 'Mężczyzna'
        ELSE 'Kobieta'
END AS plec
FROM pacjenci p





















