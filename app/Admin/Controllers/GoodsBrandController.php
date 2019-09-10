<?php

namespace App\Admin\Controllers;

use App\Models\GoodsBrand;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class GoodsBrandController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'App\Models\GoodsBrand';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new GoodsBrand);

        $grid->column('id', __('Id'));
        $grid->column('name', __('名称'));
        $grid->column('status', __('状态'));
        $grid->column('url', __('Url'));
        $grid->column('logo', __('Logo'));
        $grid->column('content', __('Content'));
        $grid->column('sort', __('序号'));
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
        $show = new Show(GoodsBrand::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('name', __('名称'));
        $show->field('status', __('状态'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('created_by', __('Created by'));
        $show->field('updated_by', __('Updated by'));
        $show->field('url', __('Url'));
        $show->field('logo', __('Logo'));
        $show->field('content', __('Content'));
        $show->field('sort', __('序号'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new GoodsBrand);

        $form->text('name', __('名称'));
        $form->switch('status', __('状态'));
        $form->number('created_by', __('Created by'));
        $form->number('updated_by', __('Updated by'));
        $form->url('url', __('Url'));
        $form->text('logo', __('Logo'));
        $form->textarea('content', __('Content'));
        $form->number('sort', __('序号'))->default(1);

         // 表单脚部
        $form->footer(function ($footer) {
            // 去掉`查看`checkbox
            $footer->disableViewCheck();
            // 去掉`继续编辑`checkbox
            $footer->disableEditingCheck();
            // 去掉`继续创建`checkbox
            $footer->disableCreatingCheck();
        });
        return $form;
    }
}
