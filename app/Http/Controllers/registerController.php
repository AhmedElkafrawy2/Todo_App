<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use DB;
//use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Hash;
use App\Http\Requests\StoreUserRequest;
use App\Http\Requests\LoginUserRequest;
use Socialite;
use Auth;

class registerController extends Controller
{
    // auth with facebbok
    
    public function getfacebooklogin(){
     
       return Socialite::driver("facebook")->redirect();
    }
    
    public function  handlefacebooklogin(){
       
        $user = Socialite::driver("facebook")->user();
        $data = ['username' => $user->name,"email" => $user->email , "password" => $user->token];
        $userdb = User::where(["email" => $user->email])->first();
        if(is_null($userdb)){
            
           $userinsert = new User;
           $userinsert->username = $user->name;
           $userinsert->email = $user->email;
           $userinsert->token = \App\Helpers\GeneralHelpers::create_usercodes("", 20, true);
        
           $userinsert->password =  $user->token;       
               
           $userinsert->save();
            return redirect("/");
        }else{
            
             
             return redirect("/");
            
        }
    }
    // function to register the user
    public function register(StoreUserRequest $request){
        
        $content = $request->getContent();
        $data = json_decode($content, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        $user = new User;
        $user->username = $data['username'];
        $user->email = $data['email'];
        $user->token = \App\Helpers\GeneralHelpers::create_usercodes("", 20, true);
        
        $user->password =  bcrypt($data['password']);       
               
        $user->save();
        
        return response()->json(["status" => config('constants.generals.success')]);
        
    }
    
    // this function is to get login request with emil and password
    public function login(LoginUserRequest $request){
        
        $content = $request->getContent();
        $data = json_decode($content, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        $email = $data['email'];

        $password = $data['password'];

        $user = User::where(["email" => $email])->first();
             
        if(!$user){
            
            return response()->json(['status'=>config('constants.generals.not_found')]);
  
        }else{ 
            
              if (!Hash::check($password, $user->password))
              {    
                return response()->json(['status'=>config('constants.generals.not_found')]);
                
              }else{             
                return $this->get_user_info($user);  
              }
            
        }

    }
    
    // auth user with passport
    
    function getappsecret  (){
        
        $secret = DB::table('oauth_clients')
                     ->select()
                     ->where('name', "Laravel Password Grant Client")
                     
                     ->first();
        
        return response()->json([
            
            "client_id" => $secret->id,
            "client_secret" => $secret->secret
        ]);
    }
    
    

    
    // this function to search for user with username or email
    
    public function searchuser(Request $request){
        
        $username = $request->username;
        $email = $request->email;
        
        if(!isset($username)&& !isset($email)){
            return response()->json(['status'=>config('constants.generals.fill_all_fields')]);
        }
        
        $usersearch;
        $userfiled;
        if(isset($username)){
            
            $usersearch = $username;
            $userfiled = "username";
            
            
        }else{
            
            $usersearch = $email;
            $userfiled = "email";
            
        }
        
        // search user
        $searcheduser = $this->search($usersearch,$userfiled);
        if(!$searcheduser){
            
            return response()->json(['status'=>config('constants.generals.fill_all_fields')]);
        }
        $response = array();
        $usertasks = array();
        
        
        //return  $searcheduser[1]["id"];
        //$searcheduser[2]["id"];
        for($i = 0 ; $i <= count($searcheduser)-1 ; $i++){
            
            $response[] = 
              [
                'status' => config('constants.generals.success'),
		'user'=>[
                    
                    'user_id'=>$searcheduser[$i]["id"],
                    'user_email'=>$searcheduser[$i]["email"],
                    'username'=>$searcheduser[$i]["username"],
                    'created_at'=>$searcheduser[$i]["created_at"],
                    'last_update'=>$searcheduser[$i]["updated_at"],
                    
                    ],
              
            ];
            
         $gettaskforuser = \App\Task::where(["is_public" => 1 , "user_id" => $searcheduser[$i]["id"] ])->get();
          for($j = 0 ; $j <= count($gettaskforuser)-1 ; $j++){
                
                $usertasks[] = [
                     "task_id" => $gettaskforuser[$j]["id"],
                     "task_title" => $gettaskforuser[$j]["task_title"],
                     "task_body" => $gettaskforuser[$j]["task_body"],
                     "task_created_at" => $gettaskforuser[$j]["created_at"],
                     "task_updated_at" => $gettaskforuser[$j]["updated_at"]
                    ];
            }
        
        }
        return response()->json([
            
            "allusers" => $response , 
            "alltasks" => $usertasks
            
            ]);
        
        
    }
    
    
    // function to search the user
    
    protected function search($data,$userfiled){
        
        $user = User::where($userfiled,'like', "%". $data ."%")->get();
        return $user;
    }


    // function to get all user information from username and password
    
    protected function get_user_info($user){
        
        $response = 
              response()->json(['status'=>config('constants.generals.success'),
		'user'=>[
                    'user_id'=>$user->id,
                    'user_email'=>$user->email,
                    'user_token'=>$user->token,
                    'username'=>$user->username,
                    'created_at'=>$user->created_at,
                    'last_update'=>$user->updated_at,
                ]
            ]);
        return $response;
    }

}
