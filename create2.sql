
-- saldo_name: workday,
-- unit_name: WORK_DAY, WORK_WEEK, WORK_HOUR


--// if saldo_active = 1 then:
--// its converted and not more used, beacuse not existing, but for show, the history of changes, and leave the parent_id connection


CREATE TABLE "main"."user" (
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




CREATE TABLE "main"."transaction" (
   "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,

   "sender_user_id" INTEGER NOT NULL,
   "recipient_user_id" INTEGER NOT NULL,

   "sender_account_id" INTEGER NOT NULL,
   "recipient_account_id" INTEGER NOT NULL,

   "calculation_id" INTEGER NOT NULL,
   "description" TEXT NOT NULL
);

-- HR, BOSS, WORKER1, WORKER2


-- transakcje miedzy kontami i uzytkownikami
CREATE TABLE "main"."transfer" (
   "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,

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
CREATE TABLE "main"."account" (
   "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   "parent_id" INTEGER NOT NULL,

-- ASSIGNED, AVAILABLE, USED, EXPIRED, PAYOUT
   "name" TEXT NOT NULL,
   "description" TEXT NOT NULL


-- CONTRACT, ANNUAL, EXPIRED, REST
   "saldo_name" TEXT NOT NULL,
-- Hourly, Every 8 Hours, Daily, Every second day, Weekly, Mothly, Quarterly, Semiannually, Annually
   "saldo_period" TEXT NOT NULL,
-- timestamp
   "saldo_date_from" INTEGER NOT NULL,
-- timestamp
   "saldo_date_to" INTEGER NOT NULL,
-- -1 / +1
   "saldo_sign" INTEGER NOT NULL DEFAULT (1),

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
CREATE TABLE "main"."amount" (
   "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   "parent_id" INTEGER NOT NULL,
   "localisation_id" INTEGER NOT NULL,

   "description" TEXT NOT NULL

-- timestamp
   "date" INTEGER NOT NULL,
-- created / deleted /mirror for another unit
   "status" INTEGER NOT NULL DEFAULT (1),

-- Dla wymiany walut, to moze byc przydatne rowniez, na ktory dzien byl kurs brany pod uwage

-- rok, dla ktorego jest jednostka aktualna
   "unit_year" INTEGER NOT NULL,
-- dzien roku, tydzien roku, miesiac roku
   "unit_no" INTEGER NOT NULL,
-- WORKDAY, WORKWEEK, WORKMONTH
   "unit_name" TEXT NOT NULL,
-- 1, 7 , 31, 1000 000
   "unit_factor" INTEGER NOT NULL DEFAULT (1),
-- wartosc z przecinkami, float, +/-
   "unit_value" REAL NOT NULL DEFAULT (1),

);


-- zapytanie, pobierz sume wszystkich pobranych urlopow z rocznego, gdzie jednsotka to workday
-- TAGI: saldo_name: ANNUAL, USED (saldo_sign: -1), unit_name: WORKDAY, ABS, SUM

-- localisation PL_pl, De_de, if different countries
CREATE TABLE "main"."account" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,

    "language" TEXT NOT NULL,

    "country" TEXT NOT NULL,
    "region" TEXT NOT NULL,

);
