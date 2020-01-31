
podobna zasada jak przy

1. generowanie siatki punktow na caly rok z rodzieczoscia do kwadransu
2. generowanie wydarzen na siatce z parametrami:
    kiedy start:
    jak dlugo trwa

schedules
    start_timepoint
    duration_timepoint

stworzenie siatki xy
ograniczen na dany plan.

mozna planowac harmongoram dla dnia
lub dla godziny

dla godziny
name: godzina

CREATE TABLE "main"."units" (
    "unit_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name: workday
    multiplier: 8
    basic_unit: hour
);

factor, multiplier
Multiply by conversion ratio



CREATE TABLE "main"."grids" (
    "grid_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "x_start_timepoint_id" INTEGER NOT NULL,
    "x_stop_timepoint_id" INTEGER NOT NULL,
    "y_start_timepoint_id" INTEGER NOT NULL,
    "y_stop_timepoint_id" INTEGER NOT NULL,
    basic_unit: hour
);

grids
+ timerange_x
+ timerange_y

siatka tygodnia
timerange:
unit_x: day_week
start_x: 2
end_x: 1
-- warunek przeszukiwania ==
unit_y: week_year
start_y: 10
end_y: 14


CREATE TABLE "main"."grids" (
    "grid_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
-- day
    "x_unit" INTEGER NOT NULL,
-- 5/7
    "x_factor" INTEGER NOT NULL,
-- week
    "y_unit" INTEGER NOT NULL,
    "y_start_timepoint_id" INTEGER NOT NULL,
    "y_stop_timepoint_id" INTEGER NOT NULL,
    basic_unit: hour
);

CREATE TABLE "main"."grids_timepoints" (
    "grid_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "timepoint_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,


    basic_unit: hour
);


CREATE TABLE "main"."units" (
    "unit_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name: workday
    from_unit_name: day
    to_unit_name: hour
    factor: 8
);

to_value:


rzuty punktow:

grid

-- timepoint resolution

-- dotyczy okreslenia punktu w kalendarzu, aby moc rozliczac te same okresy, np tygodniowe, roczne, kwartalne
-- jesli timepoint jest ten sam, to mozna robic dzialania pomiedzy nimi, bo dotycza tego samego.
-- timepoint dla sumowanie rozliczen z tego samego dnia
-- siatka punktow
CREATE TABLE "main"."timepoints" (
   "timepoint_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   "parent_timepoint_id" INTEGER NOT NULL,
-- nazwa, moze dotyczyc kolejnego dnia w roku,
--- querter of hour/day/week
   "name" INTEGER NOT NULL,
-- 15 (minutes)
   "factor" INTEGER NOT NULL,
-- time range in minutes
   "value" INTEGER NOT NULL,
-- kolejny numer w siatce
   "no" INTEGER NOT NULL,
-- timestamp
   "time_from" INTEGER NOT NULL,
-- timestamp
   "time_to" INTEGER NOT NULL,
);

CREATE TABLE "main"."timerange" (
   "from_timepoint_id" INTEGER NOT NULL,
   "to_timepoint_id" INTEGER NOT NULL,
);




-- szukanie odpowiedniego
SELECT "main"."timepoints"."quart_hour" FROM "main"."timepoints"
-- generowanie punktow: wszytskie dni pracy konkretnego pracownika / miejsca pracy / grupy
-- generowanie punktow dla rocznego planu
-- nakladanie naplan, wydarzenia wewnetrzne i zewnetrzne
-- dla jednych to beda swieta, dla innych praca w nadgodziny



-- czas jest ten sam dla wszytskich tylko lokalizacja jest inna, i godzina inna jest pokazywana
-- dlatego timepoin jest niezalezny od lokalizacji i tym samym czasu swiatowego




-- tworzenie workspace dla czasu, klockow w ktore wmozna wpasowac zdarzenia.
-- timepoint dla godzin/cwiartek/dni
-- tworzenie mapy urpaszcza procedury, jesli godzimy sie na pojedyncze godziny lub polowki godzin, cwiartki, jako urlopy
-- cwiartki dnia, godzin, roku, miesiaca
-- to daje przewage przy organizacji czasu bo wiadomo z jaka czestoscia cos bylo zmieniane a nie co do minuty czy godziny.
-- wczesniej stworzona mapa dla calej, grupy, organizacji jest adaptowana do grafiku konkretnej osoby

-- mapowanie siatki wydarzen
CREATE TABLE "main"."schedules" (
   "schedule_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   "user_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   "timepoint_id" INTEGER NOT NULL,
   "time_to" INTEGER NOT NULL,
);


-- mapowanie siatki wydarzen na uzytkownika
CREATE TABLE "main"."schedules_users" (
    "schedule_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "saldo_id" INTEGER NOT NULL,

    PRIMARY KEY (timepoint_id, user_id),

    FOREIGN KEY (timepoint_id) REFERENCES timepoints (timepoint_id)
            ON DELETE CASCADE ON UPDATE NO ACTION,

    FOREIGN KEY (user_id) REFERENCES users (user_id)
            ON DELETE CASCADE ON UPDATE NO ACTION
);
