alter table "iam"."profiles" drop constraint "chk_profiles_first_name_non_empty";

alter table "iam"."profiles" drop constraint "chk_profiles_last_name_non_empty";

alter table "iam"."profiles" alter column "first_name" drop not null;

alter table "iam"."profiles" alter column "last_name" drop not null;

alter table "iam"."profiles" add constraint "chk_names_present_when_completed" CHECK ((((first_name IS NULL) AND (last_name IS NULL)) OR ((length((first_name)::text) > 0) AND (length((last_name)::text) > 0)))) not valid;

alter table "iam"."profiles" validate constraint "chk_names_present_when_completed";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION iam.ensure_profile_on_confirm()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF OLD.confirmed_at IS NULL AND NEW.confirmed_at IS NOT NULL THEN
    INSERT INTO iam.profiles (user_id)
    VALUES (NEW.id)
    ON CONFLICT (user_id) DO NOTHING;
  END IF;

  RETURN NEW;
END;
$function$
;


