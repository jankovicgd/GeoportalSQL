
ALTER TABLE CadastralParcel ADD CONSTRAINTEGER PK_CadastralParcel 
	PRIMARY KEY CLUSTERED (cadastralParcelID)
;

ALTER TABLE UnreturnedLoan ADD CONSTRAINTEGER PK_UnreturnedLoan 
	PRIMARY KEY CLUSTERED (unreturnedLoanID)
;

ALTER TABLE PassiveReason ADD CONSTRAINTEGER PK_PassiveReason 
	PRIMARY KEY CLUSTERED (passiveReasonID)
;

ALTER TABLE Member ADD CONSTRAINTEGER PK_Member 
	PRIMARY KEY CLUSTERED (memberID)
;

ALTER TABLE Holding ADD CONSTRAINTEGER PK_Holding 
	PRIMARY KEY CLUSTERED (holdingID)
;

ALTER TABLE Crop ADD CONSTRAINTEGER PK_Crop 
	PRIMARY KEY CLUSTERED (cropID)
;

ALTER TABLE Animals ADD CONSTRAINTEGER PK_Animals 
	PRIMARY KEY CLUSTERED (animalsID)
;

ALTER TABLE VersionedObject ADD CONSTRAINTEGER PK_VersionedObject 
	PRIMARY KEY CLUSTERED (versionedObjectID)
;

ALTER TABLE SubParcel ADD CONSTRAINTEGER PK_SubParcel 
	PRIMARY KEY CLUSTERED (subParcelID)
;

ALTER TABLE TopoBlock ADD CONSTRAINTEGER PK_TopoBlock 
	PRIMARY KEY CLUSTERED (topoBlockID)
;

ALTER TABLE ReferenceParcel ADD CONSTRAINT PK_ReferenceParcel 
	PRIMARY KEY CLUSTERED (referenceParcelID)
;

ALTER TABLE PhyBlock ADD CONSTRAINTEGER PK_PhyBlock 
	PRIMARY KEY CLUSTERED (phyBlockID)
;

ALTER TABLE FarBlock ADD CONSTRAINTEGER PK_FarBlock 
	PRIMARY KEY CLUSTERED (farBlockID)
;

ALTER TABLE AgrParcel ADD CONSTRAINTEGER PK_AgrParcel 
	PRIMARY KEY CLUSTERED (agrParcelID)
;

ALTER TABLE RS_TopoBlock ADD CONSTRAINTEGER PK_RS_TopoBlock 
	PRIMARY KEY CLUSTERED (rS_TopoBlockID)
;

ALTER TABLE RS_SubParcel ADD CONSTRAINTEGER PK_RS_SubParcel 
	PRIMARY KEY CLUSTERED (rS_SubParcelID)
;

ALTER TABLE RS_PhyBlock ADD CONSTRAINTEGER PK_RS_PhyBlock 
	PRIMARY KEY CLUSTERED (rS_PhyBlockID)
;

ALTER TABLE RS_FarBlock ADD CONSTRAINTEGER PK_RS_FarBlock 
	PRIMARY KEY CLUSTERED (rS_FarBlockID)
;

ALTER TABLE RS_AgrParcel ADD CONSTRAINTEGER PK_RS_AgrParcel 
	PRIMARY KEY CLUSTERED (rS_AgrParcelID)
;

ALTER TABLE RS_PartOfParcel ADD CONSTRAINTEGER PK_RS_PartOfParcel 
	PRIMARY KEY CLUSTERED (rS_PartOfParcelID)
;

ALTER TABLE RS_Parcel ADD CONSTRAINTEGER PK_RS_Parcel 
	PRIMARY KEY CLUSTERED (rS_ParcelID)
;



ALTER TABLE /derived LADM ADD CONSTRAINTEGER CadastralParcel 
	FOREIGN KEY (cadastralParcelID) REFERENCES CadastralParcel (cadastralParcelID)
;

ALTER TABLE /derived LADM ADD CONSTRAINTEGER CadastralParcel 
	FOREIGN KEY (cadastralParcelID) REFERENCES CadastralParcel (cadastralParcelID)
;

ALTER TABLE UnreturnedLoan ADD CONSTRAINTEGER FK_UnreturnedLoan_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE PassiveReason ADD CONSTRAINTEGER FK_PassiveReason_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE Member ADD CONSTRAINTEGER FK_Member_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE Crop ADD CONSTRAINTEGER FK_Crop_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE Animals ADD CONSTRAINTEGER FK_Animals_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE SubParcel ADD CONSTRAINTEGER FK_SubParcel_ReferenceParcel 
	FOREIGN KEY (subParcelID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE SubParcel ADD CONSTRAINTEGER FK_SubParcel_VersionedObject 
	FOREIGN KEY (subParcelID) REFERENCES VersionedObject (versionedObjectID)
;

ALTER TABLE TopoBlock ADD CONSTRAINTEGER FK_TopoBlock_ReferenceParcel 
	FOREIGN KEY (topoBlockID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE JoinStatusToReferenceParcel ADD CONSTRAINTEGER ReferenceParcel 
	FOREIGN KEY (referenceParcelID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE JoinReferenceParcelToHistory ADD CONSTRAINTEGER ReferenceParcel 
	FOREIGN KEY (referenceParcelID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE PhyBlock ADD CONSTRAINTEGER FK_PhyBlock_ReferenceParcel 
	FOREIGN KEY (phyBlockID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE JoinFarmerToFarBlock ADD CONSTRAINTEGER FarBlock 
	FOREIGN KEY (farBlockID) REFERENCES FarBlock (farBlockID)
;

ALTER TABLE FarBlock ADD CONSTRAINTEGER FK_FarBlock_ReferenceParcel 
	FOREIGN KEY (farBlockID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE JoinAgrParcelToFarmer ADD CONSTRAINTEGER AgrParcel 
	FOREIGN KEY (agrParcelID) REFERENCES AgrParcel (agrParcelID)
;

ALTER TABLE AgrParcel ADD CONSTRAINTEGER FK_AgrParcel_ReferenceParcel 
	FOREIGN KEY (agrParcelID) REFERENCES ReferenceParcel (referenceParcelID)
;

ALTER TABLE JoinHoldingToRS_TopoBlock ADD CONSTRAINTEGER RS_TopoBlock 
	FOREIGN KEY (rS_TopoBlockID) REFERENCES RS_TopoBlock (rS_TopoBlockID)
;

ALTER TABLE JoinHoldingToRS_TopoBlock ADD CONSTRAINTEGER Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE RS_TopoBlock ADD CONSTRAINTEGER FK_RS_TopoBlock_TopoBlock 
	FOREIGN KEY (rS_TopoBlockID) REFERENCES TopoBlock (topoBlockID)
;

ALTER TABLE RS_TopoBlock ADD CONSTRAINTEGER FK_RS_TopoBlock_VersionedObject 
	FOREIGN KEY (rS_TopoBlockID) REFERENCES VersionedObject (versionedObjectID)
;

ALTER TABLE RS_SubParcel ADD CONSTRAINTEGER FK_RS_SubParcel_RS_PartOfParcel 
	FOREIGN KEY (rS_SubParcelID) REFERENCES RS_PartOfParcel (rS_PartOfParcelID)
;

ALTER TABLE RS_SubParcel ADD CONSTRAINTEGER FK_RS_SubParcel_SubParcel 
	FOREIGN KEY (rS_SubParcelID) REFERENCES SubParcel (subParcelID)
;

ALTER TABLE RS_SubParcel ADD CONSTRAINTEGER FK_RS_SubParcel_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE JoinHoldingToRS_PhyBlock ADD CONSTRAINTEGER RS_PhyBlock 
	FOREIGN KEY (rS_PhyBlockID) REFERENCES RS_PhyBlock (rS_PhyBlockID)
;

ALTER TABLE JoinHoldingToRS_PhyBlock ADD CONSTRAINTEGER Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE RS_PhyBlock ADD CONSTRAINTEGER FK_RS_PhyBlock_PhyBlock 
	FOREIGN KEY (rS_PhyBlockID) REFERENCES PhyBlock (phyBlockID)
;

ALTER TABLE RS_PhyBlock ADD CONSTRAINTEGER FK_RS_PhyBlock_VersionedObject 
	FOREIGN KEY (rS_PhyBlockID) REFERENCES VersionedObject (versionedObjectID)
;

ALTER TABLE RS_FarBlock ADD CONSTRAINTEGER FK_RS_FarBlock_FarBlock 
	FOREIGN KEY (rS_FarBlockID) REFERENCES FarBlock (farBlockID)
;

ALTER TABLE RS_FarBlock ADD CONSTRAINTEGER FK_RS_FarBlock_VersionedObject 
	FOREIGN KEY (rS_FarBlockID) REFERENCES VersionedObject (versionedObjectID)
;

ALTER TABLE RS_FarBlock ADD CONSTRAINTEGER FK_RS_FarBlock_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE RS_AgrParcel ADD CONSTRAINTEGER FK_RS_AgrParcel_AgrParcel 
	FOREIGN KEY (rS_AgrParcelID) REFERENCES AgrParcel (agrParcelID)
;

ALTER TABLE RS_AgrParcel ADD CONSTRAINTEGER FK_RS_AgrParcel_VersionedObject 
	FOREIGN KEY (rS_AgrParcelID) REFERENCES VersionedObject (versionedObjectID)
;

ALTER TABLE RS_AgrParcel ADD CONSTRAINTEGER FK_RS_AgrParcel_Crop 
	FOREIGN KEY (cropID) REFERENCES Crop (cropID)
;

ALTER TABLE RS_AgrParcel ADD CONSTRAINTEGER FK_RS_AgrParcel_Holding 
	FOREIGN KEY (holdingID) REFERENCES Holding (holdingID)
;

ALTER TABLE RS_PartOfParcel ADD CONSTRAINTEGER FK_RS_PartOfParcel_RS_Parcel 
	FOREIGN KEY (rS_ParcelID) REFERENCES RS_Parcel (rS_ParcelID)
;

ALTER TABLE JoinCadSubParcelToRS_Parcel ADD CONSTRAINTEGER RS_Parcel 
	FOREIGN KEY (rS_ParcelID) REFERENCES RS_Parcel (rS_ParcelID)
;

ALTER TABLE JoinSubParcelToRS_Parcel ADD CONSTRAINTEGER RS_Parcel 
	FOREIGN KEY (rS_ParcelID) REFERENCES RS_Parcel (rS_ParcelID)
;

ALTER TABLE JoinSubParcelToRS_Parcel ADD CONSTRAINTEGER SubParcel 
	FOREIGN KEY (subParcelID) REFERENCES SubParcel (subParcelID)
;

ALTER TABLE RS_Parcel ADD CONSTRAINTEGER FK_RS_Parcel_CadastralParcel 
	FOREIGN KEY (rS_ParcelID) REFERENCES CadastralParcel (cadastralParcelID)
;
