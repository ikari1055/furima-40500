ActiveSupport.on_load(:active_record) do
  require_dependency 'product_category'
  require_dependency 'condition'
  require_dependency 'shipping_cost'
  require_dependency 'shipping_days'
  require_dependency 'prefecture'
end
