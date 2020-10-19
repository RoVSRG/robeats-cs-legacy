--Default settings for new players (and if you press "Reset" in the SettingsMenu)
return {
	--These values can be set in SettingsMenu
	Keybinds = {
			{Enum.KeyCode.Q, Enum.KeyCode.A, Enum.KeyCode.Z, Enum.KeyCode.U, Enum.KeyCode.J, Enum.KeyCode.M},
			{Enum.KeyCode.W, Enum.KeyCode.S, Enum.KeyCode.X, Enum.KeyCode.I, Enum.KeyCode.K, Enum.KeyCode.Comma},
			{Enum.KeyCode.E, Enum.KeyCode.D, Enum.KeyCode.C, Enum.KeyCode.O, Enum.KeyCode.L, Enum.KeyCode.Period},
			{Enum.KeyCode.R, Enum.KeyCode.F, Enum.KeyCode.V, Enum.KeyCode.P, Enum.KeyCode.Semicolon, Enum.KeyCode.Slash},
	};
	AudioOffset = 0;
	NoteSpeedMultiplier = 1;
	
	--Configure these to change timing windows		
	
	NoteGreatMaxMS = 82;
	NoteGreatMinMS = -82;

	NoteGoodMaxMS = 112;
	NoteGoodMinMS = -112;

	NoteBadMaxMS = 136;
	NoteBadMinMS = -136;

	NotePerfectMaxMS = 49;
	NotePerfectMinMS = -49;

	NoteMarvelousMaxMS = 16;
	NoteMarvelousMinMS = -16;
	
	--You probably won't need to modify these
	NoteRemoveTimeMS = -200;
	PostFinishWaitTimeMS = 300;
	PreStartCountdownTimeMS = 3000;
}