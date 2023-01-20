[SettingsTab name="Edit server list"]
void RenderMenuEdit() {
    string name;
    for (uint i = 0; i < serv.list.Length; i++) {
        name = serv.list[i].name;
        bool saved = false;
        name = UI::InputText("Name##"+i, name, saved);
        if (saved) {
            serv.EditName(serv.list[i].login, name);
        }

        if (UI::Button("Remove##"+i)) {
            print("removed"+serv.list[i].name);
            serv.Remove(serv.list[i].login);
        }

        if (i+1 != serv.list.Length) {
            UI::Separator();
        }
    }
}