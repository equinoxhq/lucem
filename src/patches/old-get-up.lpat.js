/* Patch to bring back old get-up sound effect
 * 
 * Copyright (C) 2025 Trayambak Rai (xtrayambak at disroot dot org)
*/

function apply(version)
{
	console.log("Applying patch on Lucem @", version);

	// const path = HTTP.get("https://github.com/bloxstraplabs/bloxstrap/raw/main/Bloxstrap/Resources/Mods/Sounds/OldGetUp.mp3");

	if (path == undefined)
	{
		throw "HTTP request for sound seems to have failed";
	}

	// mutate("content/sounds/action_get_up.mp3", path);
}
