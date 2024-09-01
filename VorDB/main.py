import Authenticator
import EventHandler
import NetworkToggler
import multiprocessing

#Update all information (takes some time)
NetworkToggler.toggle()
update_all = False

#Add or removes members from the sheet depending on if they're in the group
NetworkToggler.toggle()
update_current_members = False

#Updates events hosted and/or attended
NetworkToggler.toggle()
update_event_data = True


if __name__ == '__main__':
    print("Initializing...")
    if update_all == True:
        processor = multiprocessing.Process(target = Authenticator.update_members)
        processor.start()
        processor.join()
        
        event_data = EventHandler.getEventData()
        Authenticator.update_event_data(event_data)
 
    if update_event_data == True:
        event_data = EventHandler.getEventData()
        Authenticator.update_event_data(event_data)

    if update_current_members == True:
        Authenticator.update_members()