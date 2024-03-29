<?php

namespace App\Admin\Controllers;

use App\Models\Goods;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;
use App\Models\GoodsCate;
use App\Models\GoodsType;
use App\Models\GoodsBrand;

class GoodsController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'App\Models\Goods';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Goods);

        $grid->column('id', __('Id'));
        $grid->column('name', __('名称'));
        $grid->column('code', __('Code'));
        $grid->column('unit', __('Unit'));
        $grid->column('status', __('状态'))->using(['1' => '启用', '-1' => '未启用', '-2' => '已删除']);
        $grid->column('keyword', __('Keyword'));
        $grid->column('market_price', __('Market price'));
        $grid->column('store_nums', __('Store nums'));
        $grid->column('sort', __('序号'));
        $grid->column('is_online', __('Is online'));
        $grid->column('mainpic', __('Mainpic'));
        $grid->column('like_count', __('Like count'));

        $grid->column('goodsType.name', __('类型'));
        $grid->column('goodsCate.name', __('分类'));
        $grid->column('goodsBrand.name', __('品牌'));
        
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
        $show = new Show(Goods::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('cate_id', __('Cate id'));
        $show->field('name', __('名称'));
        $show->field('code', __('Code'));
        $show->field('type_id', __('Type id'));
        $show->field('brand_id', __('Brand id'));
        $show->field('unit', __('Unit'));
        $show->field('status', __('状态'));
        $show->field('content', __('Content'));
        $show->field('keyword', __('Keyword'));
        $show->field('special_price', __('Special price'));
        $show->field('sell_price', __('Sell price'));
        $show->field('market_price', __('Market price'));
        $show->field('cost_price', __('Cost price'));
        $show->field('store_nums', __('Store nums'));
        $show->field('warning_line', __('Warning line'));
        $show->field('seo_title', __('Seo title'));
        $show->field('seo_keywords', __('Seo keywords'));
        $show->field('seo_description', __('Seo description'));
        $show->field('weight', __('Weight'));
        $show->field('point', __('Point'));
        $show->field('visit', __('Visit'));
        $show->field('favorite', __('Favorite'));
        $show->field('sort', __('序号'));
        $show->field('is_online', __('Is online'));
        $show->image('mainpic', __('Mainpic'));
        $show->field('img', __('Img'));
        $show->field('description', __('描述'));
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
        $form = new Form(new Goods);
        // dd(GoodsBrand::get()->pluck('name','id'));

        $form->number('cate_id', __('Cate id'));
        $form->text('name', __('名称'));
        $form->text('code', __('Code'));
        $form->select('type_id','商品类型')->options(GoodsType::get()->pluck('name','id'));
        $form->select('cate_id','商品分类')->options(GoodsCate::get()->pluck('name','id'));
        $form->select('brand_id','商品品牌')->options(GoodsBrand::get()->pluck('name','id'));
        $form->text('unit', __('Unit'));
        $form->switch('status', __('状态'));
        
        $form->text('keyword', __('Keyword'));
        $form->decimal('special_price', __('Special price'))->default(0.00);
        $form->decimal('sell_price', __('Sell price'))->default(0.00);
        $form->decimal('market_price', __('Market price'))->default(0.00);
        $form->decimal('cost_price', __('Cost price'))->default(0.00);
        $form->number('store_nums', __('Store nums'));
        $form->number('warning_line', __('Warning line'));
        $form->text('seo_title', __('Seo title'));
        $form->text('seo_keywords', __('Seo keywords'));
        $form->text('seo_description', __('Seo description'));
        $form->number('weight', __('Weight'));
        $form->number('point', __('Point'));
        $form->number('visit', __('Visit'));
        $form->number('favorite', __('Favorite'));
        $form->number('sort', __('序号'))->default(1);
        $form->switch('is_online', __('Is online'));
        $form->image('mainpic')->uniqueName();
        $form->multipleImage('img', '配图');
        $form->text('description', __('描述'));

        $form->ueditor('content', '内容');

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
