<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests\CreateTaskRequest;
use App\Task;
use App\User;
use DateTime;
class taskController extends Controller
{
    // function to create user into database
   public function createtask(CreateTaskRequest $request){
       
       $title   = $request->title;
       $body     = $request->body;
       $token        = $request->token;
       $public = $request->is_public;
       $closed = $request->is_closed;
       $deadline = $request->deadline;
       
        // check if the dead line of the task match this formate "2014-04-01 12:00:00"

        if(!preg_match('/(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/',$deadline)){
            
           return response()->json(['status'=>config('constants.generals.date_time_notmatch')]);
        }

        //print_r($matches);
       $task = new Task;
       $user = User::where(["token" => $token])->first();
       
       if(!$user){
           return response()->json(['status'=>config('constants.generals.not_found')]);
       }else{
           
           // get the user email from the requested token
           $useremail = $user->email;
           
           //make date time formate
           $format = 'Y-m-d H:i:s';
           $date = DateTime::createFromFormat($format, $deadline);
           
           // check if the user send files with the task request
           
           $Arrayoffiles = "|";
           if($request->hasFile('0')){

               $numersofimages = $request->input("numerofimages");
               if (! File::exists(public_path()."/images/". $useremail)) {
                    File::makeDirectory(public_path()."/images/". $useremail);
               }

               for($i = 0; $i <= $numersofimages ; $i++){

                    $file = $request->file($i);
                    $imagename = time()."-".$file->getClientOriginalName();
                    $file->move(public_path("/images/" . $useremail), $imagename);
                    $arrayofimages .= $imagename . "|";
                    
               }
             }

            $Arrayoffiles =  rtrim($Arrayoffiles, "|");
            $Arrayoffiles =  ltrim($Arrayoffiles, "|");
           
           // insert task into database
           $user_id = $user->id;
           $task->task_title = $title;
           $task->task_body = $body;
           $task->user_id = $user_id;
           $task->is_public = $public;
           $task->is_closed = $closed;
           $task->task_deadline = $date;
           $task->task_files = $Arrayoffiles;
           
           $task->save();
           return response()->json(["status" => config('constants.generals.success')]);
           
       }
   }
   
   // this function is to return one taskes
   public function get_single_tasks(Request $request){
       
       $taskid = $request->task_id;
       $token = $request->token;
       
       $task = Task::where(["id" => $taskid])->first();
       if(!$task){
           
           return response()->json(['status'=>config('constants.generals.not_found')]);
       }
       
       if($task->is_public == 0){
           
          // get the user who post the task
          $user_posted_task_id = $task->user_id;
          
          if(!isset($token)){
             return response()->json(['status'=>config('constants.generals.cannot_access')]); 
          }else{
              
              // get user id from requested token
              $user_data_from_token = User::where(["token" => $token])->first();
              $user_data_from_token = $user_data_from_token->id;
              if($user_data_from_token == $user_posted_task_id){
                    return $this->gettaskinformation($task,false);
                 }else{
                     return response()->json(['status'=>config('constants.generals.cannot_access')]);
                 }    
          }

       }else{
           
           return $this->gettaskinformation($task,false);
       }
 
   }
   
   // this function is to return response contain task info
   
   protected function gettaskinformation($task,$ispublic){
     $response = 
        response()->json(['status'=>config('constants.generals.success'),
          'task'=>[
              'task_id'=>$task->id,
              'task_title'=>$task->task_title,
              'task_body'=>$task->task_body,
              'is_public'=>$ispublic,
              'is_closed'=>$task->is_closed,
              'task_create_time'=>$task->created_at,
              'task_update_time'=>$task->updated_at,
          ]
        ]);
    return $response;
   }
   
   // function to update task
   
   function taskupdate(Request $request){
       
       
       $title    = $request->title;
       $body     = $request->body;
       $token    = $request->token;
       $taskid   = $request->task_id;
       $public = $request->is_public;
       $closed = $request->is_closed;
       $deadline = $request->deadline;
       
       if(!isset($title) || !isset($token)){
           return response()->json(['status'=>config('constants.generals.fill_all_fields')]);
       }
       
        // check if the dead line of the task match this formate "2014-04-01 12:00:00"

        if(!preg_match('/(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/',$deadline)){
            
           return response()->json(['status'=>config('constants.generals.date_time_notmatch')]);
        }
        
        
       $task = Task::where(["id" => $taskid])->first();
       
       if(!$task){
           
           return response()->json(['status'=>config('constants.generals.not_found')]);
       }
       
       // gey the user who post the task
       $user_posted_task_id = $task->user_id;
       
        // get user id from requested token
       
       if(!isset($token)){
           return response()->json(['status'=>config('constants.generals.cannot_access')]);
       }else{
       $user_data_from_token = User::where(["token" => $token])->first();
       if(!$user_data_from_token){
           return response()->json(['status'=>config('constants.generals.not_found')]);
       }
       $user_data_from_token = $user_data_from_token->id;
       if($user_data_from_token == $user_posted_task_id){
            
           // get the data requested
           $inserted_body = isset($body)?$body:$task->body;
           $inserted_is_public = isset($public)?$public:$task->is_public;
           $inserted_deadline = isset($deadline)?$deadline:$task->task_deadline;
           $inserted_closed = isset($closed)?$closed:$task->is_closed;
           
           // get the files requested
           
           $insertedfile;
           if(isset($request->files)){
           $Arrayoffiles = "|";
           
               if($request->hasFile('0')){

               $numersofimages = $request->input("numerofimages");
               if (! File::exists(public_path()."/images/". $useremail)) {
                    File::makeDirectory(public_path()."/images/". $useremail);
               }

               for($i = 0; $i <= $numersofimages ; $i++){

                    $file = $request->file($i);
                    $imagename = time()."-".$file->getClientOriginalName();
                    $file->move(public_path("/images/" . $useremail), $imagename);
                    $arrayofimages .= $imagename . "|";
                    
                   }
               }
                    $Arrayoffiles =  rtrim($Arrayoffiles, "|");
                    $Arrayoffiles =  ltrim($Arrayoffiles, "|");
                    $insertedfile = $Arrayoffiles;
                    
             }else{
                 
                 $insertedfile = $task->task_files;
             }
            
           
           // get the current time
           $format = 'Y-m-d H:i:s';
           $objDateTime = new DateTime('NOW');
           $updatetime = $objDateTime->format($format);
           // update the task

           Task::where(["id" => $taskid])
                   ->update([
                       'task_title' => $title , 
                       'task_body' => $inserted_body,
                       'is_public' => $inserted_is_public,
                       'is_closed' => $inserted_closed,
                       'task_deadline' => $inserted_deadline,
                       'task_files' => $insertedfile,
                       'created_at' => $updatetime,
                       ]);
           
           return response()->json(["status" => config('constants.generals.success')]);
           
          }else{
              
              return response()->json(['status'=>config('constants.generals.cannot_access')]);
          }  
       }
   }
   
   // function to remove the task
   
   function removetask(Request $request){
       
       $task_id = $request->task_id;
       $token = $request->token;
       
       if(!isset($task_id) || !isset($token)){
           return response()->json(['status'=>config('constants.generals.fill_all_fields')]);
       }
       
       $task = Task::where(["id" => $task_id])->first();
       
       if(!$task){
            return response()->json(['status'=>config('constants.generals.not_found')]);
       }
       
       $user_posted_task_id = $task->user_id;
       $user_data_from_token = User::where(["token" => $token])->first();
       
       if(!$user_data_from_token){
           
           return response()->json(['status'=>config('constants.generals.not_found')]);
       }
       $user_data_from_token = $user_data_from_token->id;
       
       if($user_data_from_token == $user_posted_task_id){
           
       $task->delete();
       return response()->json(["status" => config('constants.generals.success')]);
       
       }
       
   }
   
   // function to toggle the status of the taske from closed to open
   
   function togglestatus(Request $request){
       
       $task_id = $request->task_id;
       $token = $request->token;
       $task_closed = $request->is_closed;
       
       if(!isset($task_id) || !isset($token) || !isset($task_closed)){
           return response()->json(['status'=>config('constants.generals.fill_all_fields')]);
       }
       
       $task = Task::where(["id" => $task_id])->first();
       
       if(!$task){
            return response()->json(['status'=>config('constants.generals.not_found')]);
       }
       
       $user_posted_task_id = $task->user_id;
       $user_data_from_token = User::where(["token" => $token])->first();
       
       if(!$user_data_from_token){
           
           return response()->json(['status'=>config('constants.generals.not_found')]);
       }
       $user_data_from_token = $user_data_from_token->id;
       
       if($user_data_from_token == $user_posted_task_id){
           
           // get the current time
           $format = 'Y-m-d H:i:s';
           $objDateTime = new DateTime('NOW');
           $updatetime = $objDateTime->format($format);
           // update the task
           Task::where(["id" => $task_id])->update(["is_closed" => $task_closed , "updated_at" => $updatetime]);
           return response()->json(["status" => config('constants.generals.success')]);
       
       }
   }
}
