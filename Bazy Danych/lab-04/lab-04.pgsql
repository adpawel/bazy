-- 4.1
SELECT k.nazwa FROM klienci k;

-- bez sensu
SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z;

SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z  
WHERE z.idklienta = k.idklienta;

SELECT k.nazwa, z.idzamowienia FROM klienci k NATURAL JOIN zamowienia z;

SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z
ON z.idklienta=k.idklienta;

SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z
USING (idklienta);


-- 4.2
select z.idzamowienia, z.datarealizacji, k.nazwa
from zamowienia z join klienci k
using (idklienta)
where k.nazwa like '%Antoni';

select z.idzamowienia, z.datarealizacji, k.ulica
from zamowienia z join klienci k
using (idklienta)
where k.ulica like '%/%';

select z.idzamowienia, z.datarealizacji, k.miejscowosc
from zamowienia z join klienci k
using (idklienta)
where k.miejscowosc = 'Kraków' 
and date_part('month', z.datarealizacji) = 11
and date_part('year', z.datarealizacji) = 2013;

-- 4.3
select distinct k.idklienta, k.nazwa, k.ulica, k.miejscowosc
from klienci k join zamowienia z using(idklienta)
where z.datarealizacji >= now() - interval'15 years';

select distinct k.idklienta, k.nazwa, k.ulica, k.miejscowosc
from klienci k join zamowienia z1 using(idklienta)
join artykuly a using(idzamowienia)
join pudelka p1 using(idpudelka)
where p1.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna');

select distinct k.idklienta, k.nazwa, k.ulica, k.miejscowosc
from klienci k 
where k.idklienta in (select idklienta from zamowienia);

select distinct k.idklienta, k.nazwa, k.ulica, k.miejscowosc
from klienci k left join zamowienia z on k.idklienta = z.idklienta
where z.idzamowienia is null;

select distinct k.idklienta, k.nazwa, k.ulica, k.miejscowosc
from klienci k join zamowienia z using(idklienta)
where date_part('month', z.datarealizacji) = 11
and date_part('year', z.datarealizacji) = 2013;

select distinct k.idklienta, k.nazwa, k.ulica, k.miejscowosc
from 
    klienci k 
    join zamowienia z1 using(idklienta)
    join artykuly a using(idzamowienia)
    join pudelka p1 using(idpudelka)
where p1.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna') 
and a.sztuk >= 2; 

select distinct k.idklienta, k.nazwa, k.ulica, k.miejscowosc
from 
    klienci k 
    join zamowienia z1 using(idklienta)
    join artykuly a using(idzamowienia)
    join pudelka p1 using(idpudelka)
    join zawartosc zaw using(idpudelka)
    join czekoladki c using(idczekoladki)
where c.orzechy = 'migdały';

-- 4.4
select p.nazwa, c.nazwa, z.sztuk
from pudelka p 
    join zawartosc z using(idpudelka)
    join czekoladki c using(idczekoladki);

select p.nazwa, c.nazwa, z.sztuk
from pudelka p 
    join zawartosc z using(idpudelka)
    join czekoladki c using(idczekoladki)
where p.idpudelka = 'heav';

select p.nazwa, c.nazwa, z.sztuk
from pudelka p 
    join zawartosc z using(idpudelka)
    join czekoladki c using(idczekoladki)
where p.nazwa like '%Kolekcja%';

-- 4.5
-- idpudelka, nazwa, opis, cena
select p.idpudelka, p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
where z.idczekoladki = 'd09';

select distinct p.idpudelka, p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
    join czekoladki c using(idczekoladki)
where c.nazwa like 'S%';

select distinct p.idpudelka, p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
where z.sztuk >= 4;

select distinct p.idpudelka, p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
    join czekoladki c using(idczekoladki)
where c.nadzienie = 'truskawki';

select distinct p.idpudelka, p.nazwa, p.opis, p.cena
from pudelka p
where p.idpudelka not in (select idpudelka 
    from zawartosc z 
        join czekoladki c using(idczekoladki)
    where c.czekolada = 'gorzka');

select distinct p.idpudelka, p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
    join czekoladki c using(idczekoladki)
where z.sztuk >= 3
and c.nazwa = 'Gorzka truskawkowa';

select distinct p.idpudelka, p.nazwa, p.opis, p.cena
from pudelka p
where p.idpudelka not in (select idpudelka 
    from zawartosc z 
        join czekoladki c using(idczekoladki)
    where c.orzechy is not null);

select distinct p.idpudelka, p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
    join czekoladki c using(idczekoladki)
where c.nazwa = 'Gorzka truskawkowa';

select distinct p.idpudelka, p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
    join czekoladki c using(idczekoladki)
where c.nadzienie is null;


-- 4.6
select c.idczekoladki, c.nazwa
from czekoladki c
where koszt > (select koszt from czekoladki where idczekoladki = 'd08');

WITH gorka AS (
    SELECT a.idpudelka
    FROM
        klienci k
        INNER JOIN zamowienia z ON k.idklienta = z.idklienta
        INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia
    WHERE k.nazwa = 'Górka Alicja'
)
SELECT kk.idklienta, kk.nazwa
FROM
    klienci kk
    INNER JOIN zamowienia zz ON kk.idklienta = zz.idklienta
    INNER JOIN artykuly aa ON zz.idzamowienia = aa.idzamowienia
    INNER JOIN gorka ON aa.idpudelka = gorka.idpudelka
WHERE kk.nazwa <> 'Górka Alicja'
GROUP BY kk.idklienta, kk.nazwa
ORDER BY kk.nazwa ASC;

WITH gorka AS (
    SELECT a.idpudelka
    FROM
        klienci k
        INNER JOIN zamowienia z ON k.idklienta = z.idklienta
        INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia
    WHERE k.nazwa = 'Górka Alicja'
)
SELECT kk.idklienta, kk.nazwa
FROM
    klienci kk
    INNER JOIN zamowienia zz ON kk.idklienta = zz.idklienta
    INNER JOIN artykuly aa ON zz.idzamowienia = aa.idzamowienia
    INNER JOIN gorka ON aa.idpudelka = gorka.idpudelka
GROUP BY kk.idklienta, kk.nazwa
ORDER BY kk.nazwa ASC;

with kato as (
    select a.idpudelka
    from 
        klienci k
        join zamowienia z on z.idklienta = k.idklienta
        join artykuly a on a.idzamowienia = z.idzamowienia
    where k.miejscowosc = 'Katowice'
)
select kk.idklienta, kk.nazwa, kk.miejscowosc
from 
    klienci kk 
    join zamowienia zz on kk.idklienta = zz.idklienta
    join artykuly aa on zz.idzamowienia = aa.idzamowienia
    join kato on aa.idpudelka = kato.idpudelka
where kk.miejscowosc != 'Katowice'
group by kk.idklienta, kk.nazwa
order by kk.nazwa asc;



