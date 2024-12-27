select nazwa, date_part('YEAR', data_wydania)
from albumy
where (nazwa like 'S%') and (data_wydania > '2023-09-15');
select nazwa, extract(YEAR from data_wydania)
from albumy
where (nazwa like 'S%') and (data_wydania > '2023-09-15');


select idalbumu 
from albumy
where extract(YEAR from data_wydania) < 2015
except(
    select distinct idalbumu
    from utwory
    where dlugosc > 300;
)


select distinct idalbumu, nazwa 
from albumy
except(
    select distinct idalbumu 
    from utwory
    where idalbumu
    select distinct idutworu
    from oceny
) 

select idalbumu, nazwa
from albumy
    join (
    select idalbumu, count(idutworu) as liczba_utworow, avg(dlugosc)
    from utwory
    group by idalbumu
    having liczba_utworow > 4
    order by dlugosc desc
) dane using(idalbumu);




