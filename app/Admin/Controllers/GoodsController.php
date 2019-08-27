<?php

namespace App\Admin\Controllers;

use App\Models\Goods;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

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
        // $grid->column('cate_id', __('Cate id'));
        $grid->column('name', __('Name'));
        $grid->column('code', __('Code'));
        // $grid->column('type_id', __('Type id'));
        // $grid->column('brand_id', __('Brand id'));
        $grid->column('unit', __('Unit'));
        $grid->column('status', __('Status'))->using(['1' => '启用', '-1' => '未启用', '-2' => '已删除']);
        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));
        // $grid->column('created_by', __('Created by'));
        // $grid->column('updated_by', __('Updated by'));
        // $grid->column('content', __('Content'));
        // $grid->column('img', __('Img'));
        $grid->column('keyword', __('Keyword'));
        // $grid->column('special_price', __('Special price'));
        // $grid->column('sell_price', __('Sell price'));
        $grid->column('market_price', __('Market price'));
        // $grid->column('cost_price', __('Cost price'));
        $grid->column('store_nums', __('Store nums'));
        // $grid->column('warning_line', __('Warning line'));
        // $grid->column('seo_title', __('Seo title'));
        // $grid->column('seo_keywords', __('Seo keywords'));
        // $grid->column('seo_description', __('Seo description'));
        // $grid->column('weight', __('Weight'));
        // $grid->column('point', __('Point'));
        // $grid->column('visit', __('Visit'));
        // $grid->column('favorite', __('Favorite'));
        $grid->column('sort', __('Sort'));
        $grid->column('is_online', __('Is online'));
        // $grid->column('sale_protection', __('Sale protection'));
        // $grid->column('pro_no', __('Pro no'));
        // $grid->column('products', __('Products'));
        $grid->column('mainpic', __('Mainpic'));
        // $grid->column('publish_time', __('Publish time'));
        // $grid->column('album_id', __('Album id'));
        // $grid->column('tags', __('Tags'));
        // $grid->column('description', __('Description'));
        $grid->column('like_count', __('Like count'));
        // $grid->column('is_book', __('Is book'));
        // $grid->column('expirytime', __('Expirytime'));
        // $grid->column('limit_start', __('Limit start'));
        // $grid->column('limit_end', __('Limit end'));
        // $grid->column('delivery', __('Delivery'));
        // $grid->column('bind_content', __('Bind content'));
        // $grid->column('etype', __('Etype'));
        // $grid->column('is_top', __('Is top'));
        // $grid->column('is_recommend', __('Is recommend'));
        // $grid->column('is_hot', __('Is hot'));
        // $grid->column('display_type', __('Display type'));
        // $grid->column('is_discount', __('Is discount'));
        // $grid->column('shop_count', __('Shop count'));
        // $grid->column('need_express_fee', __('Need express fee'));
        // $grid->column('express_fee_rate', __('Express fee rate'));
        // $grid->column('express_fee_rule', __('Express fee rule'));
        // $grid->column('min_price', __('Min price'));
        // $grid->column('max_price', __('Max price'));
        // $grid->column('instructions', __('Instructions'));
        // $grid->column('use_case', __('Use case'));
        // $grid->column('qrcode', __('Qrcode'));
        // $grid->column('inventory_operate', __('Inventory operate'));


        $grid->column('goodsType.name', __('类型'));
        $grid->column('goodsCate.name', __('分类'));
        $grid->column('goodsBrand.name', __('品牌'));


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
        $show->field('name', __('Name'));
        $show->field('code', __('Code'));
        $show->field('type_id', __('Type id'));
        $show->field('brand_id', __('Brand id'));
        $show->field('unit', __('Unit'));
        $show->field('status', __('Status'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('created_by', __('Created by'));
        $show->field('updated_by', __('Updated by'));
        $show->field('content', __('Content'));
        $show->field('img', __('Img'));
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
        $show->field('sort', __('Sort'));
        $show->field('is_online', __('Is online'));
        // $show->field('sale_protection', __('Sale protection'));
        // $show->field('pro_no', __('Pro no'));
        // $show->field('products', __('Products'));
        $show->field('mainpic', __('Mainpic'));
        // $show->field('publish_time', __('Publish time'));
        // $show->field('album_id', __('Album id'));
        // $show->field('tags', __('Tags'));
        $show->field('description', __('Description'));
        // $show->field('like_count', __('Like count'));
        // $show->field('is_book', __('Is book'));
        // $show->field('expirytime', __('Expirytime'));
        // $show->field('limit_start', __('Limit start'));
        // $show->field('limit_end', __('Limit end'));
        // $show->field('delivery', __('Delivery'));
        // $show->field('bind_content', __('Bind content'));
        // $show->field('etype', __('Etype'));
        // $show->field('is_top', __('Is top'));
        // $show->field('is_recommend', __('Is recommend'));
        // $show->field('is_hot', __('Is hot'));
        // $show->field('display_type', __('Display type'));
        // $show->field('is_discount', __('Is discount'));
        // $show->field('shop_count', __('Shop count'));
        // $show->field('need_express_fee', __('Need express fee'));
        // $show->field('express_fee_rate', __('Express fee rate'));
        // $show->field('express_fee_rule', __('Express fee rule'));
        // $show->field('min_price', __('Min price'));
        // $show->field('max_price', __('Max price'));
        // $show->field('instructions', __('Instructions'));
        // $show->field('use_case', __('Use case'));
        // $show->field('qrcode', __('Qrcode'));
        // $show->field('inventory_operate', __('Inventory operate'));

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

        $form->number('cate_id', __('Cate id'));
        $form->text('name', __('Name'));
        $form->text('code', __('Code'));
        $form->number('type_id', __('Type id'));
        $form->number('brand_id', __('Brand id'));
        $form->text('unit', __('Unit'));
        $form->switch('status', __('Status'));
        $form->number('created_by', __('Created by'));
        $form->number('updated_by', __('Updated by'));
        $form->textarea('content', __('Content'));
        $form->image('img', __('Img'));
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
        $form->number('sort', __('Sort'))->default(1);
        $form->switch('is_online', __('Is online'));
        // $form->textarea('sale_protection', __('Sale protection'));
        // $form->text('pro_no', __('Pro no'));
        // $form->textarea('products', __('Products'));
        $form->text('mainpic', __('Mainpic'));
        // $form->number('publish_time', __('Publish time'));
        // $form->number('album_id', __('Album id'));
        // $form->text('tags', __('Tags'));
        $form->text('description', __('Description'));
        // $form->number('like_count', __('Like count'));
        // $form->switch('is_book', __('Is book'));
        // $form->number('expirytime', __('Expirytime'));
        // $form->number('limit_start', __('Limit start'));
        // $form->number('limit_end', __('Limit end'));
        // $form->switch('delivery', __('Delivery'))->default(2);
        // $form->textarea('bind_content', __('Bind content'));
        // $form->switch('etype', __('Etype'));
        // $form->switch('is_top', __('Is top'));
        // $form->switch('is_recommend', __('Is recommend'));
        // $form->switch('is_hot', __('Is hot'));
        // $form->switch('display_type', __('Display type'))->default(1);
        // $form->switch('is_discount', __('Is discount'));
        // $form->number('shop_count', __('Shop count'));
        // $form->switch('need_express_fee', __('Need express fee'))->default(1);
        // $form->decimal('express_fee_rate', __('Express fee rate'))->default(1.00);
        // $form->text('express_fee_rule', __('Express fee rule'));
        // $form->decimal('min_price', __('Min price'))->default(0.00);
        // $form->decimal('max_price', __('Max price'))->default(0.00);
        // $form->textarea('instructions', __('Instructions'));
        // $form->textarea('use_case', __('Use case'));
        // $form->text('qrcode', __('Qrcode'));
        // $form->switch('inventory_operate', __('Inventory operate'));

        return $form;
    }
}
