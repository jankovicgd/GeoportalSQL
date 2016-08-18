CREATE INDEX idx_RS_SubParcel ON RS_SubParcel USING GIST (geometry);
CREATE INDEX idx_RS_TopoBlock ON RS_Topoblock USING GIST (geometry);
CREATE INDEX idx_RS_PhyBlock ON RS_PhyBlock USING GIST (geometry);
CREATE INDEX idx_RS_FarBlock ON RS_FarBlock USING GIST (geometry);
CREATE INDEX idx_RS_AgrParcel ON RS_AgrParcel USING GIST (geometry);
CREATE INDEX idx_RS_CadParcel ON RS_Parcel USING GIST (geometry);
