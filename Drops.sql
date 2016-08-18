DROP TRIGGER IF EXISTS Checker ON RS_AgrParcel CASCADE;
DROP FUNCTION IF EXISTS Checking();

DROP TRIGGER IF EXISTS cover_RS_SubParcel ON RS_SubParcel;
DROP FUNCTION IF EXISTS coverCheck();

DROP TRIGGER IF EXISTS overlap_RS_FarBlock ON RS_FarBlock CASCADE;
DROP TRIGGER IF EXISTS overlap_RS_AgrParcel ON RS_AgrParcel CASCADE;
DROP TRIGGER IF EXISTS overlap_RS_SubParcel ON RS_SubParcel CASCADE;
DROP TRIGGER IF EXISTS overlap_RS_TopoBlock ON RS_TopoBlock CASCADE;
DROP TRIGGER IF EXISTS overlap_RS_PhyBlock ON RS_PhyBlock CASCADE;
DROP FUNCTION IF EXISTS overlapCheck();

DROP TRIGGER IF EXISTS area_calculate_RS_SubParcel ON RS_SubParcel CASCADE;
DROP TRIGGER IF EXISTS rea_calculate_RS_AgrParcel ON RS_AgrParcel CASCADE;
DROP TRIGGER IF EXISTS area_calculate_RS_FarBlock ON RS_FarBlock CASCADE;
DROP TRIGGER IF EXISTS area_calculate_RS_TopoBlock ON RS_TopoBlock CASCADE;
DROP TRIGGER IF EXISTS area_calculate_RS_PhyBlock ON RS_PhyBlock CASCADE;
DROP FUNCTION IF EXISTS area_new();

DROP INDEX IF EXISTS idx_RS_SubParcel CASCADE;
DROP INDEX IF EXISTS idx_RS_TopoBlock CASCADE;
DROP INDEX IF EXISTS idx_RS_PhyBlock CASCADE;
DROP INDEX IF EXISTS idx_RS_FarBlock CASCADE;
DROP INDEX IF EXISTS idx_RS_AgrParcel CASCADE;
DROP INDEX IF EXISTS idx_RS_CadParcel CASCADE;

DROP TABLE IF EXISTS Crop CASCADE;
DROP TABLE IF EXISTS Animals CASCADE;
DROP TABLE IF EXISTS RS_Parcel CASCADE;
DROP TABLE IF EXISTS RS_PartOfParcel CASCADE;
DROP TABLE IF EXISTS RS_TopoBlock CASCADE; 
DROP TABLE IF EXISTS RS_SubParcel CASCADE;
DROP TABLE IF EXISTS RS_PhyBlock CASCADE;
DROP TABLE IF EXISTS RS_FarBlock CASCADE;
DROP TABLE IF EXISTS RS_AgrParcel CASCADE;
DROP TABLE IF EXISTS SubParcel CASCADE;
DROP TABLE IF EXISTS TopoBlock CASCADE;
DROP TABLE IF EXISTS PhyBlock CASCADE;
DROP TABLE IF EXISTS FarBlock CASCADE;
DROP TABLE IF EXISTS AgrParcel CASCADE;
DROP TABLE IF EXISTS JoinHoldingToRS_PhyBlock CASCADE;
DROP TABLE IF EXISTS JoinHoldingToRS_TopoBlock CASCADE;
DROP TABLE IF EXISTS CadastralParcel CASCADE;
DROP TABLE IF EXISTS VersionedObject CASCADE;
DROP TABLE IF EXISTS ReferenceParcel CASCADE;
DROP TABLE IF EXISTS Holding CASCADE;
DROP TABLE IF EXISTS UnreturnedLoan CASCADE;
DROP TABLE IF EXISTS PassiveReason CASCADE;
DROP TABLE IF EXISTS Member CASCADE;

DROP TYPE IF EXISTS LA_DimensionTYPE CASCADE;
DROP TYPE IF EXISTS LA_SurfaceRelationTYPE CASCADE;
DROP TYPE IF EXISTS LA_AreaTYPE CASCADE;
DROP TYPE IF EXISTS LA_VolumeTYPE CASCADE;
DROP TYPE IF EXISTS CI_RoleCode CASCADE;
DROP TYPE IF EXISTS LA_AreaValue CASCADE;
DROP TYPE IF EXISTS LA_VolumeValue CASCADE;
DROP TYPE IF EXISTS DQ_Element CASCADE;
DROP TYPE IF EXISTS CI_Contact CASCADE;
DROP TYPE IF EXISTS CI_ResponsibleParty CASCADE;
DROP TYPE IF EXISTS CL_PropertySector CASCADE;
DROP TYPE IF EXISTS CL_PurposeParcel CASCADE;
DROP TYPE IF EXISTS CL_WayOfUse CASCADE;
DROP TYPE IF EXISTS CL_ClosedArea CASCADE;
DROP TYPE IF EXISTS CL_Bonitet CASCADE;
DROP TYPE IF EXISTS AEMCodeTYPE CASCADE;
DROP TYPE IF EXISTS CropCodeTYPE CASCADE;
DROP TYPE IF EXISTS StatusTYPE CASCADE;
DROP TYPE IF EXISTS LandCoverCodeTYPE CASCADE;
