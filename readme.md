Inroduction 

-- you can use postman to test this api
and put in any header request

accept key with value application/json
accept content-type with value application/json

-- this is the constants i used to make response

    'generals' => [
        
        'success'           =>    '1',
        'fill_all_fields'   =>    '-1',
        'not_found'         =>    '-2',
        'duplicated'        =>    '-3',
        'operation_failed'  =>    '-4',
        'invalid_type'      =>    '-5',
        'cannot_access'     =>    '-6',
        'date_time_notmatch'=>    '-7',
        ]

-- i used two types of authentication user
    first is passport auth and used it at get all tasks for auth user this route will be 
    protected with middleware auth:api
    
    secund is to use token provided to the user when register and send this token
    if it is wanted and depending on this token get user who post the task if it match 
    provide the private task else provide public  task

---------------------------------

register user function

method  => post
url   => http://localhost:8000/api/register
data required in request body =>

{
	"username" : "",
	"email"    :"",
	"password" :""

}

response =>
{

"status": ""

}


-------------------------------------------------------------------------------------
login with facebook


click on the below url to get link login with facebook

url => http://localhost:8000 => click on btn to register

url => http:localhost:8000/auth/facebook  => method => get to get the  facebbok page

url => http:localhost:8000/callback  => to insert user info from facebbok 



--------------------------------------------

Auth user with Laravel Passport

1) get the clinet id and client secret

method => post
utl    => http:localhost:8000/api/getsecret

response {
	
	client_id : ""
	client_secret: ""
}

2) get access token

method => post

url    => http://localhost:8000/oauth/token

data required in request body =>

{
	"grant_type"   : "password",
	"client_id"    : "",           hint : from step 1
	"client_secret": "",           hint : from step 1
	"username"     : "",
	"password"     : "",
	"scope"        : "*"
}

response =>

{
    "token_type": "Bearer",
    "expires_in": ,
    "access_token": "",
    "refresh_token": ""
}

3)

 url  => http://localhost:8000/api/user

method => get

data required  in request header =>

Authorization key with value Bearer access_token   


hint : do not change Bearer and access_token from step number 2


--------------------------------------------


get user info user

method =>post

url => http://localhost:8000/api/login

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
--------------------------------------------------------

get_all_tasks of auth user with passport

note : you don't need to post user_id because you will send the access_token in
request header of the auth user to get all task else the response will be not authorized

method => get
url    => http://localhost:8000/api/get_all_tasks


response:

{
{
    "status": "1",
    "all_tasks": {
        "id"      : ,
        "user_id" : ,
        "task_title" : "",
        "task_body"  : "",
        "task_files" : "",
        "is_public"  : ,
        "is_closed"  : ,
        "task_deadline": "",
        "created_at": "",
        "updated_at": ""
    }
}
}

---------------------------------------------------------

get_single_tasks


method  => post
url     => http://localhost:8000/api/get_single_tasks



note : token in data requird is optional but if this task is private or token is not equal user id who post the task the response will be can not access

data required in reuest body =>
{
	
  "task_id" : "",
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
        "task_files": ,
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

Create new Task

Hint => when sending files with task

this is the advice of sending these files in jquery file
            
           var files = event.targets.files;
           var data = new FormDate()
           var Numbers = "";
           $.each(files , function(k , v){          
               data.append(k , v);
              
               Numbers = k;
           });
           if(numbers !== ""){
            data.append('FilesNumber',Numbers);
           }



method  => post
url     =>   http://localhost:8000/api/createtask

data required in request body:

{
	
   "title"     :  "",
   "body"      :  "",
   "token"     :  "",
   "is_public" :  true,
   "is_closed" :  false,
   "deadline"  :  ""       deadline in formate yy-MM-dd hh:mm:ss

}

response:

{
  "status":"1"
}

---------------------------------------------------------------------

Update the Task


method => post
url    => http://localhost:8000/api/taskupdate

data required in body request body:

{
	
   "title"     :"",
   "body"      :"",
   "task_id"   :1,
   "token"     :"",
   "is_public" :true,                       optional
   "is_closed" :true,                       optional
   "deadline"  :"yyyy-MM-dd hh:mm:ss"       optional
   "files"     : "" 		            optional

}

response:

{
  "status":"1"
}


---------------------------------------------------------------------

Remove the task


method  => post
url     => http://localhost:8000/api/removetask

data required in requested body =>

{
	

   "task_id":1,
   "token":"",


}

response:

{
  "status":"1"
}

---------------------------------------------------------------------

Toggle Status of the task


method => post
url    => http://localhost:8000/api/togglestatus

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

Search for user

Hint   => this function will return The users Founded and their public tasks
Method => post
url    => http://localhost:8000/api/searchuser

data required in body:


{

	"username" : "" or
	"email" : ""
}

response:

{
    "allusers": [
        {
            "status"  : "1",
            "user": {
                "user_id"   : ,
                "user_email": "",
                "username"  : "",
                "created_at": {
                    "date"  : "2017-11-11 10:05:23.000000",
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
