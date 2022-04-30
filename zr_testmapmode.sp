#include <sourcemod>
#include <zombiereloaded>
#include <cstrike>

bool bTestMap = false;

public Plugin myinfo =
{
	name = "ZR Test Map Mode",
	author = "Oylsister",
	description = "",
	version = "1.0",
	url = ""
};

public void OnPluginStart()
{
    RegAdminCmd("testmap", Command_TestMap, ADMFLAG_CHANGEMAP);
    HookEvent("round_start", OnRoundStart);
}

public void OnMapStart()
{
    bTestMap = false;
}

public void OnRoundStart(Event event, const char[] name, bool dontBroadcast)
{
    PrintToChatAll(" \x04[ZR]\x01 The current round is enabled test mode by Admin.");
}

public Action Command_TestMap(int client, int args)
{
    bTestMap = !bTestMap;

    if(bTestMap)
    {
        PrintToChatAll(" \x04[ZR]\x01 Admin \x5%N\x01 has enabled test mode for this map!", client);
        for(int i = 1; i < MaxClients; i++)
        {
            if(!IsClientInGame(i))
                continue;

            if(!IsPlayerAlive(i))
                continue;

            if(ZR_IsClientHuman(i))
                continue;

            if(ZR_IsClientZombie(i))
                ZR_HumanClient(i);
        }
        return Plugin_Handled;
    }

    else
    {
        PrintToChatAll(" \x04[ZR]\x01 Admin \x5%N\x01 has disabld test mode for this map!", client);
        return Plugin_Handled;
    }
}

public Action CS_OnTerminateRound(float &delay, CSRoundEndReason &reason)
{
    if(bTestMap)
        return Plugin_Handled;

    return Plugin_Continue;
}

public Action ZR_OnClientInfect(int &client, int &attacker, bool &motherinfect, bool &override, bool &respawn)
{
    if(bTestMap)
        return Plugin_Handled;

    return Plugin_Continue;
}