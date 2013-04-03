name = nil
body = nil
create = false
enable = false
moderators = {"Corik","Janesice","Shlamorel","Nekrotic","Loaghaire","Methdrone","Mortitian","Kroolintent","Jigsaws","Exsanguie","FeFe","Powertits","Albelnox","Sugjin","Pallymasta","Nekrotic","Tykimikk","Shamaniganz","Ziva","Splendamomma"}
moderator = false
POP_UP_DIALOG = nil

SLASH_GUILD_MACRO_GENERAL1 = "/GuildMacro"
SLASH_GUILD_MACRO_GENERAL2 = "/guildmacro"

function sendtospecific(macroName, destination)
    if moderator and enable then
        if GetMacroBody(macroName) then
            local messagetext = macroName.."\t"..GetMacroBody(macroName)
            SendAddonMessage("MacroName",messagetext,"WHISPER", destination)
        else
            print("GuildMacros -- Macro "..macroName.." doesn't exist silly.")
        end
    else
    print("GuildMacros -- [1] Addon may not be enabled.")
    print("GuildMacros -- [2] If addon is enabled, you don't have permission to do this.")
    end

end

function sendtoAll(macroName)
    if moderator and enable then
        if GetMacroBody(macroName) then
            local messagetext = macroName.."\t"..GetMacroBody(macroName)
            SendAddonMessage("MacroName",messagetext,"GUILD")
        else
            print("GuildMacros -- Macro "..macroName.." doesn't exist silly.")
        end
    else
    print("GuildMacros -- [1] Addon may not be enabled.")
    print("GuildMacros -- [2] If addon is enabled, you don't have permission to do this.")
    end

end

function MacroEvent(self, event, prefix, msg, channel, sender, ...)
    if prefix == "MacroName" then
        if enable then
        name,body = string.split("\t",msg)
        POP_UP_DIALOG = sender.." would like to share a '"..name.."' macro with you!"
        requestText:Clear()
        requestText:AddMessage(POP_UP_DIALOG)
        Request:Show()
        else
        print(sender.." tried to share a '"..name"' macro with you.")
        print("perhaps you should enable the guildmacro addon with /guildmacro e")
        end

    end
 end

function accepted()
    Request:Hide()
    CreateMacro(name, 1, body, 1, 1)
    name = nil
    body = nil

end

function denied()
    create = false
    Request:Hide()
    name = nil
    body = nil
end


function init()
    print("GuildMacros -- Successfully enabled")
    for key, value in next, moderators do
        if(UnitName("player") == value) then
            print("GuildMacros -- You have moderator privledges")
            moderator = true
        end
    end
    Request:RegisterEvent("CHAT_MSG_ADDON")
    Request:SetScript("OnEvent", MacroEvent);
    if moderator == false then
        print("GuildMacros -- You do not have moderator privledges")
        print("GuildMacros -- Please whisper Corik if interested in being a moderator")
    end
end
            

SlashCmdList["GUILD_MACRO_GENERAL"] = function(msg)
    local command,macroName,destination = msg:match("(%S+)%s*(%S*)%s*(.*)")
    if command == "enable" or msg == "e" then -->enables addon functionality
        if enable == true then
            print("GuildMacros -- Already enabled.")
        else
            enable = true
            init()
        end
    end
    if command == "disable" or msg == "d" then -->disables addon functionality
        if enable == false then
            print("GuildMacros -- Already disabled")
        else
            enable = false
            print("GuildMacros -- Successfully disabled")
        end
    end
    if command == "permission" or msg == "p" then -->displays permission info
    end
    if command == "sendall" then --> Sends the macro to all guild members
        if macroName then
            sendtoAll(macroName)
        else
            print("Usage: /guildmacro sendall <macro name>")
        end
    end
    if command == "sendto" then --> Sends the macro to a specific player
        if macroName and destination then
            sendtospecific(macroName, destination)
        else
            print("Usage: /guildmacro sendto <macro name> <player name>")
        end
    end
    if command == "help" or command == 'h' then --> Sends the macro to a specific player
            print("GuildMacros -- Available Commands -- ")
            print("Usage: /guildmacro e/enable")
            print("Usage: /guildmacro d/disable")
            print("Usage: /guildmacro sendto <macro name> <player name>")
            print("Usage: /guildmacro sendall <macro name>")

    end
end









