<?php

namespace App\Admin\Controllers;

use App\Models\GoodsType;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class GoodsTypeController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'App\Models\GoodsType';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new GoodsType);

        $grid->column('id', __('Id'));
        $grid->column('name', __('名称'));
        $grid->column('status', __('状态'));
        $grid->column('created_time', __('Created time'));
        $grid->column('updated_time', __('Updated time'));
        $grid->column('created_by', __('Created by'));
        $grid->column('updated_by', __('Updated by'));
        $grid->column('sort', __('序号'));

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
        $show = new Show(GoodsType::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('name', __('名称'));
        $show->field('status', __('状态'));
        $show->field('created_time', __('Created time'));
        $show->field('updated_time', __('Updated time'));
        $show->field('created_by', __('Created by'));
        $show->field('updated_by', __('Updated by'));
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
        $form = new Form(new GoodsType);

        $form->text('name', __('名称'));
        $form->switch('status', __('状态'));
        $form->datetime('created_time', __('Created time'))->default(date('Y-m-d H:i:s'));
        $form->datetime('updated_time', __('Updated time'))->default(date('Y-m-d H:i:s'));
        $form->number('created_by', __('Created by'));
        $form->number('updated_by', __('Updated by'));
        $form->number('sort', __('序号'));

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
