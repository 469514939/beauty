<?php
/**
 * Created by PhpStorm.
 * User: pc001
 * Date: 2018/10/8
 * Time: 16:31
 */
 
namespace App\Admin\Extensions;
 
use Encore\Admin\Form\Field;
 
class UEditor extends Field
{
    protected static $css = [
    ];
    public static $isJs=false;
    protected static $js = [
        'vendor/ueditor/ueditor.config.js',
        'vendor/ueditor/ueditor.all.js',
    ];
    protected $view = 'UEditor';
    public function render()
    {
        $this->script = <<<EOT
        UE.delEditor('{$this->id}');
             var  ue = UE.getEditor('{$this->id}');
             
EOT;
        return parent::render();
    }
}