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



-- zad 11.4.1
create or replace function podwyzka()
as 
$$
begin 
    for c in select * from czekoladki
    loop 
        IF c.koszt < 0.20
            then c.koszt := c.koszt + 0.03
        elsif c.koszt between 0.20 and 0.29
            then c.koszt := c.koszt + 0.04
        else c.koszt := c.koszt + 0.05
        end if;
        for z in select * from zawartosc zaw join pudelka p using(idpudelka) 
        loop 
            where z.idczekoladki = c.idczekoladki
        end loop;
    end loop;
end;
$$ language plpgsql;