/// @description Handle Async HTTP
var async_load = async_load
if !is_undefined(request_id) && async_load[? "id"] == request_id {
    var status = async_load[? "status"]
    var result = async_load[? "result"]
    var http_status = async_load[? "http_status"]
    var url = async_load[? "url"]
    
    show_debug_message("LootLocker: Response received - Status: " + string(http_status))
    
    // Handle unauthorized (expired session)
    if (http_status == 401) {
        show_debug_message("LootLocker: Session expired, storing failed request and relogging in")
        // Store failed request details
        last_failed_request = {
            url: url,
            method: async_load[? "method"],
            body: async_load[? "body"]
        }
        login()
        return
    }
    
    if (status == 0) {  // Success
        var response = json_parse(result)
        show_debug_message("LootLocker: Response data: " + json_stringify(response))
        
        // Handle login response
        if (string_pos("session/guest", url) > 0) {
            session_token = response.session_token
            save_profile()
            
            // If this was a relogin, retry the failed request
            if (!is_undefined(last_failed_request)) {
                show_debug_message("LootLocker: Retrying failed request after relogin")
                var headers = get_headers()
                request_id = http_request(
                    last_failed_request.url,
                    last_failed_request.method,
                    headers,
                    last_failed_request.body
                )
                ds_map_destroy(headers)
                last_failed_request = undefined
            }
            return
        }
        
        // Handle set name response
        if (string_pos("player/name", url) > 0) {
            player_name = response.name
            save_profile()
            show_debug_message("LootLocker: Player name updated to: " + string(player_name))
            return
        }
        
        // Handle submit score response
        if (string_pos("submit", url) > 0) {
            show_debug_message("LootLocker: Score submitted successfully")
            return
        }
        
        // Handle leaderboard response
        if (string_pos("list", url) > 0) {
            show_debug_message("LootLocker: Leaderboard data received")
            return
        }
    } else {
        show_debug_message("LootLocker: Request failed - Status: " + string(status))
    }
    
    request_id = undefined
}
