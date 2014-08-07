json.product do
    json.id @product.id
    json.name @product.name
    json.description @product.description
    json.price @product.price
    json.product_comments_count @product.product_comments_count
    json.product_likes_count @product.product_likes_count
    json.image_url @product.attachments.first.image_url
end
json.comments @product.product_comments.each do |comment|
    json.comment comment.comment
    json.commentor_name comment.customer.name
    json.commentor_mobile_number comment.customer.mobile_number
end
