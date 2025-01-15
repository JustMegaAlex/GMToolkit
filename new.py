import requests
import json
import os
from functools import wraps
from typing import Optional, Dict, Any


class LootLockerAPI:
    def __init__(self, player_identifier: Optional[str] = None):
        self.base_url = 'https://utu58lsp.api.lootlocker.io/'
        self.game_key = 'dev_5c2f8c7dbe9c4f6d955cf9aa3c51895b'
        self.game_version = '0.1'
        self.leaderboard_id = '24999'
        self.player_identifier = player_identifier
        self.profile_file = 'auth_data_guest.json'
        self.session_token = None
        self.player_name = None
        self._load_profile()

    def _load_profile(self) -> None:
        """Load profile from file if exists, otherwise create new profile via guest login"""
        if os.path.exists(self.profile_file):
            with open(self.profile_file, 'r') as f:
                data = json.load(f)
                self.session_token = data.get('session_token')
                self.player_identifier = data.get('player_identifier')
                self.player_name = data.get('player_name')
                self.public_uid = data.get('public_uid')
        else:
            self.login()

    def _save_profile(self) -> None:
        """Save current session data to profile file"""
        with open(self.profile_file, 'w') as f:
            json.dump({
                'session_token': self.session_token,
                'player_identifier': self.player_identifier,
                'player_name': self.player_name
            }, f)

    def _get_headers(self) -> Dict[str, str]:
        """Get headers with current session token"""
        headers = {
            "Content-Type": "application/json",
            "x-game-key": self.game_key
        }
        if self.session_token:
            headers["x-session-token"] = self.session_token
        return headers

    def relogin_if_expired(func):
        """Decorator to handle expired sessions"""
        @wraps(func)
        def wrapper(self, *args, **kwargs):
            response = func(self, *args, **kwargs)
            if response.status_code == 401:
                self.login()
                response = func(self, *args, **kwargs)
            return response
        return wrapper

    def login(self) -> requests.Response:
        """Login as guest or existing player"""
        endpoint = f"{self.base_url}game/v2/session/guest"
        payload = {
            "game_key": self.game_key,
            "game_version": self.game_version,
        }
        
        if self.player_identifier:
            payload["player_identifier"] = self.player_identifier

        response = requests.post(endpoint, json=payload, headers={"Content-Type": "application/json"})
        
        if response.status_code == 200:
            data = response.json()
            self.session_token = data["session_token"]
            self._save_profile()
        
        return response

    @relogin_if_expired
    def set_player_name(self, name: str) -> requests.Response:
        """Set player name"""
        endpoint = f"{self.base_url}game/player/name"
        payload = {"name": name}
        response = requests.patch(endpoint, json=payload, headers=self._get_headers())
        
        if response.status_code == 200:
            self.player_name = name
            self._save_profile()
            
        return response

    @relogin_if_expired
    def submit_score(self, score: int) -> requests.Response:
        """Submit score to leaderboard"""
        endpoint = f"{self.base_url}game/leaderboards/{self.leaderboard_id}/submit"
        payload = {"score": score}
        return requests.post(endpoint, json=payload, headers=self._get_headers())

    @relogin_if_expired
    def get_leaderboard(self, count: int = 10) -> requests.Response:
        """Get leaderboard entries"""
        endpoint = f"{self.base_url}game/leaderboards/{self.leaderboard_id}/list"
        if endpoint in "https://utu58lsp.api.lootlocker.io/game/leaderboards/24999/list?count=10":
            print('yes')
        params = {"count": count}
        return requests.get(endpoint, params=params, headers=self._get_headers())

def print_json(data):
    print(json.dumps(data, indent=2))

if __name__ == '__main__':
    lootlocker = LootLockerAPI()
    name_response = lootlocker.set_player_name('Alex').json()
    print_json(name_response)
    upload_response = lootlocker.submit_score(108).json()
    print_json(upload_response)
    print_json(lootlocker.get_leaderboard().json())