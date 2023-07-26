/*Do longer or shorter length albums tend to generate more revenue?*/

WITH album_length
AS (SELECT albums.AlbumId,albums.Title, 
	COUNT(tracks.name)AS 'TrackNumber',
	invoice_items.UnitPrice * SUM(Quantity)
	AS 'TotalRevenue'
FROM tracks
JOIN albums
ON tracks.AlbumId = albums.AlbumId
JOIN invoice_items
ON tracks.TrackId = invoice_items.TrackId
GROUP BY albums.Title
ORDER BY 3 DESC)

SELECT album_length.TrackNumber,
	ROUND(AVG(TotalRevenue),2) AS 'Average Revenue'
FROM album_length
GROUP BY album_length.TrackNumber
ORDER BY 2 DESC;
