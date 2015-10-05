#include <sourcemod>
#include <teamgames>

#define GAME_ID	"SimpleKnifeFight"

public Plugin:myinfo =
{
	name = "[TG] SimpleKnifeFight",
	author = "Raska",
	description = "",
	version = "0.1",
	url = ""
}

public OnPluginStart()
{
	LoadTranslations("TG.SimpleKnifeFight.phrases");
}

public OnLibraryAdded(const String:name[])
{
	if (StrEqual(name, "TeamGames")) {

		if (!TG_IsModuleReged(TG_Game, GAME_ID)) {
			TG_RegGame(GAME_ID, TG_FiftyFifty);
		}
	}
}

public OnPluginEnd()
{
	TG_RemoveGame(GAME_ID);
}

public TG_AskModuleName(TG_ModuleType:type, const String:id[], client, String:name[], maxSize, &TG_MenuItemStatus:status)
{
	if (type == TG_Game && StrEqual(id, GAME_ID)) {
		Format(name, maxSize, "%T", "GameName", client);
	}
}

public TG_OnMenuSelected(TG_ModuleType:type, const String:sID[], client)
{
	if (type == TG_Game && StrEqual(sID, GAME_ID)) {
		TG_StartGame(client, GAME_ID);
	}
}

public TG_OnGamePrepare(const String:sID[], client, const String:gameSettings[], Handle:dataPack)
{
	if (!StrEqual(sID, GAME_ID))
		return;

	for (new i = 1; i <= MaxClients; i++)
	{
		if (!TG_IsPlayerRedOrBlue(i))
			continue;

		GivePlayerItem(i, "weapon_knife");
		SetEntityHealth(i, 35);
	}
}