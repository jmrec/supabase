alter table "iam"."profiles" add column "user_id" bigint;

CREATE UNIQUE INDEX profiles_user_id_uk ON iam.profiles USING btree (user_id);

alter table "iam"."profiles" add constraint "profiles_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE not valid;

alter table "iam"."profiles" validate constraint "profiles_user_id_fkey";

alter table "iam"."profiles" add constraint "profiles_user_id_uk" UNIQUE using index "profiles_user_id_uk";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION iam.ensure_profile_on_confirm()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF OLD.confirmed_at IS NULL AND NEW.confirmed_at IS NOT NULL THEN
    INSERT INTO iam.profiles (user_id, first_name, last_name)
    VALUES (NEW.id, 'Pending', 'User')
    ON CONFLICT (user_id) DO NOTHING;
  END IF;

  RETURN NEW;
END;
$function$
;

CREATE TRIGGER trg_users_confirmed_profile AFTER UPDATE OF confirmed_at ON public.users FOR EACH ROW EXECUTE FUNCTION iam.ensure_profile_on_confirm();
