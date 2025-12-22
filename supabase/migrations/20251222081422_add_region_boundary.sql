ALTER TABLE geo.regions
ADD COLUMN boundary geometry(MultiPolygon, 4326) NOT NULL;

CREATE INDEX regions_boundary_gist
ON geo.regions
USING GIST (boundary);

ALTER TABLE geo.regions
ADD CONSTRAINT chk_boundary_srid_4326
CHECK (ST_SRID(boundary) = 4326);

ALTER TABLE geo.regions
ADD CONSTRAINT chk_boundary_valid
CHECK (ST_IsValid(boundary));

ALTER TABLE geo.regions
ADD CONSTRAINT chk_boundary_not_empty
CHECK (NOT ST_IsEmpty(boundary));
