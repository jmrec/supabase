drop index if exists "iam"."profiles_user_id_idx";

alter table "iam"."profiles" drop column "user_id";