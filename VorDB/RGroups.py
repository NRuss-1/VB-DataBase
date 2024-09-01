import urllib.request
import json


class Group:
    def __init__(self, groupID):
        link = self.linkify(groupID)
        base_json = self.get_base_json(link)
        self.data = base_json['data']
        self.users = []
    
    def get_base_json(self, link):
        with urllib.request.urlopen(link) as response:
            html = response.read()
            unpacked_js = json.loads(html)
            return unpacked_js
        
    #Links for member information
    def linkify(self, ID):
        return ("https://groups.roblox.com/v1/groups/"+ID+"/users?sortOrder=Asc&limit=100")
    
    def sortKey(self, e):
        role_data = e['role']
        return role_data['rank']

    #Returns a list of members with some associated information
    def get_members(self):
        data = self.data
        data.sort(key = self.sortKey, reverse = True)
        for entry in data:
            user_data = entry['user']
            role_data = entry['role']
            self.users.append([user_data['username'], user_data['userId'], role_data['name']])
        return self.users
    
    #Returns all group roles
    def get_roles(self):
        return 1




    