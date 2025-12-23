drop index if exists "geo"."regions_boundary_gist";

-- alter table "geo"."barangays" alter column "center" drop expression;

CREATE INDEX regions_boundary_idx ON geo.regions USING gist (boundary);

-- drop trigger if exists "trg_set_outage_report_barangay" on "ops"."outage_reports";

alter table "ops"."announcements" drop constraint "announcements_author_id_fkey";

alter table "ops"."assignments" drop constraint "chk_assignments_completion_timeline";

alter table "ops"."outage_updates" drop constraint "outage_updates_user_id_fkey";

-- drop function if exists "ops"."set_outage_report_barangay"();

drop index if exists "ops"."announcements_author_id_idx";

drop index if exists "ops"."outage_updates_user_id_idx";

alter table "ops"."announcements" drop column "author_id";

alter table "ops"."announcements" add column "created_by" bigint not null;

alter table "ops"."announcements" add column "updated_by" bigint not null;

alter table "ops"."assignments" drop column "assigned_at";

alter table "ops"."assignments" drop column "completed_at";

alter table "ops"."assignments" drop column "is_active";

alter table "ops"."assignments" add column "created_by" bigint not null;

alter table "ops"."assignments" add column "terminated_at" timestamp with time zone;

alter table "ops"."assignments" add column "updated_by" bigint not null;

alter table "ops"."outage_updates" drop column "user_id";

alter table "ops"."outage_updates" add column "created_by" bigint not null;

alter table "ops"."outage_updates" add column "updated_by" bigint not null;

alter table "ops"."outages" add column "created_by" bigint not null;

alter table "ops"."outages" add column "updated_by" bigint not null;

CREATE INDEX announcements_created_by_idx ON ops.announcements USING btree (created_by);

CREATE INDEX announcements_updated_by_idx ON ops.announcements USING btree (updated_by);

CREATE INDEX assignments_created_by_idx ON ops.assignments USING btree (created_by);

CREATE INDEX assignments_updated_by_idx ON ops.assignments USING btree (updated_by);

CREATE INDEX outage_updates_created_by_idx ON ops.outage_updates USING btree (created_by);

CREATE INDEX outage_updates_updated_by_idx ON ops.outage_updates USING btree (updated_by);

CREATE INDEX outages_created_by_idx ON ops.outages USING btree (created_by);

CREATE INDEX outages_updated_by_idx ON ops.outages USING btree (updated_by);

CREATE INDEX outages_confirmed_by_idx ON ops.outages USING btree (confirmed_by);

CREATE INDEX outages_resolved_by_idx ON ops.outages USING btree (resolved_by);

CREATE INDEX provinces_region_id_idx ON geo.provinces USING btree (region_id);

alter table "ops"."announcements" add constraint "announcements_created_by_fkey" FOREIGN KEY (created_by) REFERENCES iam.profiles(id) ON DELETE RESTRICT not valid;

alter table "ops"."announcements" validate constraint "announcements_created_by_fkey";

alter table "ops"."announcements" add constraint "announcements_updated_by_fkey" FOREIGN KEY (updated_by) REFERENCES iam.profiles(id) ON DELETE RESTRICT not valid;

alter table "ops"."announcements" validate constraint "announcements_updated_by_fkey";

alter table "ops"."assignments" add constraint "assignments_created_by_fkey" FOREIGN KEY (created_by) REFERENCES iam.profiles(id) ON DELETE RESTRICT not valid;

alter table "ops"."assignments" validate constraint "assignments_created_by_fkey";

alter table "ops"."assignments" add constraint "assignments_updated_by_fkey" FOREIGN KEY (updated_by) REFERENCES iam.profiles(id) ON DELETE RESTRICT not valid;

alter table "ops"."assignments" validate constraint "assignments_updated_by_fkey";

alter table "ops"."assignments" add constraint "chk_assignments_termination_timeline" CHECK (((terminated_at IS NULL) OR (terminated_at >= created_at))) not valid;

alter table "ops"."assignments" validate constraint "chk_assignments_termination_timeline";

alter table "ops"."outage_updates" add constraint "outage_updates_created_by_fkey" FOREIGN KEY (created_by) REFERENCES iam.profiles(id) ON DELETE RESTRICT not valid;

alter table "ops"."outage_updates" validate constraint "outage_updates_created_by_fkey";

alter table "ops"."outage_updates" add constraint "outage_updates_updated_by_fkey" FOREIGN KEY (updated_by) REFERENCES iam.profiles(id) ON DELETE RESTRICT not valid;

alter table "ops"."outage_updates" validate constraint "outage_updates_updated_by_fkey";

alter table "ops"."outages" add constraint "outages_created_by_fkey" FOREIGN KEY (created_by) REFERENCES iam.profiles(id) ON DELETE RESTRICT not valid;

alter table "ops"."outages" validate constraint "outages_created_by_fkey";

alter table "ops"."outages" add constraint "outages_updated_by_fkey" FOREIGN KEY (updated_by) REFERENCES iam.profiles(id) ON DELETE RESTRICT not valid;

alter table "ops"."outages" validate constraint "outages_updated_by_fkey";

alter table "iam"."api_keys" drop constraint "api_keys_created_by_fkey";

alter table "iam"."api_keys" add column "updated_by" bigint not null;

CREATE INDEX api_keys_created_by_idx ON iam.api_keys USING btree (created_by);

CREATE INDEX api_keys_updated_by_idx ON iam.api_keys USING btree (updated_by);

CREATE UNIQUE INDEX uk_active_assignment ON ops.assignments(outage_id, crew_id) WHERE terminated_at IS NULL;

alter table "iam"."api_keys" add constraint "api_keys_updated_by_fkey" FOREIGN KEY (updated_by) REFERENCES iam.profiles(id) ON DELETE RESTRICT not valid;

alter table "iam"."api_keys" validate constraint "api_keys_updated_by_fkey";

alter table "iam"."api_keys" add constraint "api_keys_created_by_fkey" FOREIGN KEY (created_by) REFERENCES iam.profiles(id) ON DELETE RESTRICT not valid;

alter table "iam"."api_keys" validate constraint "api_keys_created_by_fkey";


