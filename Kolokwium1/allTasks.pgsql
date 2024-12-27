-- lab-01
SELECT * FROM czekoladki;

SELECT * FROM czekoladki
WHERE czekolada = 'mleczna';

SELECT * FROM czekoladki
WHERE czekolada = 'mleczna' AND
orzechy = 'laskowe';

SELECT * FROM czekoladki
WHERE czekolada in ('mleczna', 'gorzka');

SELECT * FROM czekoladki
WHERE masa > 25;

SELECT * FROM klienci
WHERE miejscowosc in ('Gdańsk', 'Kraków', 'Warszawa');

-- lab-02
SELECT nazwa, ulica, miejscowosc
FROM klienci
ORDER BY nazwa;

SELECT * FROM klienci
ORDER BY miejscowosc DESC, nazwa;

SELECT * FROM klienci
WHERE miejscowosc in ('Kraków', 'Warszawa')
ORDER BY miejscowosc DESC, nazwa;

SELECT * FROM klienci
ORDER BY miejscowosc desc;

SELECT * FROM klienci
WHERE miejscowosc = 'Kraków'
ORDER BY nazwa desc;

select nazwa, masa from czekoladki
where masa > 20;

select nazwa, masa, koszt 
from czekoladki
where masa > 20 AND
    koszt > 0.25;

select nazwa, masa, koszt * 100 as "koszt w groszach"
from czekoladki
where masa > 20 AND
koszt > 0.25;

select nazwa, czekolada, nadzienie, orzechy
from czekoladki
where (czekolada = 'mleczna'and nadzienie = 'maliny')
or
(nadzienie = 'truskawki' and czekolada = 'mleczna')
or (orzechy = 'laskowe' AND czekolada != 'gorzka');

select nazwa, koszt from czekoladki
where koszt > 0.25;

select nazwa, czekolada
from czekoladki
where czekolada in ('biała', 'mleczna');

select (124 * 7 + 45) as result;
select (2^20) as result;
select sqrt(3) as result;
-- select n as result;

select idczekoladki, nazwa, masa, koszt
from czekoladki
where masa between 15 and 24;

select idczekoladki, nazwa, masa, koszt
from czekoladki
where koszt between 0.25 and 0.35;

select idczekoladki, nazwa, masa, koszt
from czekoladki
where koszt between 0.15 and 0.24
or masa between 25 and 35;

select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where orzechy is not null;

select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where orzechy is null;

select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where orzechy is not null or nadzienie is not null;

select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where czekolada in ('mleczna', 'biała')
and orzechy is null;

select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where czekolada not in ('mleczna', 'biała')
and (orzechy is not null or nadzienie is not null);

select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where nadzienie is not null;

select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where nadzienie is null;

select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where orzechy is null and nadzienie is null;

select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where czekolada in ('mleczna', 'biała')
and nadzienie is null;

SELECT idzamowienia, dataRealizacji
from zamowienia 
where extract(MONTH from dataRealizacji) = 11;

-- idczekoladki w najmniejszej ilosci pudelek
with xyz as(
    select cz.idczekoladki, count(zaw.idczekoladki) as liczba
    from czekoladki cz
        left join zawartosc zaw using(idczekoladki)
    group by cz.idczekoladki
)
select cz.idczekoladki, count(zaw.idczekoladki) as liczba
    from czekoladki cz
        left join zawartosc zaw using(idczekoladki)
    group by cz.idczekoladki
    having count(zaw.idczekoladki) = (select min(xyz.liczba) from xyz);

with xyz as(
select a.idpudelka, count(*) as liczba
from artykuly a
group by a.idpudelka
)
select a.idpudelka
from artykuly a
group by a.idpudelka
having count(a.idpudelka) = (select max(xyz.liczba) from xyz);

select extract(quarter from z.datarealizacji) as kwartal, count(*) as liczba
from zamowienia z
group by kwartal;

select extract(month from z.datarealizacji) as miesiac, count(*) as liczba
from zamowienia z
group by miesiac
order by miesiac;

select extract(week from z.datarealizacji) as tydzien, count(*) as liczba
from zamowienia z
group by tydzien
order by tydzien;

select k.miejscowosc, count(*) as liczba_zamowien
from zamowienia z
    join klienci k on k.idklienta = z.idklienta
group by k.miejscowosc
order by k.miejscowosc;

SELECT sum(tab.waga_pud)
from(
SELECT z.idpudelka, sum(c.masa * z.sztuk * p.stan) as waga_pud
from zawartosc z 
    join czekoladki c using(idczekoladki)
    join pudelka p using(idpudelka)
group by z.idpudelka
) tab;

select sum(p.cena * p.stan)
from pudelka p;

with ceny as(select p.idpudelka, (p.cena - tab.prod) as wartosc 
from pudelka p
join(
select z.idpudelka, sum(z.sztuk * c.koszt) as prod
from zawartosc z
    join czekoladki c using(idczekoladki)
    join pudelka p using(idpudelka)
group by z.idpudelka
) tab using(idpudelka))

select a.idpudelka, (ceny.wartosc * a.sztuk)
from artykuly a 
    join ceny using(idpudelka);

-- lab 06
INSERT INTO czekoladki(idczekoladki, nazwa, czekolada, orzechy, nadzienie, 
opis, koszt, masa)
VALUES ('F16', 'Czarny kieł', 'gorzka', 'laskowe', 'marcepan', 
'Rozpływające się w rekach i kieszeniach', 0.45, 20);

INSERT INTO klienci(idklienta, nazwa, ulica, miejscowosc, kod, telefon)
VALUES(89, 'Lewandowski Robert', 'Barcelońska 74/3', 'Warszawa', '31-471', '023 420 12 32'),
(88, 'Lewandowska Anna', 'Barcelońska 74/3', 'Warszawa', '31-471', '023 420 12 32'),
(87, 'Messi Lionel', 'Wall Street 3/2', 'Miami', '31-478', '333 445 654');

INSERT INTO klienci(idklienta, nazwa, ulica, miejscowosc, kod, telefon)
VALUES(94, 'Lewandowska Klara', 
(SELECT ulica FROM klienci WHERE nazwa = 'Lewandowski Robert'),
(SELECT miejscowosc FROM klienci WHERE nazwa = 'Lewandowski Robert'),
(SELECT kod FROM klienci WHERE nazwa = 'Lewandowski Robert'),
(SELECT telefon FROM klienci WHERE nazwa = 'Lewandowski Robert'));

UPDATE klienci 
SET nazwa = 'Kowalska Anna' WHERE nazwa = 'Lewandowska Anna';

select * from klienci;
