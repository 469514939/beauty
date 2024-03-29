<?php

namespace App\Admin\Controllers;

use App\Models\Movie;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;
use App\User;

class MovieController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'App\Models\Movie';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Movie);

        $grid = new Grid(new Movie);

        // 第一列显示id字段，并将这一列设置为可排序列
        $grid->column('id', 'ID')->sortable();

        // 第二列显示title字段，由于title字段名和Grid对象的title方法冲突，所以用Grid的column()方法代替
        $grid->column('title');

        // 第三列显示director字段，通过display($callback)方法设置这一列的显示内容为users表中对应的用户名
        $grid->column('director')->display(function($userId) {
            return User::find($userId)->name;
        });

        // 第四列显示为describe字段
        $grid->column('describe');

        // 第五列显示为rate字段
        $grid->column('rate');

        // 第六列显示released字段，通过display($callback)方法来格式化显示输出
        $grid->column('released', '上映?')->display(function ($released) {
            return $released ? '是' : '否';
        });

        // 下面为三个时间字段的列显示
        $grid->column('release_at');
        $grid->column('created_at');
        $grid->column('updated_at');

        // filter($callback)方法用来设置表格的简单搜索框
        $grid->filter(function ($filter) {

            // 设置created_at字段的范围查询
            $filter->between('created_at', 'Created Time')->datetime();
        });

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
        $show = new Show(Movie::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('title', __('Title'));
        $show->field('director', __('Director'));
        $show->field('describe', __('Describe'));
        $show->field('rate', __('Rate'));
        $show->field('released', __('Released'));
        $show->field('release_at', __('Release at'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new Movie);

        // 显示记录id
        $form->display('id', 'ID');

        // 添加text类型的input框
        $form->text('title', '电影标题');

        $directors = [
            1 => 'John',
            2 => 'Smith',
            3 => 'Kate' ,
        ];

        $form->select('director', '导演')->options($directors);

        // 添加describe的textarea输入框
        $form->textarea('describe', '简介');

        // 数字输入框
        $form->number('rate', '打分');

        // 添加开关操作
        $form->switch('released', '发布');

        // 添加日期时间选择框
        $form->datetime('release_at', '发布时间');

        // 两个时间显示
        $form->datetime('created_at', '创建时间');
        $form->datetime('updated_at', '修改时间');

        return $form;
    }
}
