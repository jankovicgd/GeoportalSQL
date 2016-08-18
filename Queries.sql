-- select all the data from sub-parcels covered by their respective parcels on numberz - join
SELECT * 
FROM RS_SubParcel a JOIN RS_Parcel b ON b.numberz = a.numberz
WHERE ST_Covers(b.geometry, a.geometry)