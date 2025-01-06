CREATE SCHEMA IF NOT EXISTS firma;

CREATE TABLE IF NOT EXISTS firma.dzialy(
    iddzialu character(5) PRIMARY KEY,
    nazwa character VARYING(32) NOT NULL,
    lokalizacja character VARYING(24) NOT NULL,
    kierownik integer 
);

CREATE TABLE IF NOT EXISTS firma.pracownicy(
    idpracownika INTEGER PRIMARY KEY,
    nazwisko CHARACTER VARYING(32) not null,
    imie character VARYING(16) not null,
    dataUrodzenia date not null,
    dzial character(5) REFERENCES firma.dzialy(iddzialu) ON DELETE SET NULL,
    stanowisko character varying(24),
    pobory numeric(10, 2)
);



alter table firma.dzialy 
add constraint dzial_fk foreign key(kierownik) 
references firma.pracownicy(idpracownika) 
on update cascade deferrable;

