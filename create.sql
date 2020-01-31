

--CREATE TABLE "main"."application" (
--    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
--    "name" TEXT NOT NULL,
--    "date_from" TEXT NOT NULL,
--    "date_to" TEXT NOT NULL,
--    "saldo" TEXT NOT NULL,
--    "unit_factor" INTEGER NOT NULL DEFAULT (1),
--    "unit_name" TEXT NOT NULL,
--    "unit_value" INTEGER NOT NULL DEFAULT (1)
--);


CREATE TABLE "main"."transaction" (
   "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   "name" TEXT NOT NULL,
   "date_from" TEXT NOT NULL,
   "date_to" TEXT NOT NULL,
   "sender_id" INTEGER NOT NULL,
   "sender_account_id" INTEGER NOT NULL,
   "sender_saldo" TEXT NOT NULL,
   "receiver_id" INTEGER NOT NULL,
   "receiver_account_id" INTEGER NOT NULL,
   "receiver_saldo" TEXT NOT NULL,
   "sign" INTEGER NOT NULL DEFAULT (1),
   "unit_factor" INTEGER NOT NULL DEFAULT (1),
   "unit_name" TEXT NOT NULL,
   "unit_value" INTEGER NOT NULL DEFAULT (1)
);


CREATE TABLE "main"."user" (
   "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   "name" TEXT NOT NULL,
   "status" TEXT NOT NULL,
   "date" TEXT NOT NULL,
   "sign" INTEGER NOT NULL DEFAULT (1),
   "unit_factor" INTEGER NOT NULL DEFAULT (1),
   "unit_name" TEXT NOT NULL,
   "unit_value" INTEGER NOT NULL DEFAULT (1)
);

CREATE TABLE "main"."saldo" (
   "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   "name" TEXT NOT NULL,
   "date_from" TEXT NOT NULL,
   "date_to" TEXT NOT NULL,
   "sender_id" INTEGER NOT NULL,
   "sender_saldo" TEXT NOT NULL,
   "receiver_id" INTEGER NOT NULL,
   "receiver_saldo" TEXT NOT NULL,
   "sign" INTEGER NOT NULL DEFAULT (1),
   "unit_factor" INTEGER NOT NULL DEFAULT (1),
   "unit_name" TEXT NOT NULL,
   "unit_value" INTEGER NOT NULL DEFAULT (1)
);
-- CREATE system user_id



CREATE TABLE "main"."transactions" (
   "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,

   "sender_id" INTEGER NOT NULL,
   "recipient_id" INTEGER NOT NULL,

   "saldo_parent_id" INTEGER NOT NULL DEFAULT (1),
   "saldo_active" INTEGER NOT NULL DEFAULT (1),

   "saldo_name" TEXT NOT NULL,
   "saldo_date_from" INTEGER NOT NULL,
   "saldo_date_to" INTEGER NOT NULL,
   "saldo_sign" INTEGER NOT NULL DEFAULT (1),

   "unit_name" TEXT NOT NULL,
   "unit_factor" INTEGER NOT NULL DEFAULT (1),
   "unit_value" REAL NOT NULL DEFAULT (1),

   "description" TEXT NOT NULL
);

--
-- saldo_name: workday,
-- unit_name: WORK_DAY, WORK_WEEK, WORK_HOUR


--// if saldo_active = 1 then:
--// its converted and not more used, beacuse not existing, but for show, the history of changes, and leave the parent_id connection
