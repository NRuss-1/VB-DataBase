import Authenticator
import NameCheck

main_df = Authenticator.get_pandas_sheet('Main')
log_df = Authenticator.get_pandas_sheet('EventLog')


def checkMean(num, total):
    if total == 0:
        return 0
    else:
        return num/total


def cleanParticipants():
    participants = []
    for p in log_df['Participants']:
        p = p.replace(" ", "")
        participants.append(p.split(","))
    return participants

def getEventData():
    eventdata = []
    for name in main_df['User Name']:
        hosted_sum = 0
        attended_sum = 0
        
        num_participants = 0
        formatted_participants = cleanParticipants()
        
        index = 0
        for host in log_df['Host Name']:
            sim = NameCheck.similarity(name.lower(), host.lower())
            if sim >= 0.4:
                hosted_sum += 1
                num_participants += len(formatted_participants[index])
            index += 1
        for participants in formatted_participants:
            for participant in participants:
                p_sim = NameCheck.similarity(name.lower(), participant.lower())
                
                #Testing if something is wrong
                #if (name == "Saltiza"):
                    #print(participant, p_sim)

                if p_sim >= 0.4:
                    attended_sum += 1
        
        average_attendance = checkMean(num_participants, hosted_sum)

        eventdata.append([hosted_sum,attended_sum, average_attendance, event_type])
   
    return eventdata



