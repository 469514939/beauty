<?php
/**
 * Created by PhpStorm.
 * User: May
 * Date: 2017/6/8
 * Time: 17:41
 */

namespace App\Listeners;

use Illuminate\Http\Request;
use Illuminate\Database\Events\QueryExecuted;
use League\Flysystem\Exception;

class SqlListener {
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct(Request $request) {
        //
        $this->request = $request;
    }

    /**
     * Handle the event.
     *
     * @param  =QueryExecuted  $event
     * @return void
     */
    public function handle(QueryExecuted $event) {
        if(env('SQL', 0)){
            $sql = str_replace("?", "'%s'", $event->sql);
            $bindings = [];
            if(strstr($sql,'%s')){
                foreach($event->bindings as $v){
                    $bindings[] = (string)$v;
                }
                $log = vsprintf($sql,$bindings);
            }else{
                $log = $sql;
            }

            $log = '[' . date('Y-m-d H:i:s') . '] ' . $log . "\r\n";
            $filepath = storage_path('logs\sql.log');
            file_put_contents($filepath, $log, FILE_APPEND);
        }
    }
}