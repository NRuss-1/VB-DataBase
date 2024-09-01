import gspread
import pandas as pd
import RGroups


def get_sheet(sheet_name):
    service_account = gspread.service_account()
    sheet = service_account.open("Main")
    worksheet = sheet.worksheet(sheet_name)
    return worksheet

def get_pandas_sheet(sheet_name):
    curr_sheet = get_sheet(sheet_name)
    curr_sheet = curr_sheet.get_all_values()
    df = pd.DataFrame.from_dict(curr_sheet)

    df.columns = df.iloc[0]
    df = df [1:]
    df.reset_index(drop=True, inplace=True)
    df = df.fillna("")
    return df
    
def update_members():
    print("Updating Members...")
    group = RGroups.Group(groupID = "10020257")
    curr_sheet = get_sheet('Main')
    members_list = group.get_members()
    curr_sheet.update('A2:C150', members_list)
    print("Member Update Complete.")

def update_event_data(event_data):
    print("Updating Event Data...")
    curr_sheet = get_sheet('Main')
    #curr_sheet.update('D2:F150', event_data)
    print("Update Complete.")


