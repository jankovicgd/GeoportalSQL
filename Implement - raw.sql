CREATE TABLE /derived LADM ( 
	cadastralParcelID int
)
;

CREATE TABLE /derived LADM ( 
	cadastralParcelID int
)
;

CREATE TABLE CadastralParcel ( 
	geometry GM_Object,
	InspireID Identifier,
	label CharacterString,
	nationalCadastralReference CharacterString,
	areaValue Area,
	validFrom datetime2(7),
	validTo datetime2(7),
	extAddressId ExtAddress,
	area LA_AreaValue,
	dimension LA_DimensionType,
	surfaceRelation LA_SurfaceRelationType,
	volume LA_VolumeValue,
	quality DQ_Element,
	source CI_ResponsibleParty,
	cadastralParcelID int NOT NULL
)
;

CREATE TABLE UnreturnedLoan ( 
	BPGArea int,
	BPGNo byte,
	yearOfRight short,
	bank short,
	loanStatus byte,
	maturityDate date,
	unreturnedLoanID int NOT NULL,
	holdingID int
)
;

CREATE TABLE PassiveReason ( 
	BPGArea int,
	BPGNo byte,
	reason byte,
	blockDate date,
	passiveReasonID int NOT NULL,
	holdingID int
)
;

CREATE TABLE Member ( 
	JMBG long,
	BPGArea int,
	BPGNo byte,
	surname varchar(50),
	name varchar(50),
	workActivity byte,
	memberID int NOT NULL,
	holdingID int NOT NULL
)
;

CREATE TABLE Holding ( 
	BPGArea int,
	BPGNo byte,
	dateFirstRegistration date,
	MBPG long,
	companyName varchar(50),
	holderAccount long,
	street varchar(50),
	houseNumber short,
	postNumber short,
	workActivity byte,
	school byte,
	holderState byte,
	holdingState byte,
	restoration byte,
	activity byte,
	holdingID int NOT NULL
)
;

CREATE TABLE Crop ( 
	BPGArea int,
	BPGNo byte,
	entitlement byte,
	cropCode varchar(50),
	area float,
	numberOfTrees byte,
	cropID int NOT NULL,
	holdingID int
)
;

CREATE TABLE Animals ( 
	BPGArea int,
	BPGNo byte,
	animalCode float,
	totalNumber byte,
	animalsID int NOT NULL,
	holdingID int
)
;

CREATE TABLE VersionedObject ( 
	beginLifespanVersion datetime2(7),
	endLifespanVersion datetime2(7),
	quality DQ_Element,
	source CI_ResponsibleParty,
	versionedObjectID int NOT NULL
)
;

CREATE TABLE SubParcel ( 
	landCoverType LandCoverCodeType,
	referencePoint GM_Point,
	sprID CharacterString,
	subParcelID int NOT NULL
)
;

CREATE TABLE TopoBlock ( 
	dominantLandCover LandCoverCodeType,
	topoBlockID int NOT NULL
)
;

CREATE TABLE JoinStatusToReferenceParcel ( 
	referenceParcelID int
)
;

CREATE TABLE JoinReferenceParcelToHistory ( 
	referenceParcelID int
)
;

CREATE TABLE ReferenceParcel ( 
	digitisedArea Area,
	effectiveDate date,
	farmedArea decimal(10,2),
	geometry GM_Polygon,
	perimeter decimal(10,2),
	referenceArea decimal(10,2),
	rpID CharacterString,
	status StatusType,
	referenceParcelID int NOT NULL
)
;

CREATE TABLE PhyBlock ( 
	landCoverType LandCoverCodeType,
	phyBlockID int NOT NULL
)
;

CREATE TABLE JoinFarmerToFarBlock ( 
	farBlockID int
)
;

CREATE TABLE FarBlock ( 
	farmID CharacterString,
	farmingMode CodeList,
	landCoverType LandCoverCodeType,
	farBlockID int NOT NULL
)
;

CREATE TABLE JoinAgrParcelToFarmer ( 
	agrParcelID int
)
;

CREATE TABLE AgrParcel ( 
	agroEnvMeasureType AEMCodeType,
	cropType CropCodeType,
	declaredArea decimal(10,2),
	farmID CharacterString,
	landCoverType LandCoverCodeType,
	paymentType ,
	agrParcelID int NOT NULL
)
;

CREATE TABLE JoinHoldingToRS_TopoBlock ( 
	rS_TopoBlockID int,
	holdingID int
)
;

CREATE TABLE RS_TopoBlock ( 
	rS_TopoBlockID int NOT NULL
)
;

CREATE TABLE RS_SubParcel ( 
	rS_SubParcelID int NOT NULL,
	holdingID int NOT NULL
)
;

CREATE TABLE JoinHoldingToRS_PhyBlock ( 
	rS_PhyBlockID int,
	holdingID int
)
;

CREATE TABLE RS_PhyBlock ( 
	rS_PhyBlockID int NOT NULL
)
;

CREATE TABLE RS_FarBlock ( 
	rS_FarBlockID int NOT NULL,
	holdingID int NOT NULL
)
;

CREATE TABLE RS_AgrParcel ( 
	rS_AgrParcelID int NOT NULL,
	cropID int,
	holdingID int NOT NULL
)
;

CREATE TABLE RS_PartOfParcel ( 
	sequence int,
	propSecID CL_PropertySector,
	purposeParcelID CL_PurposeParcel,
	wayUseID CL_WayOfUse,
	closedArea CL_ClosedArea,
	planNum CharacterString,
	sketchNum CharacterString,
	manual int,
	year int,
	bonitetID CL_Bonitet,
	hektar int,
	ar int,
	metar int,
	rS_PartOfParcelID int NOT NULL,
	rS_ParcelID int
)
;

CREATE TABLE JoinCadSubParcelToRS_Parcel ( 
	rS_ParcelID int
)
;

CREATE TABLE JoinSubParcelToRS_Parcel ( 
	rS_ParcelID int,
	subParcelID int
)
;

CREATE TABLE RS_Parcel ( 
	number int,
	numidx int,
	rS_ParcelID int NOT NULL
)
;


ALTER TABLE CadastralParcel ADD CONSTRAINT PK_CadastralParcel 
	PRIMARY KEY CLUSTERED (cadastralParcelID)
;

ALTER TABLE UnreturnedLoan ADD CONSTRAINT PK_UnreturnedLoan 
	PRIMARY KEY CLUSTERED (unreturnedLoanID)
;

ALTER TABLE PassiveReason ADD CONSTRAINT PK_PassiveReason 
	PRIMARY KEY CLUSTERED (passiveReasonID)
;

ALTER TABLE Member ADD CONSTRAINT PK_Member 
	PRIMARY KEY CLUSTERED (memberID)
;

ALTER TABLE Holding ADD CONSTRAINT PK_Holding 
	PRIMARY KEY CLUSTERED (holdingID)
;

ALTER TABLE Crop ADD CONSTRAINT PK_Crop 
	PRIMARY KEY CLUSTERED (cropID)
;

ALTER TABLE Animals ADD CONSTRAINT PK_Animals 
	PRIMARY KEY CLUSTERED (animalsID)
;

ALTER TABLE VersionedObject ADD CONSTRAINT PK_VersionedObject 
	PRIMARY KEY CLUSTERED (versionedObjectID)
;

ALTER TABLE SubParcel ADD CONSTRAINT PK_SubParcel 
	PRIMARY KEY CLUSTERED (subParcelID)
;

ALTER TABLE TopoBlock ADD CONSTRAINT PK_TopoBlock 
	PRIMARY KEY CLUSTERED (topoBlockID)
;

ALTER TABLE ReferenceParcel ADD CONSTRAINT PK_ReferenceParcel 
	PRIMARY KEY CLUSTERED (referenceParcelID)
;

ALTER TABLE PhyBlock ADD CONSTRAINT PK_PhyBlock 
	PRIMARY KEY CLUSTERED (phyBlockID)
;

ALTER TABLE FarBlock ADD CONSTRAINT PK_FarBlock 
	PRIMARY KEY CLUSTERED (farBlockID)
;

ALTER TABLE AgrParcel ADD CONSTRAINT PK_AgrParcel 
	PRIMARY KEY CLUSTERED (agrParcelID)
;

ALTER TABLE RS_TopoBlock ADD CONSTRAINT PK_RS_TopoBlock 
	PRIMARY KEY CLUSTERED (rS_TopoBlockID)
;

ALTER TABLE RS_SubParcel ADD CONSTRAINT PK_RS_SubParcel 
	PRIMARY KEY CLUSTERED (rS_SubParcelID)
;

ALTER TABLE RS_PhyBlock ADD CONSTRAINT PK_RS_PhyBlock 
	PRIMARY KEY CLUSTERED (rS_PhyBlockID)
;

ALTER TABLE RS_FarBlock ADD CONSTRAINT PK_RS_FarBlock 
	PRIMARY KEY CLUSTERED (rS_FarBlockID)
;

ALTER TABLE RS_AgrParcel ADD CONSTRAINT PK_RS_AgrParcel 
	PRIMARY KEY CLUSTERED (rS_AgrParcelID)
;

ALTER TABLE RS_PartOfParcel ADD CONSTRAINT PK_RS_PartOfParcel 
	PRIMARY KEY CLUSTERED (rS_PartOfParcelID)
;

ALTER TABLE RS_Parcel ADD CONSTRAINT PK_RS_Parcel 
	PRIMARY KEY CLUSTERED (rS_ParcelID)
;



ALTER TABLE /derived LADM ADD CONSTRAINT CadastralParcel 
	FOREIGN KEY (cadastralParcelID) REFERENCES CadastralParcel (cadastralParcelID)
;

ALTER TABLE /derived LADM ADD CONSTRAINT CadastralParcel 
	FOREIGN KEY (cadastralParcelID) REFERENCES CadastralParcel (cadastralParcelID)
;

ALTER TABLE UnreturnedLoan ADD CONSTRAINT FK_UnreturnedLoan_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE PassiveReason ADD CONSTRAINT FK_PassiveReason_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE Member ADD CONSTRAINT FK_Member_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE Crop ADD CONSTRAINT FK_Crop_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE Animals ADD CONSTRAINT FK_Animals_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE SubParcel ADD CONSTRAINT FK_SubParcel_ReferenceParcel 
	FOREIGN KEY (subParcelID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE SubParcel ADD CONSTRAINT FK_SubParcel_VersionedObject 
	FOREIGN KEY (subParcelID) REFERENCES VersionedObject (versionedObjectID)
;

ALTER TABLE TopoBlock ADD CONSTRAINT FK_TopoBlock_ReferenceParcel 
	FOREIGN KEY (topoBlockID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE JoinStatusToReferenceParcel ADD CONSTRAINT ReferenceParcel 
	FOREIGN KEY (referenceParcelID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE JoinReferenceParcelToHistory ADD CONSTRAINT ReferenceParcel 
	FOREIGN KEY (referenceParcelID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE PhyBlock ADD CONSTRAINT FK_PhyBlock_ReferenceParcel 
	FOREIGN KEY (phyBlockID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE JoinFarmerToFarBlock ADD CONSTRAINT FarBlock 
	FOREIGN KEY (farBlockID) REFERENCES FarBlock (farBlockID)
;

ALTER TABLE FarBlock ADD CONSTRAINT FK_FarBlock_ReferenceParcel 
	FOREIGN KEY (farBlockID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE JoinAgrParcelToFarmer ADD CONSTRAINT AgrParcel 
	FOREIGN KEY (agrParcelID) REFERENCES AgrParcel (agrParcelID)
;

ALTER TABLE AgrParcel ADD CONSTRAINT FK_AgrParcel_ReferenceParcel 
	FOREIGN KEY (agrParcelID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE JoinHoldingToRS_TopoBlock ADD CONSTRAINT RS_TopoBlock 
	FOREIGN KEY (rS_TopoBlockID) REFERENCES RS_TopoBlock (rS_TopoBlockID)
;

ALTER TABLE JoinHoldingToRS_TopoBlock ADD CONSTRAINT Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE RS_TopoBlock ADD CONSTRAINT FK_RS_TopoBlock_TopoBlock 
	FOREIGN KEY (rS_TopoBlockID) REFERENCES TopoBlock (topoBlockID)
;

ALTER TABLE RS_TopoBlock ADD CONSTRAINT FK_RS_TopoBlock_VersionedObject 
	FOREIGN KEY (rS_TopoBlockID) REFERENCES VersionedObject (versionedObjectID)
;

ALTER TABLE RS_SubParcel ADD CONSTRAINT FK_RS_SubParcel_RS_PartOfParcel 
	FOREIGN KEY (rS_SubParcelID) REFERENCES RS_PartOfParcel (rS_PartOfParcelID)
;

ALTER TABLE RS_SubParcel ADD CONSTRAINT FK_RS_SubParcel_SubParcel 
	FOREIGN KEY (rS_SubParcelID) REFERENCES SubParcel (subParcelID)
;

ALTER TABLE RS_SubParcel ADD CONSTRAINT FK_RS_SubParcel_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE JoinHoldingToRS_PhyBlock ADD CONSTRAINT RS_PhyBlock 
	FOREIGN KEY (rS_PhyBlockID) REFERENCES RS_PhyBlock (rS_PhyBlockID)
;

ALTER TABLE JoinHoldingToRS_PhyBlock ADD CONSTRAINT Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE RS_PhyBlock ADD CONSTRAINT FK_RS_PhyBlock_PhyBlock 
	FOREIGN KEY (rS_PhyBlockID) REFERENCES PhyBlock (phyBlockID)
;

ALTER TABLE RS_PhyBlock ADD CONSTRAINT FK_RS_PhyBlock_VersionedObject 
	FOREIGN KEY (rS_PhyBlockID) REFERENCES VersionedObject (versionedObjectID)
;

ALTER TABLE RS_FarBlock ADD CONSTRAINT FK_RS_FarBlock_FarBlock 
	FOREIGN KEY (rS_FarBlockID) REFERENCES FarBlock (farBlockID)
;

ALTER TABLE RS_FarBlock ADD CONSTRAINT FK_RS_FarBlock_VersionedObject 
	FOREIGN KEY (rS_FarBlockID) REFERENCES VersionedObject (versionedObjectID)
;

ALTER TABLE RS_FarBlock ADD CONSTRAINT FK_RS_FarBlock_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE RS_AgrParcel ADD CONSTRAINT FK_RS_AgrParcel_AgrParcel 
	FOREIGN KEY (rS_AgrParcelID) REFERENCES AgrParcel (agrParcelID)
;

ALTER TABLE RS_AgrParcel ADD CONSTRAINT FK_RS_AgrParcel_VersionedObject 
	FOREIGN KEY (rS_AgrParcelID) REFERENCES VersionedObject (versionedObjectID)
;

ALTER TABLE RS_AgrParcel ADD CONSTRAINT FK_RS_AgrParcel_Crop 
	FOREIGN KEY (cropID) REFERENCES Crop (cropID)
;

ALTER TABLE RS_AgrParcel ADD CONSTRAINT FK_RS_AgrParcel_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE RS_PartOfParcel ADD CONSTRAINT FK_RS_PartOfParcel_RS_Parcel 
	FOREIGN KEY (rS_ParcelID) REFERENCES RS_Parcel (rS_ParcelID)
;

ALTER TABLE JoinCadSubParcelToRS_Parcel ADD CONSTRAINT RS_Parcel 
	FOREIGN KEY (rS_ParcelID) REFERENCES RS_Parcel (rS_ParcelID)
;

ALTER TABLE JoinSubParcelToRS_Parcel ADD CONSTRAINT RS_Parcel 
	FOREIGN KEY (rS_ParcelID) REFERENCES RS_Parcel (rS_ParcelID)
;

ALTER TABLE JoinSubParcelToRS_Parcel ADD CONSTRAINT SubParcel 
	FOREIGN KEY (subParcelID) REFERENCES SubParcel (subParcelID)
;

ALTER TABLE RS_Parcel ADD CONSTRAINT FK_RS_Parcel_CadastralParcel 
	FOREIGN KEY (rS_ParcelID) REFERENCES CadastralParcel (cadastralParcelID)
;
