local rtv = {}
          -- Converted for Robeats CS --
rtv.AudioAssetId = "rbxassetid://2912264887"
rtv.AudioTimeOffset = -70 -- Edit this if needed
rtv.AudioVolume = 0.5 -- Do not edit this unless if audio is noticeably too quiet or loud
     -- You do not have to edit below here --
rtv.totalNotes = 42
rtv.totalHolds = 6
rtv.averageNps = 1.05
rtv.maxNps = 1.5
rtv.songLength = 39.495
rtv.AudioFilename = "e"
rtv.AudioDescription = ""
rtv.AudioCoverImageAssetId = ""
rtv.AudioArtist = "tatatat"
rtv.AudioDifficulty = 1
rtv.AudioNotePrebufferTime = 1000
rtv.AudioMod = 0
rtv.AudioHitSFXGroup = 0
rtv.HitObjects = {}
local function nt(time,track) rtv.HitObjects[#rtv.HitObjects+1]={Time=time;Type=1;Track=track;} end
local function hd(time,track,duration) rtv.HitObjects[#rtv.HitObjects+1] = {Time=time;Type=2;Track=track;Duration=duration;}  end
--
nt(67,2)--0
nt(924,3)--1
nt(1781,1)--2
nt(2638,4)--3
hd(3495,1,1714)--4
nt(5209,4)--5
nt(6066,1)--6
nt(6924,4)--7
nt(7781,2)--8
hd(8638,4,1714)--9
nt(10352,2)--10
nt(11209,3)--11
nt(12066,4)--12
nt(12924,1)--13
nt(13781,2)--14
nt(14638,3)--15
nt(15495,1)--16
nt(16352,2)--17
nt(17209,3)--18
nt(18066,2)--19
hd(18924,4,1714)--20
nt(20638,1)--21
nt(21495,2)--22
nt(22352,4)--23
nt(23209,3)--24
hd(24066,2,1715)--25
nt(25781,3)--26
nt(26638,1)--27
nt(27495,2)--28
nt(28352,3)--29
hd(29209,1,1715)--30
nt(30924,2)--31
nt(31781,2)--32
nt(32638,1)--33
nt(33495,4)--34
nt(34352,3)--35
nt(35209,3)--36
nt(36066,2)--37
nt(36924,3)--38
nt(37781,1)--39
nt(38638,2)--40
hd(39495,3,1714)--41
--
rtv.TimingPoints = {
	[1] = { Time = 67; BeatLength = 857.142857142857; };
};
--
rtv.NpsGraph = {
1.5, 
1, 
0.5, 
1.5, 
0.5, 
1, 
1.5, 
1, 
1, 
1, 
1, 
1, 
1, 
1, 
1, 
1, 
1, 
1, 
1.5, 
1
};
return rtv