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
    protected $title = 'App\Models\Users';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Users);

        $grid->column('id', __('Id'));
        $grid->column('name', __('Name'));
        $grid->column('email', __('Email'));
        $grid->column('password', __('Password'));
        $grid->column('remember_token', __('Remember token'));
        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));
        $grid->column('nickname', __('Nickname'));
        $grid->column('realname', __('Realname'));
        $grid->column('mobile', __('Mobile'));
        $grid->column('avatar', __('Avatar'));
        $grid->column('code', __('Code'));
        $grid->column('vipcode', __('Vipcode'));
        $grid->column('card_no', __('Card no'));
        $grid->column('last_login_time', __('Last login time'));

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

        $show->field('id', __('Id'));
        $show->field('name', __('Name'));
        $show->field('email', __('Email'));
        $show->field('password', __('Password'));
        $show->field('remember_token', __('Remember token'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('nickname', __('Nickname'));
        $show->field('realname', __('Realname'));
        $show->field('mobile', __('Mobile'));
        $show->field('avatar', __('Avatar'));
        $show->field('code', __('Code'));
        $show->field('vipcode', __('Vipcode'));
        $show->field('card_no', __('Card no'));
        $show->field('last_login_time', __('Last login time'));

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

        $form->text('name', __('Name'));
        $form->email('email', __('Email'));
        $form->password('password', __('Password'));
        $form->text('remember_token', __('Remember token'));
        $form->text('nickname', __('Nickname'));
        $form->text('realname', __('Realname'));
        $form->mobile('mobile', __('Mobile'));
        $form->image('avatar', __('Avatar'));
        $form->text('code', __('Code'));
        $form->text('vipcode', __('Vipcode'));
        $form->text('card_no', __('Card no'));
        $form->number('last_login_time', __('Last login time'));

        return $form;
    }
}
