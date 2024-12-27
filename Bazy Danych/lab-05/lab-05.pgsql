-- 5.1.
select count(*) from czekoladki;

select count(*) from czekoladki
where nadzienie is not null;
select count(nadzienie) from czekoladki;

select idpudelka from zawartosc
group by idpudelka
order by SUM(sztuk) desc
limit 1;

select z.idpudelka, sum(z.sztuk) from zawartosc z
group by z.idpudelka
order by z.idpudelka;


select p.idpudelka, COALESCE(bez.liczba, 0)
from pudelka p
left join(select z.idpudelka, sum(z.sztuk) as liczba
        from zawartosc z
            join czekoladki c using(idczekoladki)
        where c.orzechy is null
        group by z.idpudelka
        order by z.idpudelka)
bez using(idpudelka);

select p.idpudelka, COALESCE(mleczna.liczba, 0)
from pudelka p
left join(select z.idpudelka, sum(z.sztuk) as liczba
        from zawartosc z
            join czekoladki c using(idczekoladki)
        where c.czekolada = 'mleczna'
        group by z.idpudelka
        order by z.idpudelka)
mleczna using(idpudelka);


-- 5.2
select z.idpudelka, sum(c.masa * z.sztuk) as "masa pudelka"
from zawartosc z
    join czekoladki c using(idczekoladki)
    group by z.idpudelka
    order by z.idpudelka;

select z.idpudelka, sum(z.sztuk * c.masa) as masa
from zawartosc z 
    join czekoladki c using(idczekoladki)
group by z.idpudelka
order by masa desc
limit 1;


-- 5.3
select datarealizacji, count(*) as "liczba zamówień"
from zamowienia
group by datarealizacji
order by datarealizacji;

select count(*) from zamowienia;

select sum( a.sztuk * p.cena) 
from artykuly a
    join pudelka p using(idpudelka);


-- 5.4
select idczekoladki
from zawartosc z 
group by z.idczekoladki
order by count(*) desc
limit 1;


-- 5.5
select extract(quarter from z.datarealizacji) as quarter, count(*)
from zamowienia z
group by quarter
order by quarter;

select extract(month from z.datarealizacji) as month, count(*)
from zamowienia z
group by month
order by month;


-- 5.6
select sum(p.stan * m.masa)
from pudelka p
join (select z.idpudelka, sum(c.masa * z.sztuk) as masa
        from zawartosc z
            join czekoladki c using(idczekoladki)
        group by z.idpudelka) m using(idpudelka);

select sum(p.stan * p.cena)
from pudelka p;

-- 5.7
select z.idpudelka, sum(c.koszt * z.sztuk) as "koszt produkcji"
from zawartosc z
    join czekoladki c using(idczekoladki) 
group by z.idpudelka
order by idpudelka;

select (p.cena - prod.koszt) as zysk
from pudelka p
    join (
        select z.idpudelka, sum(c.koszt * z.sztuk) as koszt
from zawartosc z
    join czekoladki c using(idczekoladki) 
group by z.idpudelka
order by idpudelka
    ) prod using(idpudelka);


select sum(art.sum * p.cena) as "zysk" 
from (
    select idpudelka, sum(sztuk) 
    from artykuly
    group by idpudelka
    ) art
join pudelka p using(idpudelka);


-- 5.8
select
    row_number() over (order by p.idpudelka asc) as lp,
    p.idpudelka
from pudelka p
order by p.idpudelka asc;


