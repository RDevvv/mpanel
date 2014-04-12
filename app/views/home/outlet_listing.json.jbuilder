json.array! @poster_data do |poster|
    json.extract! poster, :is_unlocked, :brand_image, :ad_id, :sms_text, :ad_title, :outlet_id, :distance, :area_name, :city_name, :pincode, :latitude, :longitude, :shop_no, :address, :mobile_number, :phone_number, :ad_is_exclusive, :brand_name, :ad_usage, :ad_expiry_date #:brand
    json.customer do |c|
        c.latitude @location[:latitude]
        c.longitude @location[:longitude]
    end
end
