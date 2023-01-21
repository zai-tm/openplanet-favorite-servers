class ServerList {
    ServerInstance@[] list;

    void Load() {
        string path = IO::FromStorageFolder("ServerList.json");

        auto json = Json::FromFile(path);
        if (json.GetType() == Json::Type::Null) {
        	return;
        }

        if (json.GetType() != Json::Type::Object) {
            return;
        }

        auto servers = json.Get("servers", Json::Array());
        for (uint i = 0; i < servers.Length; i++) {
            list.InsertLast(ServerInstance(servers[i].Get("login"), servers[i].Get("name")));
        }
    }

    bool Check(string _inputLogin) {
        string path = IO::FromStorageFolder("ServerList.json");
        auto json = Json::FromFile(path);

        if (json.GetType() == Json::Type::Null) {
        	return false;
        }

        if (json.GetType() != Json::Type::Object) {
            return false;
        }

        auto servers = json.Get("servers", Json::Array());
        for (uint i = 0; i < servers.Length; i++) {
            if (_inputLogin == servers[i].Get("login")) {
                return true;
            }
        }
        return false;
    }

    bool Check (int _inputNadeoRoomId) {
        return false;
    }

    void Save() {
        string path = IO::FromStorageFolder("ServerList.json");
        auto json = Json::Object();
        auto servers = Json::Array();

        for (uint i = 0; i < list.Length; i++) {
            auto server = Json::Object();
            server["login"] = list[i].login;
            server["name"] = list[i].name;
            servers.Add(server);
        }

        json["servers"] = servers;
        Json::ToFile(path, json);
    }

    void Add(string _inputLogin, string _inputName) {
        list.InsertLast(ServerInstance(_inputLogin, _inputName));
        Save();
    }

    void Remove(string _inputLogin) {
        for (uint i = 0; i < list.Length; i++) {
            if (list[i].login == _inputLogin) {
                list.RemoveAt(i);
            }
        }
        Save();
    }

    void EditName(string _inputLogin, string _newName) {
        for (uint i = 0; i < list.Length; i++) {
            if (list[i].login == _inputLogin) {
                list[i].name = _newName;
            }
        }
        Save();
    }
}

class ServerInstance {
    ServerInstance(const string&in inputLogin, const string &in inputName) {
        login = inputLogin;
        name = inputName;
    }
    string login;
    string name;
}