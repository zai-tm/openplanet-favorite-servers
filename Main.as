ServerList serv;
bool list_visible = false;
void RenderMenu() {
    auto app = cast<CTrackMania>(GetApp());
    if (UI::MenuItem("\\$26c"+Icons::Heart+"\\$z Favorite Servers", "", list_visible)) {
        list_visible = !list_visible;
    }
    auto serverInfo = cast<CGameCtnNetServerInfo>(app.Network.ServerInfo);
    if (serverInfo !is null && serverInfo.ServerLogin != "") {
        if (!serv.Check(serverInfo.ServerLogin)) {
            if (UI::MenuItem("\\$48e"+Icons::Plus+"\\$z Add server to favorites")) {
                serv.Add(serverInfo.ServerLogin, serverInfo.ServerName);
                UI::ShowNotification("Favorite Servers", "Server added to favorites!", 5000);
            }
        } else {
            if (UI::MenuItem("\\$e48"+Icons::Minus+"\\$z Remove server from favorites")) {
                serv.Remove(serverInfo.ServerLogin);
                UI::ShowNotification("Favorite Servers", "Server removed from favorites!", 5000);
            }
        }

    }
}
void RenderInterface() {
    if (!list_visible) {
        return;
    }
    auto app = cast<CTrackMania>(GetApp());
    auto api = cast<CGameManiaPlanetScriptAPI>(app.ManiaPlanetScriptAPI);
    if (list_visible) {
        if (UI::Begin("Favorite servers", list_visible, UI::WindowFlags::NoResize | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoCollapse)) {
            if (serv.list.Length != 0) {
                for (uint i = 0; i < serv.list.Length; i++) {
                    if (UI::Button(serv.list[i].name)) {
                        if (Permissions::PlayPublicClubRoom()) {
                            api.Dialog_JoinServer(serv.list[i].login, "", false, false, "", false, false);
                        }
                    }
                }
            } else {
                UI::Text("No favorite servers! \nTo add a server, join it and click the \"Add server to favorites\" menu item.");
            }
        }
    }
    UI::End();
}

void Main() {
    serv.Load();
}