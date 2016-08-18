-- PSEUDOCODE Check:
-- Create a trigger
-- Before a user inserts data in a table
-- Check whether Foreign key exists in Tables
-- If it exists in all
    -- INSERT
-- If it doesn't exist in all
    -- STOP - error

CREATE OR REPLACE FUNCTION Checking() RETURNS TRIGGER AS $Checker$
-- Function that checks wheter the Data to be created exists in RPG
-- Returns a trigger before insert
    BEGIN
        -- If new data doesnt match the existing raise an exception
        IF (SELECT MBPG FROM Holding WHERE MBPG = NEW.MBPG) IS NULL 
        OR 
        (SELECT DISTINCT MBPG FROM Crop WHERE MBPG = NEW.MBPG) IS NULL 
        OR 
        (SELECT cropCode FROM Crop WHERE CropCode = NEW.CropCode) IS NULL THEN
            RAISE EXCEPTION 'That crop record doesnt exist in the database.';
        END IF;
        return NEW;
    END;
$Checker$ LANGUAGE plpgsql;

CREATE TRIGGER Checker BEFORE INSERT OR UPDATE ON RS_AgrParcel
    FOR EACH ROW EXECUTE PROCEDURE Checking();

-- calculate area and store it in the column digitisedArea

CREATE OR REPLACE FUNCTION area_new() RETURNS trigger AS $BODY$
    BEGIN
        NEW.digitisedArea = ST_AREA(NEW.geometry);
        RETURN NEW;
END;
$BODY$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER area_calculate_RS_FarBlock BEFORE INSERT OR UPDATE ON RS_FarBlock
    FOR EACH ROW EXECUTE PROCEDURE area_new();

CREATE TRIGGER area_calculate_RS_AgrParcel BEFORE INSERT OR UPDATE ON RS_AgrParcel
    FOR EACH ROW EXECUTE PROCEDURE area_new();

CREATE TRIGGER area_calculate_RS_PhyBlock BEFORE INSERT OR UPDATE ON RS_PhyBlock
    FOR EACH ROW EXECUTE PROCEDURE area_new();

CREATE TRIGGER area_calculate_RS_SubParcel BEFORE INSERT OR UPDATE ON RS_SubParcel
    FOR EACH ROW EXECUTE PROCEDURE area_new();

CREATE TRIGGER area_calculate_RS_TopoBlock BEFORE INSERT OR UPDATE ON RS_TopoBlock
    FOR EACH ROW EXECUTE PROCEDURE area_new();

-- Function & trigger that check wheter the geometry is overlaping itself

CREATE OR REPLACE FUNCTION overlapCheck() RETURNS TRIGGER AS $$
	DECLARE
	geometry RECORD;
    BEGIN
    
	FOR geometry IN EXECUTE format('SELECT * FROM %I', TG_TABLE_NAME) LOOP
		IF (SELECT ST_Overlaps(st_buffer(NEW.geometry, -0.0000001), geometry.geometry)) THEN
			RAISE EXCEPTION 'Overlaps are not allowed';
		END IF;
	END LOOP;
	
        return NEW;
    END
$$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER overlap_RS_FarBlock BEFORE INSERT OR UPDATE ON RS_FarBlock
    FOR EACH ROW EXECUTE PROCEDURE overlapCheck();

CREATE TRIGGER overlap_RS_AgrParcel BEFORE INSERT OR UPDATE ON RS_AgrParcel
    FOR EACH ROW EXECUTE PROCEDURE overlapCheck();

CREATE TRIGGER overlap_RS_PhyBlock BEFORE INSERT OR UPDATE ON RS_PhyBlock
    FOR EACH ROW EXECUTE PROCEDURE overlapCheck();

CREATE TRIGGER overlap_RS_TopoBlock BEFORE INSERT OR UPDATE ON RS_TopoBlock
    FOR EACH ROW EXECUTE PROCEDURE overlapCheck();

CREATE TRIGGER overlap_RS_SubParcel BEFORE INSERT OR UPDATE ON RS_SubParcel
    FOR EACH ROW EXECUTE PROCEDURE overlapCheck();

-- trigger & function on subparcel to check if it is contained within its Parcel

CREATE OR REPLACE FUNCTION coverCheck() RETURNS TRIGGER AS $$
	DECLARE
	a_row RECORD;
    BEGIN
    -- Buffers created because of precision errors
    -- If number of number of subparcels contained within a parcel is different from 1 (0 if none, or 2 or more)
	IF (SELECT count(*) FROM RS_Parcel WHERE ST_Contains(st_buffer(geometry, 0.0000001), NEW.geometry)) <> 1 THEN
		RAISE EXCEPTION 'SubParcels must be contained within one existing Parcel';
	END IF;
    -- if the subparcel is in a different parcel
	IF (SELECT ST_Contains(st_buffer(geometry, 0.0000001), NEW.geometry) FROM RS_Parcel WHERE numberz = NEW.numberz) IS FALSE THEN
		RAISE EXCEPTION 'The Sub Parcel must be contained in the parcel number %', NEW.numberz;
	END IF;
    -- if the subparcels overlap eachother
	FOR a_row IN SELECT sp.geometry FROM RS_Parcel as p, RS_SubParcel as sp WHERE sp.numberz = p.numberz LOOP
		IF ( SELECT st_overlaps(st_buffer(a_row.geometry, -0.0000001), NEW.geometry)) IS TRUE THEN
			RAISE EXCEPTION 'Subparcels cannot overlap with each others';
		END IF;
	END LOOP;

	return NEW;
	
    END
$$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER cover_RS_SubParcel BEFORE INSERT OR UPDATE ON RS_SubParcel
    FOR EACH ROW EXECUTE PROCEDURE coverCheck();