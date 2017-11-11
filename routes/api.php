<?php

use Illuminate\Http\Request;


// this is the route of auth user with passport with header request access_token
Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

// this route for getting all private and public tasks for the auth user with passport 
Route::middleware('auth:api')->get("/get_all_tasks","taskController@get_all_tasks");


// user routes
Route::post("/register","registerController@register");
Route::post("/login","registerController@login");

//tasks route

Route::group(['prefix' => '/'], function () {
    
    Route::post('createtask', 'taskController@createtask');
    Route::post('get_single_tasks', 'taskController@get_single_tasks');
    Route::post('taskupdate', 'taskController@taskupdate');
    Route::post('removetask', 'taskController@removetask');
    Route::post('togglestatus', 'taskController@togglestatus');
    Route::post('searchuser', 'registerController@searchuser');
    
    Route::get("createtask",function(){ echo "this app is designed for api you can use post method to get result"; });
    Route::get("get_single_tasks",function(){ echo "this app is designed for api you can use post method to get result"; });
    Route::get("taskupdate",function(){ echo "this app is designed for api you can use post method to get result"; });
    Route::get("removetask",function(){ echo "this app is designed for api you can use post method to get result"; });
    Route::get("togglestatus",function(){ echo "this app is designed for api you can use post method to get result"; });
    Route::get("searchuser",function(){ echo "this app is designed for api you can use post method to get result"; });
    Route::get("/getsecret",function(){ echo "this app is designed for api you can use post method to get result"; });

});





// get app client_id and client_secret
Route::post("/getsecret","registerController@getappsecret");
        
