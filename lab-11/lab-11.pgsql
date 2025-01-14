-- zad 11.1.1
create or replace function masaPudelka(in id character(4))
returns integer as 
$$
declare 
    wynik integer;
begin
    select sum(z.sztuk * c.masa) into wynik
    from zawartosc z 
        join czekoladki c using(idczekoladki)
    where z.idpudelka = id;
    return wynik;
end;
$$
language plpgsql;

select masaPudelka('alls');

-- zad 11.1.2
create or replace function liczbaCzekoladek(in arg1 character(4))
returns integer as
$$
DECLARE wynik integer;
BEGIN
    select sum(sztuk) into wynik
    from zawartosc 
    where idpudelka = arg1;
    
    return wynik;
END;
$$ language plpgsql;

select liczbaCzekoladek('alls');


-- zad 11.2.1
create or replace function zysk(in arg1 character(4))
returns numeric(10, 2) as 
$$
    DECLARE
        wynik numeric(10, 2);
    BEGIN
        select p.cena - 0.9 - sum(z.sztuk * c.koszt) into wynik
        from zawartosc z
            join pudelka p using(idpudelka) 
            join czekoladki c using(idczekoladki)
        where idpudelka = arg1
        group by idpudelka, cena;
        return wynik;
    END;
$$ language plpgsql;

select zysk('alls');

-- zad 11.2.2
select sum(zysk(a.idpudelka) * a.sztuk)
from zamowienia z 
    join artykuly a using(idzamowienia)
where z.datarealizacji = '2013-11-12';


-- zad 11.3.1
create or replace function sumaZamowien(in arg1 integer)
returns numeric(10, 2) as 
$$
    declare 
        wynik numeric(10, 2);
    begin
        select sum(a.sztuk * p.cena) into wynik
        from zamowienia z 
            join artykuly a using(idzamowienia)
            join pudelka p using(idpudelka)
        where idklienta = arg1;
        return wynik;
    end;
$$ language plpgsql;

select sumaZamowien(1);

-- zad 11.3.2
create or replace function rabat(in arg1 integer)
returns integer as
$$
DECLARE wynik integer;
DECLARE wartoscZamowien integer;
BEGIN
    wartoscZamowien := sumaZamowien(arg1);
    if wartoscZamowien between 101 and 200 
        then wynik := 4; 
    elsif wartoscZamowien between 201 and 400
        then wynik := 7;
    elsif wartoscZamowien > 400 
        then wynik := 8;
    else wynik := 0;
    end if; 
    return wynik;
END;
$$ language plpgsql;

select rabat(1);



-- zad 11.4
create or replace function podwyzka()
returns void as 
$$
declare 
    zmiana numeric(7,2);
    c record;
    z record;
begin 
    for c in select * from czekoladki loop 
        IF c.koszt < 0.20 then 
            zmiana := 0.03;
        elsif c.koszt between 0.20 and 0.29 then 
            zmiana := 0.04;
        else zmiana := 0.05;
        end if;
 
        UPDATE czekoladki 
        set koszt = koszt + zmiana 
        where idczekoladki = c.idczekoladki;
        
        for z in select * from zawartosc where idczekoladki = c.idczekoladki loop 
            update pudelka
            set cena = cena + zmiana * z.sztuk
            where idpudelka = z.idpudelka;
        end loop;
    end loop;
end;
$$ language plpgsql;

select podwyzka();

-- zad 11.5
create or replace function obnizka()
returns void as 
$$
declare 
    zmiana numeric(7,2);
    c record;
    z record;
begin 
    for c in select * from czekoladki loop 
        IF c.koszt < 0.24 then 
            zmiana := 0.03;
        elsif c.koszt between 0.24 and 0.33 then 
            zmiana := 0.04;
        else zmiana := 0.05;
        end if;
 
        UPDATE czekoladki 
        set koszt = koszt - zmiana 
        where idczekoladki = c.idczekoladki;
        
        for z in select * from zawartosc where idczekoladki = c.idczekoladki loop 
            update pudelka
            set cena = cena - zmiana * z.sztuk
            where idpudelka = z.idpudelka;
        end loop;
    end loop;
end;
$$ language plpgsql;
select obnizka();
select * from pudelka;

-- zad 11.6.1
create or replace function zamowieniaKlienta(in arg1 integer)
returns table(
    r_idzamowienia integer,
    r_idpudelka character(4),
    r_datarealizacji date
) as
$$
BEGIN
    return query select z.idzamowienia, a.idpudelka, z.datarealizacji
    from zamowienia z 
        join artykuly a using(idzamowienia)
    where z.idklienta = arg1;

END;
$$ language plpgsql;

select * from zamowieniaKlienta(1);

-- zad 11.6.2
create or replace function getClientsByCity(in city varchar)
returns table(
    r_nazwa varchar,
    r_adres varchar
) as
$$
BEGIN
    return query select nazwa::varchar, (ulica || ', ' || miejscowosc)::varchar from klienci 
    where miejscowosc = city;
END;
$$ language plpgsql;

select * from getClientsByCity('Katowice');

-- zad 11.7
set search_path to kwiaciarnia;

create or replace function rabatKwiaciarnia(in arg1 varchar)
returns integer as 
$$
DECLARE
    sumarycznaCena numeric(10,2);
    sumarycznaCena1 numeric(10,2);
    sumarycznaCena2 numeric(10,2);
    rabat integer;
BEGIN
    select COALESCE(sum(cena), 0) into sumarycznaCena1
    from historia
    where idklienta = arg1 and termin > now() - interval '7 days';

    select COALESCE(sum(cena), 0) into sumarycznaCena2
    from zamowienia
    where idklienta = arg1;

    sumarycznaCena := sumarycznaCena1 + sumarycznaCena2;

    if sumarycznaCena > 0 and sumarycznaCena < 100 then 
        rabat := 5;
    elsif sumarycznaCena between 101 and 400 THEN
        rabat := 10;
    elsif sumarycznaCena between 401 and 700 THEN
        rabat := 15;     
    elsif sumarycznaCena > 700 then 
        rabat := 20;
    else rabat := 0;
    end if;

    return rabat;
END;
$$ language plpgsql; 

select rabatKwiaciarnia('karolina');

