# Account Login
Showing login api and updating users api

### Fetch API from Login
- docs:http://docs.parseplatform.org/rest/guide/#logging-in

### Show data
- show user name and password field
- login action to login API
    - request add a `X-Parse-Application-Id` header
    - response
        - objectId use in update user url path
        - sessionToken use in update user `X-Parse-Session-Token` header

### Fetch API from Update User
- docs:http://docs.parseplatform.org/rest/guide/#updating-users

### Show data
- show user `timezone`, `number` and `phone` field
- update action to updating users API
    - request add a `X-Parse-Session-Token` header
    - request add a `X-Parse-Application-Id` header

### ScreenShot

**Login Scene**

![login.png](./images/screenshot_login.png)

**Upate User Scene**

![update_user.gif](./images/screenshot_update_user.png)

