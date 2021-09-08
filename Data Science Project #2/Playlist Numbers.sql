/*Which tracks appeared in the most playlists?
	How many playlists did they appear in?*/

SELECT tracks.name AS 'Track Name',
	COUNT (*) AS 'Number of Playlists'
FROM playlist_track
JOIN tracks
ON playlist_track.TrackId = tracks.TrackId
GROUP BY playlist_track.TrackId
ORDER BY 2 DESC
Limit 50;