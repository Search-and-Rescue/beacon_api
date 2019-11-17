# Beacon API

## Table of Contents
* [Introduction](#Introduction)
* [Setup](#Setup)
* [GraphQL Endpoint](#Endpoint)
* [User Requests](#User-Requests)
* [Trip Requests](#Trip-Requests)
* [Emergency Contact Requests](#Emergency-Contact-Requests)
* [Vehicle Requests](#Vehicle-Requests)
* [Gear Requests](#Gear-Requests)
* [Search and Rescue Team Requests](#Search-and-Rescue-Team-Requests)
* [Schema Diagram](#Schema-Diagram)
* [Tech Stack](#Tech-Stack)
* [Project Board](#Project-Board)
* [Beacon Development Team](#Beacon-Development-Team)
* [Front-End Repo](#Front-End-Repo)

### Introduction
This API serves as the back-end for Beacon, a search and rescue app.  Built with Ruby on Rails and GraphQL.

Knowing that out in the wilderness people often don't have access to cell phone reception, Beacon seeks to give adventurers the option of going into the unknown a bit more prepared. With this app users can pre-fill information about their trip with as much detail as they desire.

Users can enter personal information, what vehicle they are driving, information about the trip they are going on, and tell the app what gear they are taking along.

The user selects a start and end time for their trip, and then selects a notification date and time in case they don't make it back. If the user doesn't check in with the app before the notification time is up, their emergency contact/s associated with the trip will receive an email with helpful information for Search and Rescue.

The email will consist of the user's trip information: where they were planning on starting and ending their adventure, along with the vehicle driven and its details. The email will also list info about the user that would help a search and rescue team know who they are looking for. A user can enter what gear they brought along (such as how much food and water, any medications, an avalanche beacon, a down sleeping bag...) And lastly, the email will have contact info for search and rescue teams nearby to where the user went missing.

A custom Search and Rescue API for the state of Colorado was built for this app.

### Setup
To setup locally, run the following commands:
 - `git clone https://github.com/Search-and-Rescue/search_and_rescue_api.git`
 - `cd search_and_rescue_api`
 - `bundle install`
 - `rails db:{create,migrate,seed}`
 - `bundle exec rake import`
 - `rails s`
 - Navigate to `localhost:3000/graphiql` to view the GraphiQL, an in-browser IDE for exploring the API

### Endpoint
All requests should be made with a `POST` request to `/graphql?query=[request]`.

### User Requests

**All Users:**
```
query {
  users{
    id
    name
    email
  }
}
```

**Get Single User:**
```
query {
  user(id: 1){
    id
    name
    email
    city
    state
    email
  }
}
```

**Create User:**
```
mutation {
  createUser( input: {
    id: 1
    name: "name"
    address: "address"
    city: "city"
    state: "state"
    zip: zip
    email: "email@example.com"
  }) {
    user {
      id
      name
      address
      city
      state
      zip
      email
    }
  }
}
```

**Update User:**
```
mutation {
  updateUser( input: {
    id: 1
    name: "name"
    address: "address"
    city: "city"
    state: "state"
    zip: zip
    email: "email@example.com"
  }) {
    user {
      id
      name
      address
      city
      state
      zip
      email
    }
  }
}
```

### Trip Requests

**All Trips for a User:**
```
query {
  user(id: 1) {
    trips{
      id
      name
      travelingCompanions
      }
    }
  }
}  

```

**Single Trip:**
```
query {
  trip(id: 1){
    name
    startDate
    startTime
    endDate
    endTime
    }
  }
}

```

**Create Trip:**
```
mutation {
 createTrip(input: {
   name: "Spanish Peaks Backpacking Trip"
   startingPoint: "Coyote Trail Head"
   endingPoint: "Coyote Trail Head"
   startDate: "May 1, 2020"
   startTime: "08:00"
   endDate: "May 3, 2020"
   endTime: "22:00"
   notificationDate: "May 4, 2020"
   notificationTime: "15:00"
   travelingCompanions: 0
   userId: 1
 }) {
   trip {
      id
      name
      startingPoint
      endingPoint
      startDate
      startTime
      endDate
      endTime
      notificationDate
      notificationTime
      travelingCompanions
    }
  }
}
```

**Update Trip**
```
mutation {
 upateTrip(input: {
   name: "Spanish Peaks Backpacking Trip"
   startingPoint: "Coyote Trail Head"
   endingPoint: "Coyote Trail Head"
   startDate: "May 1, 2020"
   startTime: "08:00"
   endDate: "May 3, 2020"
   endTime: "22:00"
   notificationDate: "May 4, 2020"
   notificationTime: "15:00"
   travelingCompanions: 2
   userId: 1
 }) {
   trip {
      id
      name
      startingPoint
      endingPoint
      startDate
      startTime
      endDate
      endTime
      notificationDate
      notificationTime
      travelingCompanions
    }
  }
}
```

**Remove a Trip**
```
mutation {
  removeTrip(input: {
    id: 1
  }) {
    trip{
      id
      name
    }
  }
}
```

### Add To Trip Requests

**Add Gear to a Trip**
```
mutation {
  addGearToTrip(input: {
    tripId: 1
    gearId: 1
    comments: "Comment here"
  }) {
    tripGear{
      comments
      gear{
        itemName
      }
      trip{
        name
      }
    }
  }
}
```

**Add Vehicle to a Trip**
```
mutation {
  addVehicleToTrip(input: {
    tripId: 1
    vehicleId: 1
  }) {
    trip{
      name
    }
    vehicle{
      make
    }
  }
}
```

**Add Contact to a Trip**
```
mutation {
  addContactToTrip(input: {
    emergencyContactId: 5
    tripId: 2
  }) {
    trip{
      name
    }
    emergencyContact{
      name
      phone
    }
  }
}
```
### Emergency Contact Requests

**All Emergency Contacts for a User:**
```
query {
  user(id: 1){
    id
    name
    email
    emergencyContacts{
      id
      name
      phone
      email
    }
  }
}
```

**Get Single Emergency Contact:**
```
query {
  contact(id: 1){
    name
    phone
    email
    }
  }
}
```

**Add Emergency Contact**
```
mutation {
  createContact(input: {
    name: "name"
    phone: "phone"
    email: "email@example.com"
    userId: 1
  }) {
    emergencyContact {
      id
      name
      phone
      email
    }
  }
}
```

**Update Emergency Contact**
```
mutation {
   updateContact(input: {
       id: 1
       userId: 1
       name: "name"
       phone: "phone"
       email: "email@example.com"
  }) {
    emergencyContact {
       name
       phone
       email
    }
  }
}
```

**Remove Emergency Contact**
```
mutation {
  removeContact( input: {
    id: 1 }){
    contact {
      id
      name
      phone
      email
    }
  }
}
```

### Vehicle Requests

**All Vehicles for a User:**
```
query {
  user(id: 1) {
    veicles{
      id
      make
      model
      year
      color
      licensePlate
      }
    }
  }
}
```
**Single Vehicle:**
```
query {
  vehicle(id: 1){
    make
    model
    year
    color
    licensePlate
  }
}
```

**Create Vehicle**
```
mutation {
  createVehicle(input: {
    make: "Ford"
    model: "F150"
    year: 2010
    color: "silver"
    licensePlate: "CYE 909"
    userId: 1
  }) {
    vehicle {
      id
      make
      model
      year
      color
      licensePlate
    }
  }
}
```

**Update Vehicle**
```
mutation {
  updateVehicle(input: {
    make: "Ford"
    model: "F150"
    year: 2015
    color: "silver"
    licensePlate: "CYE 909"
    userId: 1
  }) {
    vehicle {
      id
      make
      model
      year
      color
      licensePlate
    }
  }
}
```

**Remove Vehicle**
```
mutation {
  removeVehicle( input: {
    id: 2 }){
    vehicle {
      id
      make
      model
      year
      color
      licensePlate
    }
  }
}
```

### Gear Requests

**All Gear for a User:**
```
query {
  user(id: 1) {
    gear{
      id
      itemName
      }
    }
  }
}
```
**Single Piece of Gear:**
```
{
  gear(id: 1){
    itemName
  }
}
```

**Create Gear**
```
mutation {
  createGear(input: {
    itemName: "sleeping bag"
    userId: 1
  }) {
    gear {
      id
      itemName
    }
  }
}
```

**Update Gear**
```
mutation {
  updateGear(input: {
    itemName: "0 degree sleeping bag"
    userId: 1
  }) {
    gear {
      id
      itemName
    }
  }
}
```

**Remove Gear**
```
mutation {
  removeGear( input: {
    id: 2 }){
    gear {
      itemName
    }
  }
}
```

### Search and Rescue Team Requests

**Get All Teams:
```
query {
  teams {
    teamName
    county
    contact
    contactNumber
    city
    state
  }
}
```

**Get Single Team:**
```
query {
  team(id: 1) {
    teamName
    county
    contact
    contactNumber
    city
    state
  }
}
```

### Testing
* To run the testing suite, type `rspec` into your command line.
* To open the coverage report, type `open coverage/index.html` into the CLI.

### Schema Diagram
(For additional information in your queries and mutations)

![Beacon Schema](/schema_diagram.png?raw=true "Beacon Schema")


### Tech Stack

* Rails 5.2.3
* Ruby 2.4.9
* GraphQL
* Google Places API
* TravisCI
* PostgreSQL database
* Sinatra to host a micro-service API that manages a SendGrid emailing service

[View the Sinatra micro-service's repo here](https://github.com/Search-and-Rescue/beacon_email_service)

### Project Board

[Click here to see the Beacon Project Board](https://github.com/orgs/Search-and-Rescue/projects/1)

### Beacon Development Team

- [Tyler Bierwirth](https://github.com/tbierwirth)
- [Jori Peterson](https://github.com/JoriPeterson)
- [Katherine Williams](https://github.com/kawilliams8)
- [Samantha Freeman](https://github.com/SamanthaLFreeman)

### Front-End Repo

[View Beacon's Front-End Repo Here to see the app in action!](https://github.com/Search-and-Rescue/SearchAndRescue-FE)
