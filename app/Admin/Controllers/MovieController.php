<?php

namespace App\Admin\Controllers;

use App\Models\Movie;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

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

        $grid->column('id', __('Id'))->sortable();
        $grid->column('title', __('Title'));
        $grid->column('director', __('Director'));
        $grid->column('describe', __('Describe'));
        $grid->column('rate', __('Rate'));
        $grid->column('released', __('Released'));
        $grid->column('release_at', __('Release at'));
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

        $form->text('title', __('Title'));
        $form->number('director', __('Director'));
        $form->text('describe', __('Describe'));
        $form->switch('rate', __('Rate'));
        $form->text('released', __('Released'));
        $form->datetime('release_at', __('Release at'))->default(date('Y-m-d H:i:s'));

        return $form;
    }
}
