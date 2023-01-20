--The tables used while testing TDE
-----------------------------------------------------------------------------------------------------------------
--bidb.dim_product
CREATE TABLE [bidb].[dim_product_1]
(
	[id] [bigint] NULL,
	[sku_id] [bigint] NULL,
	[sku_code] [varchar](50) NULL,
	[vendor_article_number] [varchar](50) NULL,
	[style_id] [varchar](20) NULL,
	[style_name] [varchar](300) NULL,
	[style_status] [varchar](5) NULL,
	[article_number] [varchar](1000) NULL,
	[product_option_size] [varchar](140) NULL,
	[gender] [varchar](20) NULL,
	[season_code] [varchar](20) NULL,
	[season] [varchar](30) NULL,
	[year] [bigint] NULL,
	[brand_id] [varchar](64) NULL,
	[brand] [varchar](100) NULL,
	[brand_type] [varchar](100) NULL,
	[brand_group] [varchar](255) NULL,
	[supply_type] [varchar](63) NULL,
	[commercial_type] [varchar](255) NULL,
	[usage_attr] [varchar](100) NULL,
	[occasion_attr] [varchar](255) NULL,
	[fashion_type] [varchar](20) NULL,
	[base_colour] [varchar](100) NULL,
	[age_group] [varchar](100) NULL,
	[article_type_id] [bigint] NULL,
	[article_type] [varchar](255) NULL,
	[sub_category_id] [varchar](100) NULL,
	[sub_category] [varchar](100) NULL,
	[master_category_id] [varchar](100) NULL,
	[master_category] [varchar](100) NULL,
	[group_category] [varchar](100) NULL,
	[vendor_id] [bigint] NULL,
	[article_mrp] [float] NULL,
	[article_mrp_excl_tax] [float] NULL,
	[tax_rate] [float] NULL,
	[style_created_date] [bigint] NULL,
	[style_created_time] [bigint] NULL,
	[style_catalogued_date] [bigint] NULL,
	[style_catalogued_time] [bigint] NULL,
	[business_group] [varchar](255) NULL,
	[remarks] [varchar](255) NULL,
	[photoshoot_priority] [bigint] NULL,
	[photoshoot_rule_id] [bigint] NULL,
	[catalog_priority] [bigint] NULL,
	[catalog_rule_id] [bigint] NULL,
	[photoshoot_stn_barcode] [varchar](2000) NULL,
	[photoshoot_issue_date] [bigint] NULL,
	[photoshoot_issue_time] [bigint] NULL,
	[default_image] [varchar](1024) NULL,
	[first_inward_date] [bigint] NULL,
	[first_inward_time] [bigint] NULL,
	[last_inward_date] [bigint] NULL,
	[last_inward_time] [bigint] NULL,
	[gtin] [varchar](14) NULL,
	[category_head] [varchar](200) NULL,
	[category_manager] [varchar](2000) NULL,
	[cm_ownership] [varchar](255) NULL,
	[catalogue_manager] [varchar](2000) NULL,
	[current_discount] [varchar](256) NULL,
	[style_exclusive_flag] [varchar](7) NULL,
	[is_active] [smallint] NULL,
	[valid_from] [bigint] NULL,
	[valid_to] [bigint] NULL,
	[last_modified_on] [datetime2](7) NULL,
	[business_unit] [varchar](100) NULL,
	[category_manager_email] [varchar](200) NULL,
	[category_head_email] [varchar](200) NULL,
	[repex_name] [varchar](200) NULL,
	[repex_email] [varchar](200) NULL,
	[master_brand] [varchar](100) NULL,
	[catalog_live_date] [bigint] NULL,
	[hsn_code] [varchar](50) NULL,
	[myntra_hsn] [varchar](128) NULL,
	[vendor_hsn] [varchar](128) NULL,
	[size] [varchar](400) NULL,
	[myntra_size] [varchar](400) NULL,
	[inferred_size] [varchar](400) NULL,
	[unified_size] [varchar](400) NULL,
	[style_category] [varchar](255) NULL,
	[old_business_unit] [varchar](100) NULL,
	[vendor_article_name] [varchar](100) NULL,
	[manufacturer_info] [varchar](255) NULL,
	[country_of_origin] [varchar](255) NULL,
	[listing_status] [varchar](6) NULL,
	[seller_approval_status] [varchar](6) NULL,
	[platform_id] [bigint] NULL,
	[list_display_name] [varchar](255) NULL,
	[master_business_unit] [varchar](100) NULL,
	[sub_business_unit] [varchar](100) NULL,
	[sub_brand_type] [varchar](100) NULL
)
WITH
(
	DISTRIBUTION = HASH ( [sku_id] ),
	CLUSTERED INDEX
	(
		[sku_id] ASC,
		[platform_id] ASC
	)
)
GO
-----------------------------------------------------------------------------------------------------------------
copy into [bidb].[dim_product_1]
from 'https://myntrabi01.blob.core.windows.net/adw-commerce/tde/dim_product/*.parq.snappy'
 WITH
 (
  FILE_TYPE = 'PARQUET',
   CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=racwdli&st=2022-03-27T18:00:07Z&se=2022-03-29T02:00:07Z&sv=2020-08-04&sr=c&sig=hjotSpwT1QnYOGRmjLoncr%2BcVHSNY0%2BumTRVe8eyvHY%3D')
 );
-----------------------------------------------------------------------------------------------------------------
--bidb.fact_atp_inventory
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE [bidb].[fact_atp_inventory_1]
(
	[id] [bigint] NULL,
	[store_id] [bigint] NULL,
	[seller_id] [bigint] NULL,
	[supply_type] [varchar](15) NULL,
	[sku_id] [bigint] NULL,
	[sku_code] [varchar](128) NULL,
	[is_sku_active] [smallint] NULL,
	[style_id] [bigint] NULL,
	[style_status] [varchar](15) NULL,
	[inventory_count] [bigint] NULL,
	[blocked_order_count] [bigint] NULL,
	[is_live_on_portal] [smallint] NULL,
	[lead_time] [bigint] NULL,
	[enabled] [smallint] NULL,
	[last_synced_on] [datetime2](7) NULL,
	[available_in_warehouses] [varchar](128) NULL,
	[vendor_id] [bigint] NULL,
	[created_by] [varchar](50) NULL,
	[created_on] [datetime2](7) NULL,
	[src_last_modified_on] [datetime2](7) NULL,
	[version] [bigint] NULL,
	[is_active] [smallint] NULL,
	[last_modified_on] [datetime2](7) NULL,
	[blocked_order_count_from_oms] [bigint] NULL,
	[net_inventory_count_from_wms] [bigint] NULL,
	[overall_blocked_order_count_oms] [bigint] NULL,
	[inventory_count_from_wms] [bigint] NULL,
	[platform_id] [int] NULL,
	[listing_status] [varchar](6) NULL,
	[seller_approval_status] [varchar](6) NULL,
	[blocked_order_count_from_wms] [bigint] NULL,
	[buffered_inv_count] [int] NULL
)
WITH
(
	DISTRIBUTION = HASH ( [sku_id] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO
-----------------------------------------------------------------------------------------------------------------
copy into [bidb].[fact_atp_inventory_1]
from 'https://myntrabi01.blob.core.windows.net/adw-commerce/tde/fact_atp_inventory/*.parq.snappy'
 WITH
 (
  FILE_TYPE = 'PARQUET',
   CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=racwdli&st=2022-03-27T18:00:07Z&se=2022-03-29T02:00:07Z&sv=2020-08-04&sr=c&sig=hjotSpwT1QnYOGRmjLoncr%2BcVHSNY0%2BumTRVe8eyvHY%3D')
 );
-----------------------------------------------------------------------------------------------------------------
--Fact_core_item
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE [bidb].[Fact_core_item_1]
(
	[order_group_id] [bigint] NULL,
	[order_id] [bigint] NULL,
	[item_id] [bigint] NULL,
	[sku_id] [bigint] NULL,
	[style_id] [varchar](50) NULL,
	[core_item_id] [varchar](35) NULL,
	[store_id] [varchar](20) NULL,
	[store_line_id] [varchar](50) NULL,
	[store_release_id] [varchar](20) NULL,
	[seller_id] [varchar](15) NULL,
	[po_id] [varchar](100) NULL,
	[warehouse_id] [smallint] NULL,
	[pps_item_id] [varchar](30) NULL,
	[item_status] [varchar](10) NULL,
	[order_status] [varchar](10) NULL,
	[return_status] [varchar](64) NULL,
	[wms_item_status] [varchar](20) NULL,
	[is_booked] [smallint] NULL,
	[is_shipped] [smallint] NULL,
	[is_realised] [smallint] NULL,
	[is_returned] [smallint] NULL,
	[is_delivered] [smallint] NULL,
	[is_rto] [smallint] NULL,
	[is_exchange] [smallint] NULL,
	[return_id] [bigint] NULL,
	[rto_id] [bigint] NULL,
	[exchange_release_id] [bigint] NULL,
	[item_cancellation_reason_id] [bigint] NULL,
	[vendor_id] [bigint] NULL,
	[idproduct] [bigint] NULL,
	[brand_id] [varchar](64) NULL,
	[article_type_id] [bigint] NULL,
	[brand] [varchar](100) NULL,
	[brand_type] [varchar](50) NULL,
	[article_type] [varchar](255) NULL,
	[gender] [varchar](20) NULL,
	[master_category] [varchar](100) NULL,
	[supply_type] [varchar](15) NULL,
	[po_type] [varchar](30) NULL,
	[basis_of_margin] [varchar](30) NULL,
	[vendor_code] [varchar](20) NULL,
	[primary_vat] [float] NULL,
	[selling_vat_percentage] [numeric](6, 3) NULL,
	[agreed_buying_margin] [float] NULL,
	[tax_type] [varchar](9) NULL,
	[item_purchase_price_inc_tax] [float] NULL,
	[item_landed_price] [float] NULL,
	[unit_price_with_tax] [numeric](22, 4) NULL,
	[unit_price_without_tax] [numeric](22, 4) NULL,
	[order_quantity] [int] NULL,
	[quantity] [int] NULL,
	[product_discount] [float] NULL,
	[cart_discount] [float] NULL,
	[cashback_redeemed] [float] NULL,
	[coupon_discount] [float] NULL,
	[payment_gateway_discount] [float] NULL,
	[tax_usr_recovered] [float] NULL,
	[loyalty_pts_used] [float] NULL,
	[item_mrp_value] [float] NULL,
	[tax_rate] [numeric](22, 4) NULL,
	[shipping_charges] [float] NULL,
	[gift_charges] [numeric](12, 4) NULL,
	[cod_charges] [numeric](12, 4) NULL,
	[discount_id] [bigint] NULL,
	[discount_rule_id] [bigint] NULL,
	[discount_rule_rev_id] [bigint] NULL,
	[effective_discount_percent] [float] NULL,
	[funding_basis] [varchar](20) NULL,
	[discount_limit] [float] NULL,
	[funding_percentage] [float] NULL,
	[discount_funding] [varchar](40) NULL,
	[or_discount_rule_category_flag] [varchar](40) NULL,
	[sor_flag] [varchar](30) NULL,
	[item_revenue_inc_cashback] [float] NULL,
	[effective_discount] [float] NULL,
	[vendor_funded_trade_discount] [float] NULL,
	[vendor_funding] [numeric](22, 4) NULL,
	[tax] [float] NULL,
	[brand_margin] [numeric](22, 4) NULL,
	[vat_reimbursement] [float] NULL,
	[cogs] [numeric](22, 4) NULL,
	[entry_tax] [float] NULL,
	[royalty_commission] [float] NULL,
	[rgm_base] [numeric](12, 4) NULL,
	[rgm_royalty] [numeric](12, 4) NULL,
	[rgm_final] [numeric](12, 4) NULL,
	[is_refunded] [char](1) NULL,
	[refund_amount] [numeric](22, 4) NULL,
	[payment_method] [varchar](10) NULL,
	[order_created_by] [varchar](255) NULL,
	[idcustomer] [bigint] NULL,
	[order_created_date] [bigint] NULL,
	[order_created_time] [bigint] NULL,
	[order_release_created_date] [bigint] NULL,
	[order_queued_date] [bigint] NULL,
	[order_packed_date] [bigint] NULL,
	[order_packed_time] [bigint] NULL,
	[order_cancel_date] [bigint] NULL,
	[order_cancel_time] [bigint] NULL,
	[order_shipped_date] [bigint] NULL,
	[order_shipped_time] [bigint] NULL,
	[order_delivered_date] [bigint] NULL,
	[order_delivered_time] [bigint] NULL,
	[order_completed_date] [bigint] NULL,
	[restocked_date] [bigint] NULL,
	[restocked_time] [bigint] NULL,
	[order_rto_date] [bigint] NULL,
	[zipcode] [varchar](10) NULL,
	[address] [varchar](1) NULL,
	[idlocation] [bigint] NULL,
	[location_type] [varchar](200) NULL,
	[idcourier] [bigint] NULL,
	[courier_code] [varchar](1000) NULL,
	[warehouse_pincode] [bigint] NULL,
	[reverse_logistics_cost] [float] NULL,
	[total_individual_logistics_cost] [float] NULL,
	[logistics_cost] [float] NULL,
	[last_modified_on] [datetime2](7) NULL,
	[avg_sku_age] [bigint] NULL,
	[is_vendor_exception] [smallint] NULL,
	[is_try_and_buy] [int] NULL,
	[customer_promise_datetime] [datetime2](7) NULL,
	[on_hold_reason_id_fk] [smallint] NULL,
	[shipment_cancellation_reason_id] [bigint] NULL,
	[gift_card_amount] [numeric](22, 4) NULL,
	[vat_adj_refund_amount] [numeric](12, 4) NULL,
	[vat_adj_pps_id] [varchar](65) NULL,
	[final_amount] [numeric](22, 4) NULL,
	[sale_order_item_code] [varchar](30) NULL,
	[wallet_redeemed] [float] NULL,
	[nsv_item_purchase_price_inc_tax] [float] NULL,
	[charges_paid_by_loyalty_pts] [float] NULL,
	[charges_paid_by_giftcard] [float] NULL,
	[charges_paid_by_wallet] [float] NULL,
	[refund_neft] [numeric](12, 4) NULL,
	[refund_loyalty] [numeric](12, 4) NULL,
	[refund_gc_amount] [numeric](12, 4) NULL,
	[refund_wallet] [numeric](12, 4) NULL,
	[charges_refund_by_wallet] [float] NULL,
	[charges_refund_by_loyalty_pts] [float] NULL,
	[is_first_order] [char](1) NULL,
	[is_first_brand_order] [char](1) NULL,
	[store_order_id] [varchar](50) NULL,
	[coupon_code] [varchar](60) NULL,
	[actual_promise_datetime] [datetime2](7) NULL,
	[packaging_cost] [numeric](22, 4) NULL,
	[payment_gateway_cost] [numeric](22, 4) NULL,
	[warehouse_cost] [numeric](22, 4) NULL,
	[customer_care_cost] [numeric](22, 4) NULL,
	[device_id] [varchar](120) NULL,
	[advertising_id] [varchar](80) NULL,
	[bi_last_modified_on] [datetime2](7) NULL,
	[cgst_tax_rate] [numeric](22, 4) NULL,
	[cgst_tax_amount] [float] NULL,
	[sgst_tax_rate] [numeric](22, 4) NULL,
	[sgst_tax_amount] [float] NULL,
	[igst_tax_rate] [numeric](22, 4) NULL,
	[igst_tax_amount] [float] NULL,
	[mynts_used] [float] NULL,
	[bank_discount_used] [float] NULL,
	[refund_mynts] [numeric](12, 4) NULL,
	[refund_bank_discount] [numeric](12, 4) NULL,
	[charges_refund_by_bank_discount] [float] NULL,
	[charges_paid_by_bank_discount] [float] NULL,
	[item_inward_date] [bigint] NULL,
	[buyer_id] [bigint] NULL,
	[virtual_sku_id] [varchar](30) NULL,
	[virtual_style_id] [varchar](20) NULL,
	[lmc_warehouse_id] [bigint] NULL,
	[packet_id] [bigint] NULL,
	[store_credit_used] [float] NULL,
	[charges_paid_by_store_credit] [float] NULL,
	[refund_store_credit] [numeric](12, 4) NULL,
	[charges_refund_by_store_credit] [float] NULL,
	[seller_type] [varchar](45) NULL,
	[seller_terms_id] [bigint] NULL,
	[latest_terms_id] [bigint] NULL,
	[commission] [numeric](18, 2) NULL,
	[forward_logistics_revenue] [bigint] NULL,
	[reverse_logistics_revenue] [bigint] NULL,
	[source_owner_id] [bigint] NULL,
	[platform_charges] [numeric](12, 4) NULL,
	[additional_charges] [numeric](12, 4) NULL,
	[additional_discounts] [numeric](12, 4) NULL,
	[unified_address_id] [varchar](255) NULL,
	[user_agent_id] [int] NULL,
	[platform_id] [bigint] NULL,
	[actual_cogs] [numeric](22, 4) NULL,
	[actual_item_purchase_price] [float] NULL,
	[payment_group_id] [varchar](255) NULL,
	[transactionid] [varchar](256) NULL
)
WITH
(
	DISTRIBUTION = HASH ( [item_id] ),
	CLUSTERED COLUMNSTORE INDEX ORDER ([order_created_date])
)
GO
-----------------------------------------------------------------------------------------------------------------
copy into [bidb].[Fact_core_item_1]
from 'https://myntrabi01.blob.core.windows.net/adw-commerce/one/*.parq.snappy'
 WITH
 (
  FILE_TYPE = 'PARQUET',
   CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=racwdli&st=2022-03-27T18:00:07Z&se=2022-03-29T02:00:07Z&sv=2020-08-04&sr=c&sig=hjotSpwT1QnYOGRmjLoncr%2BcVHSNY0%2BumTRVe8eyvHY%3D')
 );
-----------------------------------------------------------------------------------------------------------------
--fact_inventory_item
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE [bidb].[fact_inventory_item_1]
(
	[core_item_id] [numeric](19, 0) NULL,
	[sku_id] [bigint] NULL,
	[order_id] [numeric](19, 0) NULL,
	[item_barcode] [numeric](19, 0) NULL,
	[item_purchase_price] [float] NULL,
	[enabled] [bigint] NULL,
	[quality] [varchar](4) NULL,
	[item_status] [varchar](20) NULL,
	[lot_id] [bigint] NULL,
	[po_sku_id] [bigint] NULL,
	[grn_sku_id] [bigint] NULL,
	[po_barcode] [varchar](50) NULL,
	[grn_barcode] [varchar](50) NULL,
	[po_id] [bigint] NULL,
	[warehouse_id] [bigint] NULL,
	[item_purchase_price_inc_tax] [float] NULL,
	[zone_id] [numeric](19, 0) NULL,
	[section_id] [numeric](19, 0) NULL,
	[bin_id] [numeric](19, 0) NULL,
	[bin_barcode] [varchar](20) NULL,
	[carton_barcode] [varchar](20) NULL,
	[lot_barcode] [varchar](50) NULL,
	[inward_date] [bigint] NULL,
	[inward_time] [bigint] NULL,
	[internal_order_id] [varchar](20) NULL,
	[reject_reason_code] [varchar](30) NULL,
	[reject_reason_description] [varchar](200) NULL,
	[rejected_date] [bigint] NULL,
	[rejected_time] [bigint] NULL,
	[action_status] [varchar](30) NULL,
	[rejected_at] [varchar](30) NULL,
	[last_modified_on] [datetime2](7) NULL,
	[item_last_modified_on] [datetime2](7) NULL,
	[rejected_item_last_modified_on] [datetime2](7) NULL,
	[store_id] [smallint] NULL,
	[item_action_status] [varchar](50) NULL,
	[return_order_id] [bigint] NULL,
	[invoice_sku_id] [numeric](19, 0) NULL,
	[buyer_id] [numeric](19, 0) NULL,
	[platform_id] [bigint] NULL,
	[source_owner_id] [bigint] NULL,
	[store_platform_id] [bigint] NULL,
	[source_type] [varchar](50) NULL,
	[inward_request_id] [bigint] NULL,
	[id] [numeric](19, 0) NULL,
	[src_inward_date] [bigint] NULL,
	[actual_item_purchase_price] [float] NULL,
	[tax_amount] [float] NULL,
	[actual_item_purchase_price_inc_tax] [float] NULL,
	[item_type] [varchar](50) NULL
)
WITH
(
	DISTRIBUTION = HASH ( [sku_id] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO
-----------------------------------------------------------------------------------------------------------------
copy into [bidb].[fact_inventory_item_1]
from 'https://myntrabi01.blob.core.windows.net/adw-commerce/tde/fact_inventory_item/*.parq.snappy'
 WITH
 (
  FILE_TYPE = 'PARQUET',
   CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=racwdli&st=2022-03-27T18:00:07Z&se=2022-03-29T02:00:07Z&sv=2020-08-04&sr=c&sig=hjotSpwT1QnYOGRmjLoncr%2BcVHSNY0%2BumTRVe8eyvHY%3D')
 );
-----------------------------------------------------------------------------------------------------------------











