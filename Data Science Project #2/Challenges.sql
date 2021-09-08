/*Do longer or shorter length albums tend to generate more revenue?*/

WITH album_length
AS (SELECT albums.AlbumId,albums.Title, 
	COUNT(tracks.name)AS 'TrackNumber'
FROM tracks
JOIN albums
ON tracks.AlbumId = albums.AlbumId
GROUP BY albums.Title
ORDER BY 3 DESC)

SELECT album_length.TrackNumber,
	AVG(invoice_items.UnitPrice *
	SELECT(SUM(Quantity) FROM invoice_items)))
	AS 'Average Revenue'
FROM invoice_items
JOIN tracks
ON invoice_items.TrackId = tracks.TrackId
JOIN album_length
ON tracks.AlbumId = album_length.AlbumId
GROUP BY album_length.TrackNumber;
