create extension if not exists "citext" with schema "public";

create sequence "public"."users_id_seq";

create sequence "public"."users_tokens_id_seq";


  create table "public"."users" (
    "id" bigint not null default nextval('public.users_id_seq'::regclass),
    "email" public.citext not null,
    "hashed_password" character varying(255),
    "confirmed_at" timestamp(0) without time zone,
    "inserted_at" timestamp(0) without time zone not null,
    "updated_at" timestamp(0) without time zone not null
      );



  create table "public"."users_tokens" (
    "id" bigint not null default nextval('public.users_tokens_id_seq'::regclass),
    "user_id" bigint not null,
    "token" bytea not null,
    "context" character varying(255) not null,
    "sent_to" character varying(255),
    "authenticated_at" timestamp(0) without time zone,
    "inserted_at" timestamp(0) without time zone not null
      );


alter sequence "public"."users_id_seq" owned by "public"."users"."id";

alter sequence "public"."users_tokens_id_seq" owned by "public"."users_tokens"."id";

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);

CREATE UNIQUE INDEX users_pkey ON public.users USING btree (id);

CREATE UNIQUE INDEX users_tokens_context_token_index ON public.users_tokens USING btree (context, token);

CREATE UNIQUE INDEX users_tokens_pkey ON public.users_tokens USING btree (id);

CREATE INDEX users_tokens_user_id_index ON public.users_tokens USING btree (user_id);

alter table "public"."users" add constraint "users_pkey" PRIMARY KEY using index "users_pkey";

alter table "public"."users_tokens" add constraint "users_tokens_pkey" PRIMARY KEY using index "users_tokens_pkey";

alter table "public"."users_tokens" add constraint "users_tokens_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE not valid;

alter table "public"."users_tokens" validate constraint "users_tokens_user_id_fkey";

grant delete on table "public"."users" to "anon";

grant insert on table "public"."users" to "anon";

grant references on table "public"."users" to "anon";

grant select on table "public"."users" to "anon";

grant trigger on table "public"."users" to "anon";

grant truncate on table "public"."users" to "anon";

grant update on table "public"."users" to "anon";

grant delete on table "public"."users" to "authenticated";

grant insert on table "public"."users" to "authenticated";

grant references on table "public"."users" to "authenticated";

grant select on table "public"."users" to "authenticated";

grant trigger on table "public"."users" to "authenticated";

grant truncate on table "public"."users" to "authenticated";

grant update on table "public"."users" to "authenticated";

grant delete on table "public"."users" to "postgres";

grant insert on table "public"."users" to "postgres";

grant references on table "public"."users" to "postgres";

grant select on table "public"."users" to "postgres";

grant trigger on table "public"."users" to "postgres";

grant truncate on table "public"."users" to "postgres";

grant update on table "public"."users" to "postgres";

grant delete on table "public"."users" to "service_role";

grant insert on table "public"."users" to "service_role";

grant references on table "public"."users" to "service_role";

grant select on table "public"."users" to "service_role";

grant trigger on table "public"."users" to "service_role";

grant truncate on table "public"."users" to "service_role";

grant update on table "public"."users" to "service_role";

grant delete on table "public"."users_tokens" to "anon";

grant insert on table "public"."users_tokens" to "anon";

grant references on table "public"."users_tokens" to "anon";

grant select on table "public"."users_tokens" to "anon";

grant trigger on table "public"."users_tokens" to "anon";

grant truncate on table "public"."users_tokens" to "anon";

grant update on table "public"."users_tokens" to "anon";

grant delete on table "public"."users_tokens" to "authenticated";

grant insert on table "public"."users_tokens" to "authenticated";

grant references on table "public"."users_tokens" to "authenticated";

grant select on table "public"."users_tokens" to "authenticated";

grant trigger on table "public"."users_tokens" to "authenticated";

grant truncate on table "public"."users_tokens" to "authenticated";

grant update on table "public"."users_tokens" to "authenticated";

grant delete on table "public"."users_tokens" to "postgres";

grant insert on table "public"."users_tokens" to "postgres";

grant references on table "public"."users_tokens" to "postgres";

grant select on table "public"."users_tokens" to "postgres";

grant trigger on table "public"."users_tokens" to "postgres";

grant truncate on table "public"."users_tokens" to "postgres";

grant update on table "public"."users_tokens" to "postgres";

grant delete on table "public"."users_tokens" to "service_role";

grant insert on table "public"."users_tokens" to "service_role";

grant references on table "public"."users_tokens" to "service_role";

grant select on table "public"."users_tokens" to "service_role";

grant trigger on table "public"."users_tokens" to "service_role";

grant truncate on table "public"."users_tokens" to "service_role";

grant update on table "public"."users_tokens" to "service_role";
