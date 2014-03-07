json.array! @poster_data do |poster|
    json.extract! poster, :ad_id, :outlet_id, :distance, :area_name, :city_name, :pincode, :latitude, :longitude, :shop_no, :address, :mobile_number, :phone_number, :ad_is_exclusive, :brand_name, :ad_usage, :ad_expiry_date #:brand
end
