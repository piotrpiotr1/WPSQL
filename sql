#Find the same orders

SELECT
post_id,
meta_value as "Customer Order Number",
count(meta_value) FROM `wp_postmeta`
where meta_key = 'id_order'

GROUP by meta_value
HAVING COUNT(meta_value)>1
ORDER BY `wp_postmeta`.`post_id`  DESC;

#Find orders without notes
SELECT  *
FROM    `wp_posts`
WHERE   ID NOT IN (SELECT comment_post_ID
                                FROM `wp_comments` )
and post_type = 'shop_order'
ORDER by ID DESC;


#Find zero values in orders (wrong meta serialization)
SELECT order_id FROM `wp_woocommerce_order_itemmeta` oim left join `wp_woocommerce_order_items` oi on oim.order_item_id = oi.order_item_id where oim.meta_key = '_line_total' and oim.meta_value = '0';


#Find error tax in orders (wrong meta serialization)

SELECT order_id
FROM `wp_woocommerce_order_items` AS oi
LEFT JOIN `wp_woocommerce_order_itemmeta` AS oim1 ON oi.order_item_id = oim1.order_item_id
LEFT JOIN `wp_woocommerce_order_itemmeta` AS oim2 ON oi.order_item_id = oim2.order_item_id
WHERE  oim1.meta_key = '_line_tax_data' AND oim1.meta_value = 'a:2:{s:5:"total";a:0:{}s:8:"subtotal";a:0:{}}'
