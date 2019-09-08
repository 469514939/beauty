<?php

function jsonMsg($success,$message = '',$result = '',$code = 0){
    echo json_encode(['success'=>$success,'result'=>$result,'message'=>$message,'code'=>$code]);
    exit;
}

/*
 * isJson 判断是否JSON格式数据
 * @param data 数据
 * @return boolean
 */
if (!function_exists('isJson')){
    function isJson($data){
        if(!is_string($data)){
            return false;
        }
        if(is_null(json_decode($data))){
            return false;
        }
        return true;
    }
}


//输出格式
function dataResult($data=null,$info='',$status=0,$errno=0,$command=null,$rowcount=null)
{
    $result           =   array();
    $result['data']   =   $data;  //数据
    $result['info']   =   $info; //反馈字符串信息
    $result['status'] =   $status; //返回请求结果成功与否 1/0
    $result['errno'] =    $errno;  //Andy 返回错误编号 def=0
    $result['command'] =  $command; //Andy 返回序号客户端执行的命令 一般是js
    return $result;
}

if (!function_exists('apiOrWebResponse')) {
    function apiOrWebResponse($data = null, $info = '', $status = 0, $errno = 0, $command = null, $rowcount = null)
    {
        if (request('is_api')) {
            return dataResult($data, $info, $status, $errno, $command, $rowcount);
        }
        return redirect($data)->withErrors($info);
    }
}


/**
 * Ajax方式返回数据到客户端
 * @access protected
 * @param mixed $data 要返回的数据
 * @param String $type AJAX返回数据格式
 * @return void
 */
function ajaxReturn($data,$type='JSON') {
    switch (strtoupper($type)){
        case 'JSON' :
            // 返回JSON数据格式到客户端 包含状态信息
            header('Content-Type:application/json; charset=utf-8');
            exit(json_encode($data));
        case 'XML'  :
            // 返回xml格式数据
            header('Content-Type:text/xml; charset=utf-8');
            exit(xml_encode($data));
        case 'JSONP':
            // 返回JSON数据格式到客户端 包含状态信息
            header('Content-Type:application/json; charset=utf-8');
            $handler  =   isset($_GET[C('VAR_JSONP_HANDLER')]) ? $_GET[C('VAR_JSONP_HANDLER')] : C('DEFAULT_JSONP_HANDLER');
            exit($handler.'('.json_encode($data).');');  
        case 'EVAL' :
            // 返回可执行的js脚本
            header('Content-Type:text/html; charset=utf-8');
            exit($data);            
    }
}

//跨域获取标签内容
function getWebTag($tag_id,$url=false,$tag='div',$data=false,$first=false){
        //默认采用URL获取数据
        if($url !== false){
            $data = file_get_contents( $url );
        }
        //页面编码判定及转码
        $charset_pos = stripos($data,'charset');
        if($charset_pos) {
            if(stripos($data,'charset=utf-8',$charset_pos)) {
                $data = iconv('utf-8','utf-8',$data);
            }else if(stripos($data,'charset=gb2312',$charset_pos)) {
                $data = iconv('gb2312','utf-8',$data);
            }else if(stripos($data,'charset=gbk',$charset_pos)) {
                $data = iconv('gbk','utf-8',$data);
            }
        }

        //匹配命中标签至数组$hits
        preg_match_all('/<'.$tag.'[^<]*?'.$tag_id.'/i',$data,$hits,PREG_OFFSET_CAPTURE);
        if(count($hits[0]) === 0) {                //未命中，直接返回
            return '没有匹配项！';
        }

        preg_match_all('/<'.$tag.'/i',$data,$pre_matches,PREG_OFFSET_CAPTURE);        //获取所有HTML标签前缀
        preg_match_all('/<\/'.$tag.'/i',$data,$suf_matches,PREG_OFFSET_CAPTURE);     //获取所有HTML标签后缀

        //判断是否<div></div>格式，是则添加结束标签，否则为false;  注：img、input等可能不是这种格式，此时$suf_matches[0]为空。
        if(!empty($suf_matches[0])) $endTag = '</'.$tag.'>';
        else $endTag = false;
        
        //合并所有HTML标签
        $htmltags = array();
        if($endTag !== false){
            foreach($pre_matches[0] as $index=>$pre_div){
                $htmltags[(int)$pre_matches[0][$index][1]] = 'p';
                $htmltags[(int)$suf_matches[0][$index][1]] = 's';
            }
        }else{
            foreach($pre_matches[0] as $index=>$pre_div){
                //非<div></div>格式，获取前缀下标后的第一个>作为标签结束
                $suf_matches[0][$index][1] = stripos($data,'>',$pre_matches[0][$index][1])+1;
                
                $htmltags[(int)$pre_matches[0][$index][1]] = 'p';
                $htmltags[(int)$suf_matches[0][$index][1]] = 's';
            }
        }
        //对所有HTML标签按index进行排序
        $sort = array_keys($htmltags);
        asort($sort);

        //开始获取命中字符串
        $hitTagStrings = array();
        foreach($hits[0] as $hit){
            $hit = $hit[1];        //获取命中index

            $count = count($sort);    //循环控制，$count--避免无限循环
            foreach($pre_matches[0] as $index=>$pre_div){
                //最后一个$pre_matches[0][$index+1]会造成数组出界，因此设置其index等于总长度
                if(!isset($pre_matches[0][$index+1][1])) $pre_matches[0][$index+1][1] = strlen($data);
                
                //<div $hit <div+1    时div被命中
                if(($pre_matches[0][$index][1] <= $hit) && ($hit < $pre_matches[0][$index+1][1])){
                    $deeper = 0;
                    //弹出被命中HTML标签前的所有HTML标签
                    while(array_shift($sort) != $pre_matches[0][$index][1] && ($count--)) continue;
                    //对剩余HTML标签进行匹配，若下一个为前缀(p)，则向下一层，$deeper加1，
                    //否则后退一层，$deeper减1，$deeper为0则命中匹配结束标记，计算div长度
                    foreach($sort as $key){
                        if($htmltags[$key] == 'p') {    //进入子层
                            $deeper++;
                        }else if($deeper == 0) {        //碰到结束标记
                            $length = $key-$pre_matches[0][$index][1];        //长度等于结束标记index 减去 前缀index
                            break;
                        }else {                            //碰到子层结束标记
                            $deeper--;
                        }
                    }
                    $hitTagStrings[] = substr($data,$pre_matches[0][$index][1],$length).$endTag;
                    break;
                }
            }
            //若只获取第一个匹配项，退出循环
            if($first && count($hitTagStrings) == 1) break;
        }

        return $hitTagStrings;
    }

//获取标签内容
function getHtmlTag($charset_pos='',$tag='div',$data=false,$first=false){
        //页面编码判定及转码
        $data = $charset_pos;

        //匹配命中标签至数组$hits
        preg_match_all('/<'.$tag.'[^<]*?'.'/i',$data,$hits,PREG_OFFSET_CAPTURE);
        if(count($hits[0]) === 0) {                //未命中，直接返回
            return '没有匹配项！';
        }

        preg_match_all('/<'.$tag.'/i',$data,$pre_matches,PREG_OFFSET_CAPTURE);        //获取所有HTML标签前缀
        preg_match_all('/<\/'.$tag.'/i',$data,$suf_matches,PREG_OFFSET_CAPTURE);     //获取所有HTML标签后缀

        //判断是否<div></div>格式，是则添加结束标签，否则为false;  注：img、input等可能不是这种格式，此时$suf_matches[0]为空。
        if(!empty($suf_matches[0])) $endTag = '</'.$tag.'>';
        else $endTag = false;
        
        //合并所有HTML标签
        $htmltags = array();
        if($endTag !== false){
            foreach($pre_matches[0] as $index=>$pre_div){
                $htmltags[(int)$pre_matches[0][$index][1]] = 'p';
                $htmltags[(int)$suf_matches[0][$index][1]] = 's';
            }
        }else{
            foreach($pre_matches[0] as $index=>$pre_div){
                //非<div></div>格式，获取前缀下标后的第一个>作为标签结束
                $suf_matches[0][$index][1] = stripos($data,'>',$pre_matches[0][$index][1])+1;
                
                $htmltags[(int)$pre_matches[0][$index][1]] = 'p';
                $htmltags[(int)$suf_matches[0][$index][1]] = 's';
            }
        }
        //对所有HTML标签按index进行排序
        $sort = array_keys($htmltags);
        asort($sort);

        //开始获取命中字符串
        $hitTagStrings = array();
        foreach($hits[0] as $hit){
            $hit = $hit[1];        //获取命中index

            $count = count($sort);    //循环控制，$count--避免无限循环
            foreach($pre_matches[0] as $index=>$pre_div){
                //最后一个$pre_matches[0][$index+1]会造成数组出界，因此设置其index等于总长度
                if(!isset($pre_matches[0][$index+1][1])) $pre_matches[0][$index+1][1] = strlen($data);
                
                //<div $hit <div+1    时div被命中
                if(($pre_matches[0][$index][1] <= $hit) && ($hit < $pre_matches[0][$index+1][1])){
                    $deeper = 0;
                    //弹出被命中HTML标签前的所有HTML标签
                    while(array_shift($sort) != $pre_matches[0][$index][1] && ($count--)) continue;
                    //对剩余HTML标签进行匹配，若下一个为前缀(p)，则向下一层，$deeper加1，
                    //否则后退一层，$deeper减1，$deeper为0则命中匹配结束标记，计算div长度
                    foreach($sort as $key){
                        if($htmltags[$key] == 'p') {    //进入子层
                            $deeper++;
                        }else if($deeper == 0) {        //碰到结束标记
                            $length = $key-$pre_matches[0][$index][1];        //长度等于结束标记index 减去 前缀index
                            break;
                        }else {                            //碰到子层结束标记
                            $deeper--;
                        }
                    }
                    $hitTagStrings[] = substr($data,$pre_matches[0][$index][1],$length).$endTag;
                    break;
                }
            }
            //若只获取第一个匹配项，退出循环
            if($first && count($hitTagStrings) == 1) break;
        }

        return $hitTagStrings;
    }

//异步请求
/**
 * GET 请求
 * @param string $url
 */
function http_get($url){
    $oCurl = curl_init();
    if(stripos($url,"https://")!==FALSE){
        curl_setopt($oCurl, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($oCurl, CURLOPT_SSL_VERIFYHOST, FALSE);
        curl_setopt($oCurl, CURLOPT_SSLVERSION, 1); //CURL_SSLVERSION_TLSv1
    }
    curl_setopt($oCurl, CURLOPT_CONNECTTIMEOUT, 5);
    curl_setopt($oCurl, CURLOPT_URL, $url);
    curl_setopt($oCurl, CURLOPT_RETURNTRANSFER, 1 );
    $sContent = curl_exec($oCurl);
    $aStatus = curl_getinfo($oCurl);
    curl_close($oCurl);
    if(intval($aStatus["http_code"])==200){
        return $sContent;
    }else{
        return false;
    }
}
 
/**
 * POST 请求
 * @param string $url
 * @param array $param
 * @param boolean $post_file 是否文件上传
 * @return string content
 */
function http_post($url,$param='',$post_file=false){
    $oCurl = curl_init();
    if(stripos($url,"https://")!==FALSE){
        curl_setopt($oCurl, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($oCurl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($oCurl, CURLOPT_SSLVERSION, 1); //CURL_SSLVERSION_TLSv1
    }
    if (is_string($param) || $post_file) {
        $strPOST = $param;
    } else {
        $strPOST =  http_build_query($param);
    }
    curl_setopt($oCurl, CURLOPT_TIMEOUT, 5);
    curl_setopt($oCurl, CURLOPT_CONNECTTIMEOUT, 5);
    curl_setopt($oCurl, CURLOPT_URL, $url);
    curl_setopt($oCurl, CURLOPT_RETURNTRANSFER, 1 );
    curl_setopt($oCurl, CURLOPT_POST,true);
    curl_setopt($oCurl, CURLOPT_POSTFIELDS,$strPOST);
    $sContent = curl_exec($oCurl);
    $aStatus = curl_getinfo($oCurl);
    curl_close($oCurl);
    if(intval($aStatus["http_code"])==200){
        return $sContent;
    }else{
        return false;
    }
}



/**
 * 判断是否微信浏览器
 */
function is_weixin() { 
    if (strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false) { 
        return true; 
    } return false; 
}


//用PHP的json_encode来处理中文的时候, 中文都会被编码, 变成不可读的, 类似”\u***”的格式，
//汉字不进行转码  先对需要处理的做urlencode处理，然后json_encode，最后做urldecode处理
function cn_encode_json($str) {
    return urldecode(json_encode(cn_url_encode($str)));    
}

function cn_url_encode($str) {
    if(is_array($str)) {
        foreach($str as $key=>$value) {
            $str[urlencode($key)] = cn_url_encode($value);
        }
    } else {
        $str = urlencode($str);
    }
    
    return $str;
}



/*
 * log 接口记录
 * @access private
 * @return mixed
 */
 function deblog($str ,$file_name = ''){

    if (!$file_name) $file_name = preg_replace('|[0-9/]+|','','send');

    if (!$file_name) $file_name = 'default';

    $path = storage_path("logs/$file_name"."_".date("Y-m-d").".log");

    $result = createFile($path);

    $text = '+------------------------------------------------';
    $text .= "\r\n";
    $text .= '时间:' . date("Y-m-d H:i:s");
    $text .= $str;
    $text .= "\r\n";

    if($result){
        @file_put_contents($path,$text,FILE_APPEND);
    }

}
    /*
     * createFile创建文件
     * @param string path 文件路径
     * @access private
     * @return boolean
     */
     function createFile($path){
        $mix = 1024*1024*8; //最大文件大小

        if (!is_file($path)){
            //不存在文件
            $dir_path = substr($path,0, strrpos($path,'/'));

            if (!file_exists($dir_path)){
                if (!@mkdir($dir_path,0777,true)){
                    return false;
                }
            }
            if(is_writable($dir_path)){
                if (!@chmod($dir_path, 0777)){
                    return false;
                }
            }
            if(@file_put_contents($path,'') === false){
                return false;
            }

        }else{
            //存在文件
            if(is_writable($path)){
                if (!@chmod($path, 0777)){
                    return false;
                }
            }
        }
        return true;
    }
    

/**
 * 获取用户真实 IP
 */
function getIP()
{
    static $realip;
    if (isset($_SERVER)){
        if (isset($_SERVER["HTTP_X_FORWARDED_FOR"])){
            $realip = $_SERVER["HTTP_X_FORWARDED_FOR"];
        } else if (isset($_SERVER["HTTP_CLIENT_IP"])) {
            $realip = $_SERVER["HTTP_CLIENT_IP"];
        } else {
            $realip = $_SERVER["REMOTE_ADDR"];
        }
    } else {
        if (getenv("HTTP_X_FORWARDED_FOR")){
            $realip = getenv("HTTP_X_FORWARDED_FOR");
        } else if (getenv("HTTP_CLIENT_IP")) {
            $realip = getenv("HTTP_CLIENT_IP");
        } else {
            $realip = getenv("REMOTE_ADDR");
        }
    }
    return $realip;
}
 

/**
 * 根据 Ip 获取地址位置
 */
function getIpInfo($internetIp = '')
{
    try
    {
        //内网IP
        //  A类10.0.0.0～10.255.255.255
        //  B类172.16.0.0～172.31.255.255
        //  C类192.168.0.0～192.168.255.255
        //  ......
        $bLocalIp = !filter_var($internetIp, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE);
        if($bLocalIp)
            $internetIp = 'myip';//局域网IP

        $requestAPi = "http://ip.taobao.com/service/getIpInfo.php?ip=" . $internetIp;
        $opts       = array(
            'http' => array(
                'method'  => 'GET',
                'timeout' => 2, // 单位秒
            )
        );
        $jsonArr = json_decode( file_get_contents($requestAPi, false, stream_context_create($opts)),
            JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS );

        // 说明断网
        if (!isset($jsonArr) || !isset($jsonArr['code']))
        {
            return false;
        }

        // 0 表示成功
        if ($jsonArr['code'] !== 0)
        {
            return false;
        }

        // 返回的数据结果：
        //  "ip": "223.98.166.115",
        //  "country": "中国",
        //  "area": "",
        //  "region": "山东",
        //  "city": "济南",
        //  "county": "XX",
        //  "isp": "移动",
        //  "country_id": "CN",
        //  "area_id": "",
        //  "region_id": "370000",
        //  "city_id": "370100",
        //  "county_id": "xx",
        //  "isp_id": "100025"
        $data = (array)$jsonArr['data'];
        return $data;
    }
    catch (\Exception $e)
    {

    }

    return false;
}

//获取价格区间
if(!function_exists('getPriceRange')){
    function getPriceRange($max,$n){
        $num = intval($max);
        if($num<=1){
            return ['0-2'];
        }
        $length = strlen($num);
        $str = substr($num ,0,1);
        $new_num = ((int)$str+1)*pow(10,$length-1);

        $block = ceil($new_num/($n-1));

        $data = [];
        for($i=0;$i<=($n-1);$i++){
            $a = $i*$block;
            $b = ($i+1)*$block - 1;
            if($a < $max){
                if($i==($n-1)){
                    $data[] = ($a-1).'以上';
                }else{
                    $data[] = $a.'-'.$b;
                }
            }
        }
        return $data;
    }
}

/**
 * [base64_image_content base64图片保存]
 * @Author   andy
 * @DateTime 2019-06-10T11:59:38+0800
 * @param    [type]                   $base64_image_content [description]
 * @param    [type]                   $path                 [description]
 * @return   [type]                                         [description]
 */
function base64_image_content($base64_image_content,$path){
    //匹配出图片的格式
    if (preg_match('/^(data:\s*image\/(\w+);base64,)/', $base64_image_content, $result)){
        $type = $result[2];
        $new_file = $path."/".date('Ymd',time())."/";
        if(!file_exists($new_file)){
            //检查是否有该文件夹，如果没有就创建，并给予最高权限
            mkdir($new_file, 0700);
        }
        $new_file = $new_file.uniqid().".{$type}";
        if (file_put_contents($new_file, base64_decode(str_replace($result[1], '', $base64_image_content)))){
            if(empty($new_file)){
                return false;
            }
            return '/'.$new_file;
            // return $new_file;
        }else{
            return false;
        }
    }else{
        return false;
    }
}

//名称中间打码
function cut_str($string, $sublen, $start = 0, $code = 'UTF-8') 
{ 
    if($code == 'UTF-8') 
    { 
        $pa = "/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|\xe0[\xa0-\xbf][\x80-\xbf]|[\xe1-\xef][\x80-\xbf][\x80-\xbf]|\xf0[\x90-\xbf][\x80-\xbf][\x80-\xbf]|[\xf1-\xf7][\x80-\xbf][\x80-\xbf][\x80-\xbf]/"; 
        preg_match_all($pa, $string, $t_string);
        if(count($t_string[0]) - $start > $sublen) return join('', array_slice($t_string[0], $start, $sublen));
        return join('', array_slice($t_string[0], $start, $sublen));
    }
    else
    {
        $start = $start*2;
        $sublen = $sublen*2;
        $strlen = strlen($string);
        $tmpstr = '';
        for($i=0; $i< $strlen; $i++)
        {
            if($i>=$start && $i< ($start+$sublen))
            {
                if(ord(substr($string, $i, 1))>129)
                {
                    $tmpstr.= substr($string, $i, 2);
                }
                else
                {
                    $tmpstr.= substr($string, $i, 1);
                }
            }
            if(ord(substr($string, $i, 1))>129) $i++;
        }
        return $tmpstr;
    }
}

//获取当前浏览器
function getBrowser(){
    if(empty($_SERVER['HTTP_USER_AGENT'])){
  return 'robot！';
 }
 if( (false == strpos($_SERVER['HTTP_USER_AGENT'],'MSIE')) && (strpos($_SERVER['HTTP_USER_AGENT'], 'Trident')!==FALSE) ){
  // return 'Internet Explorer 11.0';
  return 'ie';
 }
 if(false!==strpos($_SERVER['HTTP_USER_AGENT'],'MSIE 10.0')){
  // return 'Internet Explorer 10.0';
  return 'ie';
 }
 if(false!==strpos($_SERVER['HTTP_USER_AGENT'],'MSIE 9.0')){
  // return 'Internet Explorer 9.0';
  return 'ie';
 }
 if(false!==strpos($_SERVER['HTTP_USER_AGENT'],'MSIE 8.0')){
  // return 'Internet Explorer 8.0';
  return 'ie';
 }
 if(false!==strpos($_SERVER['HTTP_USER_AGENT'],'MSIE 7.0')){
  // return 'Internet Explorer 7.0';
  return 'ie';
 }
 if(false!==strpos($_SERVER['HTTP_USER_AGENT'],'MSIE 6.0')){
  // return 'Internet Explorer 6.0';
  return 'ie';
 }
 if(false!==strpos($_SERVER['HTTP_USER_AGENT'],'Edge')){
  return 'Edge';
 }
 if(false!==strpos($_SERVER['HTTP_USER_AGENT'],'Firefox')){
  return 'Firefox';
 }
 if(false!==strpos($_SERVER['HTTP_USER_AGENT'],'Chrome')){
  return 'Chrome';
 }
 if(false!==strpos($_SERVER['HTTP_USER_AGENT'],'Safari')){
  return 'Safari';
 }
 if(false!==strpos($_SERVER['HTTP_USER_AGENT'],'Opera')){
  return 'Opera';
 }
 if(false!==strpos($_SERVER['HTTP_USER_AGENT'],'360SE')){
  return '360SE';
 }
  //微信浏览器
 if(false!==strpos($_SERVER['HTTP_USER_AGENT'],'MicroMessage')){
  return 'MicroMessage';
 }

}


//前后加单引号
function change_to_quotes($str) {
    return sprintf("'%s'", $str);
 }

/* 
*function：计算两个日期相隔多少年，多少月，多少天 
*param string $date1[格式如：时间戳] 
*param string $date2[格式如：时间戳] 
*return array array('年','月','日'); 
*/  
function diffDate($date1,$date2){
    if($date1>$date2){  
        $tmp=$date2;  
        $date2=$date1;  
        $date1=$tmp;  
    }  
    list($Y1,$m1,$d1)=explode('-',date('Y-m-d',$date1));  
    list($Y2,$m2,$d2)=explode('-',date('Y-m-d',$date2));  
    $Y=$Y2-$Y1;  
    $m=$m2-$m1;  
    $d=$d2-$d1;  
    if($d<0){  
        $d+=(int)date('t',strtotime("-1 month $date2"));  
        $m--;  
    }  
    if($m<0){  
        $m+=12;  
        $Y--;  
    }  
    return array('year'=>$Y,'month'=>$m,'day'=>$d);  
}  