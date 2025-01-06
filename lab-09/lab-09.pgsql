CREATE TABLE kwiaciarnia.historia (
    idzamowienia integer PRIMARY KEY, 
    idklienta character varying(10),
    idkompozycji character(5),
    cena numeric(10,2),
    termin date
);

CREATE TABLE kwiaciarnia.klienci(
    idklienta character varying(10) PRIMARY KEY,
    haslo character varying(10) NOT NULL,
    nazwa character varying(40) NOT NULL,
    miasto character varying(40) NOT NULL,
    kod character varying(6) NOT NULL,
    adres character varying(40) NOT NULL,
    email character varying(40),
    telefon character varying(16) NOT NULL,
    fax character(16),
    nip character(13),
    regon character(9),
    CONSTRAINT haslo1 check (length(haslo) >= 4)
);


CREATE TABLE kwiaciarnia.zamowienia(
    idzamowienia integer PRIMARY KEY, 
    idklienta character varying(10)  not null REFERENCES kwiaciarnia.klienci,
    idodbiorcy serial REFERENCES kwiaciarnia.odbiorcy,
    idkompozycji character(5) REFERENCES kwiaciarnia.kompozycje,
    termin date not null,
    cena numeric(10, 2),
    zaplacone boolean,
    uwagi character varying(200)
);

CREATE TABLE kwiaciarnia.odbiorcy(
    idodbiorcy serial primary key,
    nazwa character varying(40) NOT NULL,
    miasto character varying(40) not null,
    kod character varying(6) NOT NULL,
    adres character varying(40) NOT NULL
);  

CREATE TABLE kwiaciarnia.kompozycje(
    idkompozycji character(5) primary key,
    nazwa character varying(40) NOT NULL,
    opis character varying(100),
    cena numeric(10, 2),
    minimum integer,
    stan integer,
    CONSTRAINT cena_min CHECK ((cena >= 40.00))
);

CREATE TABLE kwiaciarnia.zapotrzebowanie(
    idkompozycji character(5) primary key REFERENCES kwiaciarnia.kompozycje,
    data date
);

-- CREATE SEQUENCE kwiaciarnia.odbiorcy_idodbiorcy_seq
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1;


