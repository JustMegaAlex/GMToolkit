if !EnsureSingleton()
    exit

// Constants
base_url = "https://utu58lsp.api.lootlocker.io/"
game_key = "dev_5c2f8c7dbe9c4f6d955cf9aa3c51895b"
game_version = "0.1"
leaderboard_id = "24999"

// State
player_identifier = undefined
session_token = undefined
player_name = undefined
request_id = undefined
last_failed_request = undefined

// Load saved session
profile_file = "auth_data_guest.json"
if (file_exists(profile_file)) {
    var file = file_text_open_read(profile_file)
    var json_str = file_text_read_string(file)
    file_text_close(file)
    
    var data = json_parse(json_str)
    session_token = data[$ "session_token"]
    player_identifier = data[$ "player_identifier"]
    player_name = data[$ "player_name"]
    show_debug_message("LootLocker: Loaded profile with session token: " + string(session_token))
} else {
    show_debug_message("LootLocker: No profile found, starting new session")
    login()
}

// Helper functions
save_profile = function() {
    var file = file_text_open_write(profile_file)
    file_text_write_string(file, json_stringify({
        session_token: session_token,
        player_identifier: player_identifier,
        player_name: player_name
    }))
    file_text_close(file)
    show_debug_message("LootLocker: Profile saved")
}

get_headers = function() {
    var headers = ds_map_create()
    ds_map_add(headers, "Content-Type", "application/json")
    ds_map_add(headers, "x-game-key", game_key)
    if (!is_undefined(session_token)) {
        ds_map_add(headers, "x-session-token", session_token)
    }
    return headers
}

// API Methods
login = function() {
    var endpoint = base_url + "game/v2/session/guest"
    var payload = {
        game_key: game_key,
        game_version: game_version
    }
    if (!is_undefined(player_identifier)) {
        payload.player_identifier = player_identifier
    }
    
    var headers = get_headers()
    request_id = http_request(endpoint, "POST", headers, json_stringify(payload))
    show_debug_message("LootLocker: Login request sent")
    ds_map_destroy(headers)
}

set_player_name = function(name) {
    var endpoint = base_url + "game/player/name"
    var headers = get_headers()
    request_id = http_request(endpoint, "PATCH", headers, json_stringify({
        name: name
    }))
    show_debug_message("LootLocker: Set player name request sent: " + string(name))
    ds_map_destroy(headers)
}

submit_score = function(score) {
    var endpoint = base_url + "game/leaderboards/" + leaderboard_id + "/submit"
    var headers = get_headers()
    request_id = http_request(endpoint, "POST", headers, json_stringify({
        score: score
    }))
    show_debug_message("LootLocker: Submit score request sent: " + string(score))
    ds_map_destroy(headers)
}

get_leaderboard = function(count = 10) {
    var endpoint = base_url + "game/leaderboards/" + leaderboard_id + "/list?count=" + string(count)
    var headers = get_headers()
    request_id = http_request(endpoint, "GET", headers, "")
    show_debug_message("LootLocker: Get leaderboard request sent, count: " + string(count))
    ds_map_destroy(headers)
}
