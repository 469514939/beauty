<?php

namespace App\Admin\Controllers;

use App\Models\Users;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class UsersController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = '用户管理';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Users);

        $grid->column('id', __('Id'));

        $grid->column('wxUsers.nickname', __('Nickname'));
        $grid->column('profile.age', __('Age'));
        $grid->column('mobile', __('Mobile'));
        $grid->column('avatar', __('Avatar'));
        $grid->column('code', __('Code'));
        $grid->column('vipcode', __('Vipcode'));
        $grid->column('card_no', __('Card no'));
        $grid->column('last_login_time', __('Last login time'));
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
        $show = new Show(Users::findOrFail($id));

        $show->field('nickname', __('Nickname'));
        $show->field('mobile', __('Mobile'));
        $show->field('avatar', __('Avatar'));
        $show->field('code', __('Code'));
        $show->field('vipcode', __('Vipcode'));
        $show->field('card_no', __('Card no'));
        $show->field('last_login_time', __('Last login time'));
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
        $form = new Form(new Users);

        $form->text('wxUsers.nickname', __('Nickname'));
        $form->text('profile.age', __('Age'));
        $form->mobile('mobile', __('Mobile'));
        $form->image('avatar', __('Avatar'));
        $form->text('code', __('Code'));
        $form->text('vipcode', __('Vipcode'));
        $form->text('card_no', __('Card no'));
        $form->number('last_login_time', __('Last login time'));

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
