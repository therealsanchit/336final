/*	Returns a table of the average rating of all the service types
	(No date restrictions, all service types)*/
SELECT avg(temptable.Rating) AS AvgRating, temptable.ServiceType
FROM(
	SELECT HotelDatabase.Reservation.CustomerID, HotelDatabase.Reserves.InDate, HotelDatabase.Reserves.OutDate, HotelDatabase.Reserves.InvoiceNumber,
	HotelDatabase.ServiceReview.ServiceType, HotelDatabase.ServiceReview.Rating
	FROM HotelDatabase.ServiceReview, HotelDatabase.Reserves, HotelDatabase.Reservation
	WHERE HotelDatabase.ServiceReview.CustomerID = HotelDatabase.Reservation.CustomerID AND HotelDatabase.Reservation.InvoiceNumber = HotelDatabase.Reserves.InvoiceNumber) temptable
GROUP BY ServiceType;

/*	Returns a table of the average rating of all the breakfast types across all hotels
	(No date restrictions, all breakfast types) */
SELECT avg(tempbftable.Rating) AS AvgRating, tempbftable.BreakfastType
FROM(
	SELECT HotelDatabase.Reservation.CustomerID, HotelDatabase.Reserves.InDate, HotelDatabase.Reserves.OutDate, HotelDatabase.Reserves.InvoiceNumber,
	HotelDatabase.BreakfastReview.BreakfastType, HotelDatabase.BreakfastReview.Rating
    FROM HotelDatabase.BreakfastReview, HotelDatabase.Reserves, HotelDatabase.Reservation
    WHERE HotelDatabase.BreakfastReview.CustomerID = HotelDatabase.Reservation.CustomerID AND HotelDatabase.Reservation.InvoiceNumber = HotelDatabase.Reserves.InvoiceNumber) tempbftable
GROUP BY BreakfastType;





/* Returns table of HotelID, RoomType, and average table ratings as AvgRating */
SELECT temptable3.HotelID, temptable3.RoomType, avg(temptable3.Rating) AS AvgRating
FROM(
	SELECT HotelDatabase.RoomReview.HotelID, HotelDatabase.Room.RoomType, HotelDatabase.RoomReview.Rating, HotelDatabase.Reserves.InDate, HotelDatabase.Reserves.Outdate
	FROM HotelDatabase.RoomReview, HotelDatabase.Reserves, HotelDatabase.Reservation, HotelDatabase.Room
	WHERE HotelDatabase.RoomReview.HotelID = HotelDatabase.Room.HotelID AND HotelDatabase.RoomReview.RoomNumber = HotelDatabase.Room.RoomNumber AND
	HotelDatabase.RoomReview.CustomerID = HotelDatabase.Reservation.CustomerID AND HotelDatabase.Reserves.InvoiceNumber = HotelDatabase.Reservation.InvoiceNumber AND
	HotelDatabase.Reserves.HotelID = HotelDatabase.Room.HotelID AND HotelDatabase.Reserves.RoomNumber = HotelDatabase.Room.RoomNumber) temptable3
GROUP BY HotelID, RoomType;

/* Returns table of CustomerID and their total sum spent (need to adjust for selected dates) */
SELECT tempsumtable.CustomerID, sum(tempsumtable.TotalAmount) AS CustomerSum
FROM (
	SELECT HotelDatabase.Reservation.CustomerID, HotelDatabase.Reservation.TotalAmount, HotelDatabase.Reservation.ReservationDate, HotelDatabase.Reservation.InvoiceNumber
	FROM HotelDatabase.Reservation) tempsumtable
GROUP BY CustomerID;


















/*	Returns all the room reviews for all hotels		*/
SELECT *
FROM HotelDatabase.RoomReview;

SELECT *
FROM HotelDatabase.Reserves;

SELECT *
FROM HotelDatabase.Reservation;

/*		Creates initial table for computing the highest room type for each hotel	*/
SELECT HotelDatabase.RoomReview.HotelID, HotelDatabase.RoomReview.RoomNumber, HotelDatabase.Room.RoomType, HotelDatabase.RoomReview.Rating,
HotelDatabase.Reserves.InDate, HotelDatabase.Reserves.Outdate, HotelDatabase.Reserves.InvoiceNumber, HotelDatabase.Reservation.CustomerID, HotelDatabase.RoomReview.ReviewID
FROM HotelDatabase.RoomReview, HotelDatabase.Reserves, HotelDatabase.Reservation, HotelDatabase.Room
WHERE HotelDatabase.RoomReview.HotelID = HotelDatabase.Room.HotelID AND HotelDatabase.RoomReview.RoomNumber = HotelDatabase.Room.RoomNumber AND
HotelDatabase.RoomReview.CustomerID = HotelDatabase.Reservation.CustomerID AND HotelDatabase.Reserves.InvoiceNumber = HotelDatabase.Reservation.InvoiceNumber AND
HotelDatabase.Reserves.HotelID = HotelDatabase.Room.HotelID AND HotelDatabase.Reserves.RoomNumber = HotelDatabase.Room.RoomNumber;


/* Merges the RoomReview and Room tables to make this less complicated maybe */
/*SELECT HotelDatabase.RoomReview.ReviewID, HotelDatabase.RoomReview.CustomerID, HotelDatabase.Room.HotelID, HotelDatabase.Room.RoomType,
HotelDatabase.Room.RoomNumber, HotelDatabase.RoomReview.Rating
FROM HotelDatabase.RoomReview, HotelDatabase.Room
WHERE HotelDatabase.RoomReview.HotelID = HotelDatabase.Room.HotelID AND HotelDatabase.RoomReview.RoomNumber = HotelDatabase.Room.RoomNumber;*/

/*SELECT HotelDatabase.TempRoom.ReviewID, HotelDatabase.TempRoom.CustomerID, HotelDatabase.TempRoom.HotelID, HotelDatabase.TempRoom.RoomType,
HotelDatabase.TempRoom.RoomNumber, HotelDatabase.TempRoom.Rating, HotelDatabase.Reservation.InvoiceNumber, HotelDatabase.*/

/* Actual table for computing highest room type for each hotel */
SELECT HotelDatabase.RoomReview.HotelID, HotelDatabase.Room.RoomType, HotelDatabase.RoomReview.Rating, HotelDatabase.Reserves.InDate, HotelDatabase.Reserves.Outdate
FROM HotelDatabase.RoomReview, HotelDatabase.Reserves, HotelDatabase.Reservation, HotelDatabase.Room
WHERE HotelDatabase.RoomReview.HotelID = HotelDatabase.Room.HotelID AND HotelDatabase.RoomReview.RoomNumber = HotelDatabase.Room.RoomNumber AND
HotelDatabase.RoomReview.CustomerID = HotelDatabase.Reservation.CustomerID AND HotelDatabase.Reserves.InvoiceNumber = HotelDatabase.Reservation.InvoiceNumber AND
HotelDatabase.Reserves.HotelID = HotelDatabase.Room.HotelID AND HotelDatabase.Reserves.RoomNumber = HotelDatabase.Room.RoomNumber;





