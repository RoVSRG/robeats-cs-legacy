local TimingPresets = {
	["Lenient"] = {
		NoteBadMaxMS = 142;
		NoteBadMinMS = -142;

		NoteGoodMaxMS = 118;
		NoteGoodMinMS = -118;

		NoteGreatMaxMS = 88;
		NoteGreatMinMS = -88;

		NotePerfectMaxMS = 55;
		NotePerfectMinMS = -55;

		NoteMarvelousMaxMS = 16;
		NoteMarvelousMinMS = -16;
	},
	["Standard"] = {
		NoteBadMaxMS = 136;
		NoteBadMinMS = -136;
		
		NoteGoodMaxMS = 112;
		NoteGoodMinMS = -112;
		
		NoteGreatMaxMS = 82;
		NoteGreatMinMS = -82;
		
		NotePerfectMaxMS = 49;
		NotePerfectMinMS = -49;
		
		NoteMarvelousMaxMS = 16;
		NoteMarvelousMinMS = -16;
	},
	["Strict"] = {
		NoteBadMaxMS = 130;
		NoteBadMinMS = -130;

		NoteGoodMaxMS = 106;
		NoteGoodMinMS = -106;

		NoteGreatMaxMS = 76;
		NoteGreatMinMS = -76;

		NotePerfectMaxMS = 43;
		NotePerfectMinMS = -43;

		NoteMarvelousMaxMS = 16;
		NoteMarvelousMinMS = -16;
	},
	["Extreme"] = {
		NoteBadMaxMS = 124;
		NoteBadMinMS = -124;

		NoteGoodMaxMS = 100;
		NoteGoodMinMS = -100;

		NoteGreatMaxMS = 70;
		NoteGreatMinMS = -70;

		NotePerfectMaxMS = 37;
		NotePerfectMinMS = -37;

		NoteMarvelousMaxMS = 16;
		NoteMarvelousMinMS = -16;
	}
}

function TimingPresets:get_timing_window(_preset)
	return TimingPresets[_preset];
end

return TimingPresets

