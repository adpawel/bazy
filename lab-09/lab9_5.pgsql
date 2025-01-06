select * from firma.dzialy;
select * from firma.pracownicy;

select nazwisko, extract(year from AGE(dataUrodzenia)) as wiek, pobory
from firma.pracownicy
order by pobory, nazwisko;

select nazwisko, imie, dataUrodzenia, stanowisko, dzial, pobory
from firma.pracownicy
where stanowisko in ('robotnik', 'anaityk') AND
    pobory > 2000;

select nazwisko, imie 
from firma.pracownicy
where pobory > (
    select pobory 
    from firma.pracownicy
    where imie = 'Adam' AND
        nazwisko = 'Kowalik'
    limit 1
);

UPDATE firma.pracownicy
SET pobory = pobory * 1.1
where stanowisko = 'robotnik';

select stanowisko, count(*) as liczba, sum(pobory) / count(*) as sredni_pobor
from firma.pracownicy 
group by stanowisko
having stanowisko != 'kierownik';

