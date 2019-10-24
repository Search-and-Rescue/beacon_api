## Search and Rescue API
### Introduction
This API servers as the backend for Beacon, a search and rescue app.  Built with Ruby on Rails and GraphQL.

### Setup
To setup locally, run the following commands:
 - `git clone https://github.com/Search-and-Rescue/search_and_rescue_api.git`
 - `cd search_and_rescupe_api`
 - `bundle install`
 - `rails s`
 - Navigate to `localhost:300/graphiql` to view the GraphiQL, an in-browser IDE for exploring the API

### Endpoint
All requests should be made with a `POST` request to `/graphql?query=[request]`.

### User Request

**All Users:**
```
{
  users{
    id
    name
    email
  }
}
```

**Single User:**
```
{
  user(id: 1){
    id
    name
    email
  }
}
```

**Single User + Emergency Contacts:**
```
{
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
