ActiveSupport.on_load(:active_record) do
  require_dependency 'category'
  require_dependency 'condition'
  require_dependency 'shipping_cost'
  require_dependency 'shipping_day'
  require_dependency 'prefecture'
end
