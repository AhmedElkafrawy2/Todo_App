

register user

method:post
url :http://localhost:8000/api/register
data required in body:

{
	"username" : "hassan",
	"email":"hassan@hassan.com",
	"password":"ahmed607080"

}

response:

"status": ""



-------------------------------------------------------------------------------------
login with facebook

method:get
url :http://localhost:8000 => click on btn to register

http:localhost:8000/api/auth/facebook  => to get the user  from facebbok

http:localhost:8000//api/callback  => to insert user info from facebbok 



--------------------------------------------

auth user with passport

1) get the clinet id and client secret

method post
utl : http:localhost:8000/api/getsecret

response {
	
	client_id : 
	client_secret:
}

2) get access token

method post

url http://localhost:8000/oauth/token

data required 

{
	"grant_type":"password",
	"client_id":"", from step 1
	"client_secret":"", from step 1
	"username":"",
	"password":"",
	"scope" : "*"
}

response 

{
    "token_type": "Bearer",
    "expires_in": ,
    "access_token": "",
    "refresh_token": ""
}

3)

url : url http://localhost:8000/api/user

method : get

data required : in header

Authorization  = Bearer access_token




--------------------------------------------


login user

method:post
url :http://localhost:8000/api/login

data required in body:

{
    "email":"",
	"password":""
}

response:
{
    "status": "1",
    "user": {
        "user_id": ,
        "user_email": "",
        "user_token": "",
        "username": "",
        "created_at": {
            "date": "",
            "timezone_type": ,
            "timezone": ""
        },
        "last_update": {
            "date": "",
            "timezone_type": ,
            "timezone": ""
        }
    }
}

---------------------------------------------------------

get_single_tasks


method:post
url :http://localhost:8000/api/get_single_tasks

data required in body:

note : token in data requird is optional but if this task is private or token is not equal user id who post the task the response will be can not access

{
	
  "task_id" : "1",
  "token" : ""

}

response:

{
    "status": "",
    "task": {
        "task_id": ,
        "task_title": "",
        "task_body": ,
        "is_closed": ,
        "task_create_time": {
            "date": "",
            "timezone_type": ,
            "timezone": ""
        },
        "task_update_time": {
            "date": "",
            "timezone_type": ,
            "timezone": ""
        }
    }
}

---------------------------------------------------------------------

createtask


method:post
url :http://localhost:8000/api/createtask

data required in body:



{
	
   "title":"",
   "body":"",
   "token":"",
   "is_public":true,
   "is_closed":false,
   "deadline":"2014-04-01 12:00:33"

}

response:

{
  "status":"1"
}

---------------------------------------------------------------------

taskupdate


method:post
url :http://localhost:8000/api/taskupdate

data required in body:


{
	
   "title":"",
   "body":"",
   "task_id":1,
   "token":"",
   "is_public":true,                optional
   "is_closed":true,                optional
   "deadline":"yyyy-MM-dd hh:mm:ss" optional
   "files" : "" 		            optional

}

response:

{
  "status":"1"
}

---------------------------------------------------------------------

taskupdate


method:post
url :http://localhost:8000/api/taskupdate

data required in body:


{
	
   "title":"",
   "body":"",
   "task_id":1,
   "token":"",
   "is_public":true,                optional
   "deadline":"yyyy-MM-dd hh:mm:ss" optional
   "files" : "" 		            optional

}

response:

{
  "status":"1"
}

---------------------------------------------------------------------

removetask


method:post
url :http://localhost:8000/api/removetask

data required in body:


{
	

   "task_id":1,
   "token":"",


}

response:

{
  "status":"1"
}

---------------------------------------------------------------------

togglestatus


method:post
url :http://localhost:8000/api/togglestatus

data required in body:


{
	

   "task_id":1,
   "token":"",
   "is_closed":true


}

response:

{
  "status":"1"
}

---------------------------------------------------------------------

searchuser

hint : this function will return only public tasks
method:post
url :http://localhost:8000/api/searchuser

data required in body:


{

	"username" : "" or
	"email" : ""
}

response:

{
    "allusers": [
        {
            "status": "1",
            "user": {
                "user_id": ,
                "user_email": "",
                "username": "",
                "created_at": {
                    "date": "2017-11-11 10:05:23.000000",
                    "timezone_type": 3,
                    "timezone": "UTC"
                },
                "last_update": {
                    "date": "2017-11-11 10:05:23.000000",
                    "timezone_type": 3,
                    "timezone": "UTC"
                }
            }
        },
        {
            "status": "1",
            "user": {
                "user_id": ,
                "user_email": "",
                "username": "",
                "created_at": {
                    "date": "2017-11-11 11:15:31.000000",
                    "timezone_type": 3,
                    "timezone": "UTC"
                },
                "last_update": {
                    "date": "2017-11-11 11:15:31.000000",
                    "timezone_type": 3,
                    "timezone": "UTC"
                }
            }
        },
        {
            "status": "1",
            "user": {
                "user_id": ,
                "user_email": "",
                "username": "",
                "created_at": {
                    "date": "2017-11-11 11:56:15.000000",
                    "timezone_type": 3,
                    "timezone": "UTC"
                },
                "last_update": {
                    "date": "2017-11-11 11:56:15.000000",
                    "timezone_type": 3,
                    "timezone": "UTC"
                }
            }
        }
    ],
    "alltasks": [
        {
            "task_id": 1,
            "task_title": "",
            "task_body": "",
            "task_created_at": {
                "date": "2017-11-11 10:05:58.000000",
                "timezone_type": 3,
                "timezone": "UTC"
            },
            "task_updated_at": {
                "date": "2017-11-11 10:08:48.000000",
                "timezone_type": 3,
                "timezone": "UTC"
            }
        },
        {
            "task_id": 2,
            "task_title": "",
            "task_body": "",
            "task_created_at": {
                "date": "2017-11-11 11:56:42.000000",
                "timezone_type": 3,
                "timezone": "UTC"
            },
            "task_updated_at": {
                "date": "2017-11-11 11:56:42.000000",
                "timezone_type": 3,
                "timezone": "UTC"
            }
        },
        {
            "task_id": 4,
            "task_title": "",
            "task_body": "",
            "task_created_at": {
                "date": "2017-11-11 11:57:42.000000",
                "timezone_type": 3,
                "timezone": "UTC"
            },
            "task_updated_at": {
                "date": "2017-11-11 11:57:42.000000",
                "timezone_type": 3,
                "timezone": "UTC"
            }
        }
    ]
}