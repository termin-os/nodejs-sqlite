
-- saldo_name: workday,
-- unit_name: WORK_DAY, WORK_WEEK, WORK_HOUR


--// if saldo_active = 1 then:
--// its converted and not more used, beacuse not existing, but for show, the history of changes, and leave the parent_id connection


CREATE TABLE "main"."users" (
   "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,

-- details about user
   "description" TEXT NOT NULL

   "first_name" TEXT NOT NULL,
   "last_name" TEXT NOT NULL,
   "email" TEXT NOT NULL,

   "username" TEXT NOT NULL,
   "password" TEXT NOT NULL,

-- timestamp
  "date" INTEGER NOT NULL,
-- created / deleted / suspended / in review / blocked
  "status" INTEGER NOT NULL DEFAULT (1),


);

-- tworzenie kolejkki transferow, planowanie terminow transferow, np jesli ktos chce zlecic, albo system ma wykonac o okreslonej porze
CREATE TABLE "main"."orders" (
   "order_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,

   "sender_user_id" INTEGER NOT NULL,
   "recipient_user_id" INTEGER NOT NULL,

   "before_account_id" INTEGER NOT NULL,
   "after_account_id" INTEGER NOT NULL,

   "amount_id" INTEGER NOT NULL,
   "description" TEXT NOT NULL

-- if date not exist, do immediately
-- timestamp
  "execute_date" INTEGER NOT NULL,

-- timestamp
  "status_date" INTEGER NOT NULL,
-- created / deleted /mirror for another unit
  "status" INTEGER NOT NULL DEFAULT (1),
);

-- HR, BOSS, WORKER1, WORKER2
-- transakcje miedzy kontami i uzytkownikami
CREATE TABLE "main"."transfers" (
   "transfer_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,

   "sender_user_id" INTEGER NOT NULL,
   "recipient_user_id" INTEGER NOT NULL,

   "before_account_id" INTEGER NOT NULL,
   "after_account_id" INTEGER NOT NULL,

   "amount_id" INTEGER NOT NULL,
   "description" TEXT NOT NULL
);

-- EXAMPLE
-- from ASSIGNED to AVAILABLE
-- from BOSS to WORKER, HR to WORKER
-- question for special holiday, ASSIGNED = WORKER -> BOSS
-- approve holiday, AVAILABLE = BOSS -> WORKER

-- holidaybank
-- Konto dla urlopow to samo jak pieniadze


-- Definicje kont, jakie beda uzywane
-- schemat procesow, jakie zachodza w firmie, to samo dla ticketow: PROBLEM->SOLUTION: QUESTION->ANSWER
CREATE TABLE "main"."accounts" (
   "account_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   "parent_account_id" INTEGER NOT NULL,

-- ASSIGNED, AVAILABLE, USED, EXPIRED, PAYOUT
   "name" TEXT NOT NULL,
   "description" TEXT NOT NULL

-- CONTRACT, ANNUAL, EXPIRED, REST
   "saldo_name" TEXT NOT NULL,
-- Hourly, Every 8 Hours, Daily, Every second day, Weekly, Mothly, Quarterly, Semiannually, Annually
   "saldo_period" TEXT NOT NULL,
-- -1 / +1
   "saldo_sign" INTEGER NOT NULL DEFAULT (1),

---- timestamp
--   "saldo_date_from" INTEGER NOT NULL,
---- timestamp
--   "saldo_date_to" INTEGER NOT NULL,

   "timepoint_id" INTEGER NOT NULL,
}


-- konieczne stworzenie subkonta dla kazdego pracownika, gdzie w ciagu dnia / tygodnia / roku beda okreslane limity
-- w ten sposob, kazdy w cyklach bedzie mial ograniczone ilosci

-- dzieki wyslaniu od do, mozna ustalic limity na urlopy, dla kazdego usera oddzielnie,
-- sender_id, to moze byc subkonto usera, gdzie sa podane podstawowe ograniczenia

-- przechowuje dla kazdego usera dane o jego ograniczeniach

-- zasada przy tworzeniu rekordow
-- kazdy rekord jest unikalny i moze byc jedynie dodany, nie mozna usuwac
-- jesli zostal popelniony blad, drugi wiersz powinien pozwolic na usuniecie tego bledu
-- k
CREATE TABLE "main"."amounts" (
   "amount_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   "parent_amount_id" INTEGER NOT NULL,

-- w przypadku delgeacji, czy grupy roznych ludzi, gdzie lokalizacja ma znaczenia, swieta lokalne
   "localisation_id" INTEGER NOT NULL,
   "description" TEXT NOT NULL

-- timestamp
   "timestamp" INTEGER NOT NULL,
-- created / deleted /mirror for another unit
   "status" INTEGER NOT NULL DEFAULT (1),

-- Dla wymiany walut, to moze byc przydatne rowniez, na ktory dzien byl kurs brany pod uwage

-- rok, dla ktorego jest jednostka aktualna
--   "unit_year" INTEGER NOT NULL,
---- dzien roku, tydzien roku, miesiac roku
--   "unit_no" INTEGER NOT NULL,
   "timepoint_id" INTEGER NOT NULL,

-- WORKDAY, WORKWEEK, WORKMONTH
   "unit_name" TEXT NOT NULL,
-- 1, 7 , 31, 1000 000, przemnozenie przez aktualna wartosc
   "unit_factor" INTEGER NOT NULL DEFAULT (1),
-- wartosc z przecinkami, float, +/-
   "unit_value" REAL NOT NULL DEFAULT (1),
);


-- timepoint resolution

-- dotyczy okreslenia punktu w kalendarzu, aby moc rozliczac te same okresy, np tygodniowe, roczne, kwartalne
-- jesli timepoint jest ten sam, to mozna robic dzialania pomiedzy nimi, bo dotycza tego samego.
-- timepoint dla sumowanie rozliczen z tego samego dnia
-- siatka punktow
CREATE TABLE "main"."timepoints" (
   "timepoint_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
-- nazwa, moze dotyczyc kolejnego dnia w roku,
   "name" TEXT NOT NULL,
-- rok, dla ktorego jest jednostka aktualna
   "year" INTEGER NOT NULL,
-- kwartal w roku
  "querter_year" INTEGER NOT NULL,
-- miesiac w roku
   "month_year" INTEGER NOT NULL,
-- dzien w roku
   "day_year" INTEGER NOT NULL,
-- dzien roku, tydzien roku, miesiac roku
   "day_week" INTEGER NOT NULL,
-- dzien roku, tydzien roku, miesiac roku
   "week_year" INTEGER NOT NULL,
--- dzien miesiaca
   "day_month" INTEGER NOT NULL,
--- godzina dnia
   "hour_day" INTEGER NOT NULL,
--- querter of hour
   "quart_day" INTEGER NOT NULL,
--- querter of hour
   "quart_hour" INTEGER NOT NULL,
-- timestamp
   "time_from" INTEGER NOT NULL,
-- timestamp
   "time_to" INTEGER NOT NULL,
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

-- zapytanie, pobierz sume wszystkich pobranych urlopow z rocznego, gdzie jednsotka to workday
-- TAGI: saldo_name: ANNUAL, USED (saldo_sign: -1), unit_name: WORKDAY, ABS, SUM

-- localisation PL_pl, De_de, if different countries
CREATE TABLE "main"."localisations" (
    "localisation_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "language" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "region" TEXT NOT NULL,
);


-- Jak stworzyc blokade na rachunku
-- Jak stworzyc blokade czasowa i potem automatycznie powraca, np nie mozna pobierac urlopu w czasie gdy jest sie chorym
