-- zad 10.2.1
select z.dataRealizacji, z.idzamowienia
from zamowienia z
    join klienci k using(idklienta)
where k.idklienta in (
    select idklienta from klienci
    where nazwa like '%Antoni'
);

-- zad 10.2.2
select z.dataRealizacji, z.idzamowienia
from zamowienia z
    join klienci k using(idklienta)
where k.idklienta in (
    select idklienta from klienci
    where ulica like '%/%'
);

-- zad 10.2.3
select dataRealizacji, idzamowienia
from zamowienia 
where extract(month from dataRealizacji) = 11 and 
    extract(year from dataRealizacji) = 2013 and
    idklienta = any(
        select idklienta from klienci
        where miejscowosc = 'Kraków'
    );



-- zad 10.3.1
select nazwa, ulica, miejscowosc
from klienci k 
where idklienta in (
    select idklienta from zamowienia
    where datarealizacji = '2013-11-12'
);

-- zad 10.3.2
select nazwa, ulica, miejscowosc
from klienci k 
where idklienta in (
    select idklienta from zamowienia
    where extract(month from datarealizacji) = 11 and
        extract(year from datarealizacji) = 2013
);

-- zad 10.3.3
select nazwa, ulica, miejscowosc
from klienci
where idklienta in (
    select distinct k.idklienta
    from klienci k 
        join zamowienia z using(idklienta)
        join artykuly a using(idzamowienia)
        join pudelka p using(idpudelka)
    where p.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna')     
);

-- zad 10.3.4
select nazwa, ulica, miejscowosc
from klienci
where idklienta in (
    select distinct k.idklienta
    from klienci k
    join zamowienia z using(idklienta)
    where z.idzamowienia in (
    select a.idzamowienia 
    from pudelka p  
        join artykuly a using(idpudelka)
    where p.nazwa in ('Kolekcja jesienna', 'Kremowa fantazja')
        and sztuk >= 2
    )
);

-- zad 10.3.5
select nazwa, ulica, miejscowosc
from klienci 
where idklienta in (
    select k.idklienta from klienci k 
        join zamowienia z using(idklienta)
        join artykuly a using(idzamowienia)
    where a.idpudelka in (
        select distinct p.idpudelka
        from pudelka p
            join zawartosc z using(idpudelka)
            join czekoladki c using(idczekoladki)
        where orzechy = 'migdały'
    )
);

-- zad 10.3.6
select nazwa, ulica, miejscowosc
from klienci 
where idklienta in (
    select k.idklienta from zamowienia z 
        left join klienci k using(idklienta)
);

-- zad 10.3.7
select nazwa, ulica, miejscowosc
from klienci 
where idklienta not in (
    select k.idklienta from zamowienia z 
        left join klienci k using(idklienta)
);



-- zad 10.4.1
select p.nazwa, p.opis, p.cena 
from pudelka p
where idpudelka in (
    select distinct z.idpudelka
    from zawartosc z 
        join czekoladki c using(idczekoladki)
    where c.idczekoladki = 'd09'
);

-- zad 10.4.2
select p.nazwa, p.opis, p.cena 
from pudelka p
where idpudelka in (
    select distinct z.idpudelka
    from zawartosc z 
        join czekoladki c using(idczekoladki)
    where c.nazwa = 'Gorzka truskawkowa'
);

-- zad 10.4.3
select p.nazwa, p.opis, p.cena 
from pudelka p
where idpudelka in (
    select distinct z.idpudelka
    from zawartosc z 
        join czekoladki c using(idczekoladki)
    where c.nazwa like 'S%'
);

-- zad 10.4.4
select p.nazwa, p.opis, p.cena 
from pudelka p
where idpudelka in (
    select distinct z.idpudelka
    from zawartosc z 
        join czekoladki c using(idczekoladki)
    where sztuk >= 4
);

-- zad 10.4.5
select p.nazwa, p.opis, p.cena 
from pudelka p
where idpudelka in (
    select distinct z.idpudelka
    from zawartosc z 
        join czekoladki c using(idczekoladki)
    where c.nazwa = 'Gorzka truskawkowa' and sztuk >=4
);

-- zad 10.4.6
select p.nazwa, p.opis, p.cena 
from pudelka p
where idpudelka in (
    select distinct z.idpudelka
    from zawartosc z 
        join czekoladki c using(idczekoladki)
    where c.nadzienie = 'truskawki'
);

-- zad 10.4.7
select p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
except
select p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
where exists(
    select * from czekoladki
    where czekoladki.czekolada = 'gorzka'
        and czekoladki.idczekoladki = z.idczekoladki
);

select p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
except
select p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
where z.idczekoladki in (
    select idczekoladki from czekoladki
    where czekolada = 'gorzka'
);

-- zad 10.4.8
select p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
except
select p.nazwa, p.opis, p.cena
from pudelka p
    join zawartosc z using(idpudelka)
where exists(
    select * from czekoladki
    where czekoladki.orzechy is not null
        and czekoladki.idczekoladki = z.idczekoladki
);

-- zad 10.4.9
select p.nazwa, p.opis, p.cena
from pudelka p
where exists(
    select * from zawartosc z 
    join czekoladki c using(idczekoladki)
    where c.nadzienie is null AND
        z.idpudelka = p.idpudelka
);



-- zad 10.5.1
select idczekoladki, nazwa 
from czekoladki
where koszt > all(
    select koszt from czekoladki
    where idczekoladki = 'd08'
);

-- zad 10.5.2
select nazwa from klienci 
where idklienta in(
    select k.idklienta from klienci k 
    join zamowienia z using(idklienta)
    join artykuly a using(idzamowienia)
    where a.idpudelka in (
        select a.idpudelka from zamowienia zam 
        join klienci kl using(idklienta)
        join artykuly a using(idzamowienia)
        where kl.nazwa = 'Górka Alicja'
    ) and
    k.nazwa != 'Górka Alicja'
);

-- zad 10.5.3
select nazwa from klienci 
where idklienta in(
    select k.idklienta from klienci k 
    join zamowienia z using(idklienta)
    join artykuly a using(idzamowienia)
    where a.idpudelka in (
        select a.idpudelka from zamowienia zam 
        join klienci kl using(idklienta)
        join artykuly a using(idzamowienia)
        where kl.miejscowosc = 'Katowice'
    ) and
    k.miejscowosc != 'Katowice'
);



-- zad 10.6.1
with najwieksza_liczba as (
    select idpudelka, sum(sztuk) as suma
    from zawartosc 
    group by idpudelka
    order by sum(sztuk) desc
    limit 1
)
select p.nazwa, najwiecej.liczba_czekoladek
from (select idpudelka, sum(sztuk) as liczba_czekoladek
from zawartosc 
group by idpudelka
having sum(sztuk) = (select suma from najwieksza_liczba)
order by liczba_czekoladek) najwiecej
    join pudelka p using(idpudelka);

-- zad 10.6.2
with najmniejsza_liczba as (
    select idpudelka, sum(sztuk) as suma
    from zawartosc 
    group by idpudelka
    order by sum(sztuk)
    limit 1
)
select p.nazwa, najmniej.liczba_czekoladek
from (select idpudelka, sum(sztuk) as liczba_czekoladek
        from zawartosc 
        group by idpudelka
        having sum(sztuk) = (select suma from najmniejsza_liczba)
        order by liczba_czekoladek) najmniej
    join pudelka p using(idpudelka);


-- zad 10.6.3
with srednia as (
    select avg(liczba_w_pudelku.liczba) sr_liczba
    from (select idpudelka, sum(sztuk) as liczba
        from zawartosc 
        group by idpudelka
        order by sum(sztuk)) liczba_w_pudelku
)
select idpudelka, sum(sztuk) as liczba_czekoladek
from zawartosc 
group by idpudelka
having sum(sztuk) > (select sr_liczba from srednia)
order by liczba_czekoladek;

-- zad 10.6.4
with najwieksza_liczba as (
    select idpudelka, sum(sztuk) as suma
    from zawartosc 
    group by idpudelka
    order by sum(sztuk) desc
    limit 1
),
najmniejsza_liczba as (
    select idpudelka, sum(sztuk) as suma
    from zawartosc 
    group by idpudelka
    order by sum(sztuk)
    limit 1
)
select p.nazwa, najwiecej.liczba_czekoladek
from (select idpudelka, sum(sztuk) as liczba_czekoladek
from zawartosc 
group by idpudelka
having sum(sztuk) = (select suma from najwieksza_liczba) or 
    sum(sztuk) = (select suma from najmniejsza_liczba)
order by liczba_czekoladek) najwiecej
    join pudelka p using(idpudelka);

-- zad 10.7
select(
    select count(*)
    from pudelka p2
    where p2.idpudelka <= p1.idpudelka) as liczba_porzadkowa,
    p1.idpudelka
from (
    select distinct idpudelka from pudelka) p1    
order by p1.idpudelka;


