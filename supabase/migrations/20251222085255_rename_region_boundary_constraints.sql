ALTER TABLE geo.regions
  DROP CONSTRAINT IF EXISTS chk_boundary_srid_4326,
  DROP CONSTRAINT IF EXISTS chk_boundary_valid,
  DROP CONSTRAINT IF EXISTS chk_boundary_not_empty;

ALTER TABLE geo.regions
  ADD CONSTRAINT "regions.chk_boundary_srid_4326"
    CHECK (ST_SRID(boundary) = 4326),

  ADD CONSTRAINT "regions.chk_boundary_valid"
    CHECK (ST_IsValid(boundary)),

  ADD CONSTRAINT "regions.chk_boundary_not_empty"
    CHECK (NOT ST_IsEmpty(boundary));
