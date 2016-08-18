CREATE TYPE LA_SurfaceRelationType AS ENUM ('mixed', 'below', 'above', 'onSurface');
CREATE TYPE LA_DimensionType AS ENUM ('0D', '1D', '2D', '3D', 'liminal');
CREATE TYPE LA_AreaType AS ENUM ('officialArea','nonOfficialArea','calculatedArea','surveyedArea');
CREATE TYPE LA_VolumeType AS ENUM ('officialArea','nonOfficialArea','calculatedArea','surveyedArea');
CREATE TYPE CI_RoleCode AS ENUM ('resourceProvider', 'custodian', 'owner', 'user', 'distributor', 'originator', 'pointOfContact','principalInvestigator', 'processor', 'publisher', 'author');

CREATE TYPE LA_AreaValue AS(
	areaSize DECIMAL(10,2),
	type LA_AreaType
)
;

CREATE TYPE LA_VolumeValue AS(
	volumeSize DECIMAL(10,2),
	type LA_VolumeType
)
;
CREATE TYPE DQ_Element AS(
	nameOfMeasure VARCHAR(100),
	measureIdentification VARCHAR(100),
	measureDescription VARCHAR(100),
	evaluationMethodType VARCHAR(100),
	evaluationMethodDescription VARCHAR(100),
	evaluationProcedure VARCHAR(100),
	dateandTime TIMESTAMP,
	result VARCHAR(50)
)
;

CREATE TYPE CI_Contact AS(
	phone VARCHAR(50),
	address VARCHAR(50),
	onlineResource VARCHAR(50),
	hoursOfService VARCHAR(50),
	contactInstructions VARCHAR(50)
)
;

CREATE TYPE CI_ResponsibleParty AS(
	individualName VARCHAR(50),
	organisationName VARCHAR(50),
	positionName VARCHAR(50),
	contactInfo CI_Contact,
	role CI_RoleCode
)
;

CREATE TABLE CadastralParcel ( 
	InspireID VARCHAR(100),
	label VARCHAR(25),
	geometry geometry(Polygon,31277), -- composite object - geometry polygon - GM_Object?
	nationalCadastralReference VARCHAR(50),
	areaValue DECIMAL(10,2), -- area?
	validFrom TIMESTAMP,
	validTo TIMESTAMP,
	extAddressId INTEGER,
	area LA_AreaValue, -- composite
	dimension LA_DimensionType, -- enum
	surfaceRelation LA_SurfaceRelationType, -- enum
	volume LA_VolumeValue, -- composite 
	quality DQ_Element, -- composite
	source CI_ResponsibleParty -- composite
	--cadastralParcelID INTEGER NOT NULL automatic generated PK
)
;

CREATE TABLE RS_Parcel ( 
	numberz INTEGER NOT NULL,
	numidx INTEGER
	--rS_ParcelID INTEGER NOT NULL automatic generated PK
)INHERITS(CadastralParcel)
;

ALTER TABLE RS_Parcel ADD PRIMARY KEY (numberz); -- not a primary key in the sense of the system - but placeholder for now

CREATE TYPE CL_PropertySector AS ENUM ('1 Fizicko lice', '2 Drustvena svojina', 'Suvlasnistvo');
CREATE TYPE CL_PurposeParcel AS ENUM ('1 Gradsko gradjevinsko zemljiste', '2 Ostala zemljista');
CREATE TYPE CL_WayOfUse AS ENUM ('njiva', 'vrt', 'vocnjak', 'vinograd', 'livada', 'pasnjak', 'suma', 'trstik i mocvara');
CREATE TYPE CL_ClosedArea AS ENUM ();
CREATE TYPE CL_Bonitet AS ENUM ();

CREATE TABLE RS_PartOfParcel ( 
	sequence INTEGER NOT NULL,
	propSecID CL_PropertySector, -- enum
	purposeParcelID CL_PurposeParcel, -- enum
	wayUseID CL_WayOfUse, -- very big enum
	closedArea CL_ClosedArea, -- enum
	planNum VARCHAR(10),
	sketchNum VARCHAR(10),
	manual INTEGER,
	year INTEGER,
	bonitetID CL_Bonitet,
	hektar INTEGER,
	ar INTEGER,
	metar INTEGER,
	numberz INTEGER NOT NULL
	--rS_PartOfParcelID INTEGER NOT NULL, automatic generated PK
	--rS_ParcelID INTEGER automatic generated FK
)
;

ALTER TABLE RS_PartOfParcel ADD PRIMARY KEY (sequence); -- not a primary key - but placeholder
ALTER TABLE RS_PartOfParcel ADD CONSTRAINT FK_numberz FOREIGN KEY (numberz) REFERENCES RS_Parcel (numberz) MATCH FULL; -- not a foreign key - but placeholder

CREATE TABLE VersionedObject ( 
	beginLifespanVersion TIMESTAMP,
	endLifespanVersion TIMESTAMP,
	quality DQ_Element, -- composite
	source CI_ResponsibleParty -- composite
	--versionedObjectID INTEGER NOT NULL automatic generated PK
)
;

CREATE TYPE StatusType AS ENUM ('modified', 'valid');

CREATE TABLE ReferenceParcel ( 
	digitisedArea DECIMAL(10,2), -- area
	effectiveDate DATE,
	farmedArea DECIMAL(10,2),
	geometry geometry(Polygon,31277),
	perimeter DECIMAL(10,2),
	referenceArea DECIMAL(10,2),
	rpID VARCHAR(20) NOT NULL,
	status StatusType -- enum
	--referenceParcelID INTEGER NOT NULL automatic generated PK
)
;

ALTER TABLE ReferenceParcel ADD PRIMARY KEY (rpID); -- rpID unique identifier for country

CREATE TABLE Holding ( 
	BPGArea INTEGER,
	BPGNo SMALLINT,
	dateFirstRegistration DATE,
	MBPG BIGINT NOT NULL,
	companyName VARCHAR(50),
	holderAccount BIGINT,
	street VARCHAR(50),
	houseNumber SMALLINT,
	postNumber SMALLINT,
	workActivity SMALLINT,
	school SMALLINT,
	holderState SMALLINT,
	holdingState SMALLINT,
	restoration SMALLINT,
	activity SMALLINT
	--holdingID INTEGER NOT NULL automatic generated PK
)
;

ALTER TABLE Holding ADD PRIMARY KEY (MBPG); -- MBPG unique identifier for a holding

CREATE TABLE UnreturnedLoan ( 
	BPGArea INTEGER,
	BPGNo SMALLINT,
	yearOfRight SMALLINT,
	bank SMALLINT,
	loanStatus SMALLINT,
	maturityDate DATE,
	--unreturnedLoanID INTEGER NOT NULL, automatic generated PK
	-- holdingID INTEGER automatic generated FK
	MBPG BIGINT NOT NULL
)
;

ALTER TABLE UnreturnedLoan ADD CONSTRAINT FK_UnreturnedLoan FOREIGN KEY (MBPG) REFERENCES Holding (MBPG) MATCH FULL;

CREATE TABLE PassiveReason ( 
	BPGArea INTEGER,
	BPGNo SMALLINT,
	reason SMALLINT,
	blockDate DATE,
	--passiveReasonID INTEGER NOT NULL, automatic generated PK
	-- holdingID INTEGER automatic generated FK
	MBPG BIGINT NOT NULL
)
;

ALTER TABLE PassiveReason ADD CONSTRAINT FK_PassiveReason FOREIGN KEY (MBPG) REFERENCES Holding (MBPG) MATCH FULL;

CREATE TABLE Member ( 
	JMBG BIGINT,
	BPGArea INTEGER,
	BPGNo SMALLINT,
	surname VARCHAR(50),
	name VARCHAR(50),
	workActivity SMALLINT,
	--memberID INTEGER NOT NULL, automatic generated PK
	-- holdingID INTEGER NOT NULL automatic generated FK
	MBPG BIGINT NOT NULL
)
;

ALTER TABLE Member ADD CONSTRAINT FK_Member FOREIGN KEY (MBPG) REFERENCES Holding (MBPG) MATCH FULL;

CREATE TABLE Crop ( 
	BPGArea INTEGER,
	BPGNo SMALLINT,
	entitlement SMALLINT,
	cropCode VARCHAR(50), -- from list
	area float,
	numberOfTrees SMALLINT,
	--cropID INTEGER NOT NULL, automatic generated PK -- can be used for control - problem of access
	--holdingID INTEGER automatic generated FK
	MBPG BIGINT NOT NULL
)
;

ALTER TABLE Crop ADD CONSTRAINT FK_Crop FOREIGN KEY (MBPG) REFERENCES Holding (MBPG) MATCH FULL;

CREATE TABLE Animals ( 
	BPGArea INTEGER,
	BPGNo SMALLINT,
	animalCode float, -- from list
	totalNumber SMALLINT,
	--animalsID INTEGER NOT NULL, automatic generated PK
	-- holdingID INTEGER automatic generated FK
	MBPG BIGINT NOT NULL
)
;

ALTER TABLE Animals ADD CONSTRAINT FK_Animals FOREIGN KEY (MBPG) REFERENCES Holding (MBPG) MATCH FULL;

CREATE TYPE LandCoverCodeType AS ENUM ('arableLand', 'nonAgricultural', 'oliveTrees', 'permanentCrop', 'permanentPasture', 'semiNaturalGrassland');

CREATE TABLE SubParcel ( 
	landCoverType LandCoverCodeType, -- enum
	referencePoint geometry(Point,4326), -- composite geometry
	sprID VARCHAR(25)
	-- subParcelID INTEGER NOT NULL automatic generated PK
)INHERITS (ReferenceParcel, VersionedObject)
;

CREATE TABLE TopoBlock ( 
	dominantLandCover LandCoverCodeType
	-- topoBlockID INTEGER NOT NULL automatic generated PK
)INHERITS (ReferenceParcel)
;

CREATE TABLE PhyBlock ( 
	landCoverType LandCoverCodeType
	-- phyBlockID INTEGER NOT NULL automatic generated PK
)INHERITS (ReferenceParcel)
;

ALTER TABLE phyblock ADD PRIMARY KEY (rpID); -- Inherited column which is PK

CREATE TABLE FarBlock ( 
	farmID VARCHAR(20),
	-- farmingMode CodeList, -- optional
	landCoverType LandCoverCodeType
	-- farBlockID INTEGER NOT NULL automatic generated PK
)INHERITS (ReferenceParcel)
;

CREATE TYPE AEMCodeType AS ENUM ('afforestation');
CREATE TYPE CropCodeType AS ENUM ('barley', 'linseeds', 'no-crop', 'oats', 'rye', 'wheat');

CREATE TABLE AgrParcel ( 
	agroEnvMeasureType AEMCodeType, -- enum
	cropType CropCodeType, -- enum
	declaredArea DECIMAL(10,2),
	farmID VARCHAR(20),
	landCoverType LandCoverCodeType -- enum
	-- agrParcelID INTEGER NOT NULL automatic generated FK
)INHERITS (ReferenceParcel)
;

CREATE TABLE RS_TopoBlock ( 
	-- rS_TopoBlockID INTEGER NOT NULL automatic generated PK
)INHERITS(TopoBlock,VersionedObject)
;

ALTER TABLE RS_TopoBlock ADD PRIMARY KEY (rpID); -- rpID unique identifier for country

CREATE TABLE RS_SubParcel ( 
	-- rS_SubParcelID INTEGER NOT NULL, automatic generated FK
	-- holdingID INTEGER NOT NULL automatic generated FK
	propSecID CL_PropertySector, -- enum
	purposeParcelID CL_PurposeParcel, -- enum
	wayUseID CL_WayOfUse, -- very big enum
	closedArea CL_ClosedArea, -- enum
	planNum VARCHAR(10),
	sketchNum VARCHAR(10),
	manual INTEGER,
	year INTEGER,
	bonitetID CL_Bonitet,
	hektar INTEGER,
	ar INTEGER,
	metar INTEGER,
	numberz INTEGER NOT NULL,
	sequence INTEGER NOT NULL
)INHERITS (SubParcel)
;

ALTER TABLE RS_SubParcel ADD PRIMARY KEY (rpID); -- rpID unique identifier for country
ALTER TABLE RS_SubParcel ADD CONSTRAINT FK1_RS_SubParcel FOREIGN KEY (numberz) REFERENCES RS_Parcel (numberz) MATCH FULL;
ALTER TABLE RS_SubParcel ADD CONSTRAINT FK2_RS_SubParcel FOREIGN KEY (sequence) REFERENCES RS_PartOfParcel (sequence) MATCH FULL;

CREATE TABLE RS_PhyBlock ( 
	-- rS_PhyBlockID INTEGER NOT NULL automatic generated FK
)INHERITS (PhyBlock,VersionedObject)
;

ALTER TABLE RS_PhyBlock ADD PRIMARY KEY (rpID); -- rpID unique identifier for country

CREATE TABLE RS_FarBlock ( 
	-- rS_FarBlockID INTEGER NOT NULL, automatic generated FK
	-- holdingID INTEGER NOT NULL automatic generated FK
	MBPG BIGINT NOT NULL
)INHERITS (FarBlock,VersionedObject)
;

ALTER TABLE RS_FarBlock ADD PRIMARY KEY (rpID); -- rpID unique identifier for country
ALTER TABLE RS_FarBlock ADD CONSTRAINT FK_RS_FarBlock FOREIGN KEY (MBPG) REFERENCES Holding (MBPG) MATCH FULL;

CREATE TABLE RS_AgrParcel ( 
	-- rS_AgrParcelID INTEGER NOT NULL, automatic generated PK
	-- cropID INTEGER, automatic generated FK
	-- holdingID INTEGER NOT NULL automatic generated FK
	MBPG BIGINT NOT NULL,
	cropCode VARCHAR(50) NOT NULL
)INHERITS(AgrParcel,VersionedObject)
;

ALTER TABLE RS_AgrParcel ADD PRIMARY KEY (rpID); -- rpID unique identifier for country
ALTER TABLE RS_AgrParcel ADD CONSTRAINT FK_RS_AgrParcel FOREIGN KEY (MBPG) REFERENCES Holding (MBPG) MATCH FULL;
--ALTER TABLE RS_AgrParcel ADD CONSTRAINT FK2_RS_AgrParcel FOREIGN KEY (cropCode) REFERENCES Crop (cropCode) MATCH FULL;

--CREATE TABLE JoinCadSubParcelToRS_Parcel ( 
	-- rS_ParcelID INTEGER automatic generated FK
--)
--;

--CREATE TABLE JoinSubParcelToRS_Parcel ( error in modelling
	-- rS_ParcelID INTEGER, automatic generated FK
	-- subParcelID INTEGER automatic generated FK
--	numberz INTEGER NOT NULL,
--	rpID VARCHAR(20)
--)
--;

CREATE TABLE JoinHoldingToRS_PhyBlock ( 
	-- rS_PhyBlockID INTEGER, automatic generated FK
	-- holdingID INTEGER automatic generated FK
	MBPG BIGINT,
	rpID VARCHAR(20)
)
;

ALTER TABLE JoinHoldingToRS_PhyBlock ADD CONSTRAINT FK1_JoinHoldingToRS_PhyBlock FOREIGN KEY (rpID) REFERENCES RS_PhyBlock (rpID) MATCH FULL;
ALTER TABLE JoinHoldingToRS_PhyBlock ADD CONSTRAINT FK2_JoinHoldingToRS_PhyBlock FOREIGN KEY (MBPG) REFERENCES Holding (MBPG) MATCH FULL;

CREATE TABLE JoinHoldingToRS_TopoBlock ( 
	MBPG BIGINT,
	rpID VARCHAR(20)
	-- rS_TopoBlockID INTEGER, automatic generated FK
	-- holdingID INTEGER automatic generated FK
)
;

ALTER TABLE JoinHoldingToRS_TopoBlock ADD CONSTRAINT FK1_JoinHoldingToRS_TopoBlock FOREIGN KEY (rpID) REFERENCES RS_TopoBlock (rpID) MATCH FULL;
ALTER TABLE JoinHoldingToRS_TopoBlock ADD CONSTRAINT FK2_JoinHoldingToRS_TopoBlock FOREIGN KEY (MBPG) REFERENCES Holding (MBPG) MATCH FULL;

--CREATE TABLE JoinAgrParcelToFarmer ( 
	-- agrParcelID INTEGER automatic generated FK
--)
--;

--CREATE TABLE JoinFarmerToFarBlock ( 
	-- farBlockID INTEGER automatic generated FK
--)
--;

--CREATE TABLE JoinStatusToReferenceParcel ( 
	-- referenceParcelID INTEGER automatic generated FK
--)
--;

--CREATE TABLE JoinReferenceParcelToHistory ( 
	-- referenceParcelID INTEGER automatic generated FK
--)
--;

--CREATE TABLE derivedLADM ( 
	-- cadastralParcelID INTEGER automatic generated PK
--)
--;