<?php

namespace App\Admin\Controllers;

use App\Models\Advertising;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class AdvertisingController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'App\Models\Advertising';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Advertising);

        $grid->column('id', __('Id'));
        $grid->column('name', __('名称'));
        $grid->column('description', __('描述'));
        $grid->column('url', __('Url'));
        $grid->column('sort', __('序号'));
        
        $grid->column('status', __('状态'));
        $grid->column('mainpic', __('Mainpic'));
        $grid->column('content', __('Content'));
        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));
        return $grid;
    }

    /**
     * Make a show builder.
     *
     * @param mixed $id
     * @return Show
     */
    protected function detail($id)
    {
        $show = new Show(Advertising::findOrFail($id));

        $show->field('name', __('名称'));
        $show->field('description', __('描述'));
        $show->field('url', __('Url'));
        $show->field('sort', __('序号'));
        $show->field('created_by', __('Created by'));
        $show->field('updated_by', __('Updated by'));
        $show->field('status', __('状态'));
        $show->field('mainpic', __('Mainpic'));
        $show->field('content', __('Content'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new Advertising);

        $form->text('name', __('名称'));
        $form->text('description', __('描述'));
        $form->url('url', __('Url'));
        $form->number('sort', __('序号'));
        $form->switch('status', __('状态'));
        $form->image('mainpic', __('Mainpic'))->uniqueName();
        $form->ueditor('content', '内容');

        return $form;
    }
}
