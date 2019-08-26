<?php

namespace App\Admin\Controllers;

use App\Models\GoodsCate;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class GoodsCateController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'App\Models\GoodsCate';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new GoodsCate);

        $grid->column('id', __('Id'));
        $grid->column('name', __('Name'));
        $grid->column('alias', __('Alias'));
        $grid->column('pid', __('Pid'));
        $grid->column('type_id', __('Type id'));
        $grid->column('status', __('Status'));
        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));
        $grid->column('created_by', __('Created by'));
        $grid->column('updated_by', __('Updated by'));
        $grid->column('sort', __('Sort'));
        $grid->column('cate_description', __('Cate description'));

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
        $show = new Show(GoodsCate::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('name', __('名称'));
        $show->field('alias', __('别名'));
        $show->field('pid', __('上级分类ID'));
        $show->field('type_id', __('商品类型ID'));
        $show->field('status', __('状态'));
        $show->field('created_at', __('创建时间'));
        $show->field('updated_at', __('更新时间'));
        // $show->field('created_by', __('Created by'));
        // $show->field('updated_by', __('Updated by'));
        $show->field('sort', __('Sort'));
        $show->field('cate_description', __('描述'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new GoodsCate);

        $form->text('name', __('Name'));
        $form->text('alias', __('Alias'));
        $form->number('pid', __('Pid'));
        $form->number('type_id', __('Type id'));
        $form->switch('status', __('Status'));
        $form->number('created_by', __('Created by'));
        $form->number('updated_by', __('Updated by'));
        $form->number('sort', __('Sort'));
        $form->text('cate_description', __('Cate description'));
        // $form->text('coverpic', __('Coverpic'));
        // $form->text('mainpic', __('Mainpic'));

        return $form;
    }
}
