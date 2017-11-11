<?php

namespace App\Helpers;
class GeneralHelpers {
    
    public static function create_usercodes($userid, $length=3, $vcode = false)
    {
        $letters = "12345678";
        $time = time();
        $uniqid = substr($time, -4);
        $code = "";
        for ($i = 0; $i <$length; $i++)
        {
            $iletter = rand(0,  strlen($letters)-1);
            $code .= substr($letters, $iletter, 1);
        }
        if($vcode == false)
            return $userid . $code;
        else
            return bcrypt($uniqid).$code;
    }
}
