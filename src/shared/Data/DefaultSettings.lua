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
	NoteSpeed = 1000;

	--Configure these to change timing windows		

	Preset = "Standard";

	--You probably won't need to modify these
	NoteRemoveTimeMS = -200;
	PostFinishWaitTimeMS = 300;
	PreStartCountdownTimeMS = 3000;
}